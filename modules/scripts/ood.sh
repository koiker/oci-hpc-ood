#!/bin/bash

# Check if OOD_DNS environment variable exists
if [ -z "${OOD_DNS}" ]; then
    echo "Error: OOD_DNS environment variable is not set. Public IP is required."
    exit 1
fi

if [ -z "${OOD_USERNAME}" ]; then
    echo "Error: OOD_USERNAME environment variable is not set. Username is required."
    exit 1
fi
CRYPTO_PASSPHRASE=$(openssl rand -hex 40)

# Update system and install EPEL repository
sudo dnf update -y
sudo dnf install -y epel-release
# sudo dnf module enable -y ruby:3.1 nodejs:18
sudo dnf module enable -y ruby:3.3 nodejs:20

# Enable CodeReady and Developer Toolset repositories
sudo dnf config-manager --enable ol8_codeready_builder ol8_distro_builder ol8_developer

# Install Open OnDemand
# sudo dnf install -y https://yum.osc.edu/ondemand/3.1/ondemand-release-web-3.1-1.el8.noarch.rpm
sudo dnf install -y https://yum.osc.edu/ondemand/4.0/ondemand-release-web-4.0-1.el8.noarch.rpm
sudo dnf install -y rclone
sudo dnf install -y ondemand

# Install Apache OIDC module
sudo dnf install mod_auth_openidc -y
sudo systemctl enable httpd

# Configure firewall
sudo firewall-cmd --zone=public --permanent --add-port=80/tcp
sudo firewall-cmd --zone=public --permanent --add-port=443/tcp
sudo firewall-cmd --reload

# Install Python Pyenv dependencies
sudo dnf install git sqlite-devel readline-devel libffi-devel bzip2-devel -y

# Install dependencies required by certbot
sudo dnf install -y augeas-libs libxml2-devel augeas-devel

# Update Pip
python3 -m pip install --upgrade pip
# Install Certbot
pip3 install certbot

# Stop web server
systemctl stop httpd

# Generate certificate
/usr/local/bin/certbot certonly --standalone --non-interactive --agree-tos -m rafael.koike@oracle.com --cert-name $OOD_DNS -d $OOD_DNS --webroot-path /

# Add certbot renewal to crontab
echo "0 0,12 * * * root /opt/certbot/bin/python -c 'import random; import time; time.sleep(random.random() * 3600)' && sudo certbot renew -q" | sudo tee -a /etc/crontab > /dev/null

# Configure OOD user
sudo adduser -m $OOD_USERNAME


# Create OOD portal config
cat << EOF > /etc/ood/config/ood_portal.yml
---
servername: ${OOD_DNS}
# Use OIDC authentication
auth:
  - "AuthType openid-connect"
  - "Require valid-user"
# Use OIDC logout
logout_redirect: "/oidc?logout=https%3A%2F%2F${OOD_DNS}%2F"
oidc_uri: "/oidc"
oidc_provider_metadata_url: "${IDCS_URL}/.well-known/openid-configuration"
oidc_client_id: "${CLIENT_ID}"
oidc_client_secret: "${CLIENT_SECRET}"
oidc_remote_user_claim: "sub"
oidc_scope: "urn:opc:idm:t.user.me openid email"
oidc_session_inactivity_timeout: 28800
oidc_session_max_duration: 28800
oidc_state_max_number_of_cookies: "10 true"
oidc_settings:
  OIDCPassIDTokenAs: "serialized"
  OIDCPassRefreshToken: "On"
  OIDCPassClaimsAs: "environment"
  OIDCStripCookies: "mod_auth_openidc_session mod_auth_openidc_session_chunks mod_auth_openidc_session_0 mod_auth_openidc_session_1"
  OIDCResponseType: "code"

ssl:
  - 'SSLCertificateFile "/etc/letsencrypt/live/${OOD_DNS}/fullchain.pem"'
  - 'SSLCertificateKeyFile "/etc/letsencrypt/live/${OOD_DNS}/privkey.pem"'
EOF

# Create Apache OIDC config
cat << EOF > /etc/httpd/conf.d/auth_openidc.conf
# Apache auth_openidc.conf
OIDCProviderMetadataURL ${IDCS_URL}/.well-known/openid-configuration
OIDCClientID ${CLIENT_ID}
OIDCClientSecret ${CLIENT_SECRET}
OIDCRedirectURI https://${OOD_DNS}/oidc
OIDCCryptoPassphrase ${CRYPTO_PASSPHRASE}
OIDCScope "urn:opc:idm:t.user.me openid email"
EOF

# Update Apache config based on ood_portal.yml file
/opt/ood/ood-portal-generator/sbin/update_ood_portal

# Restart Apache service
sudo systemctl restart httpd
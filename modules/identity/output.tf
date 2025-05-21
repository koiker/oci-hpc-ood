// Copyright (c) 2025, Oracle and/or its affiliates. All rights reserved.
// Authors: Germain Vargas, Rafael Marcelino Koike, Martin Feyereisen

output "ood_url" {
  value = "https://ood-${replace(var.ood_public_ip, ".", "-")}.nip.io"
}

output "app_client_id" {
  value = oci_identity_domains_app.ood_app.name
}

output "idcs_endpoint" {
  value = oci_identity_domain.idcs_domain.url
}

output "app_client_secret" {
  value = oci_identity_domains_app.ood_app.client_secret
}

output "openid_configuration_url" {
  value = "${oci_identity_domain.idcs_domain.url}/.well-known/openid-configuration"
}
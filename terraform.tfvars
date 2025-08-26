// Copyright (c) 2025, Oracle and/or its affiliates. All rights reserved.
// Authors: Germain Vargas, Rafael Marcelino Koike, Martin Feyereisen

# Map with compartment name and compartment ocid in which resources will be deployed
compartment_id = "ocid1.tenancy.oc1..aaaaaaaa2l6fcfl7tfoun3i72tw4rjx4pja5lo7g5iakvptjzmuezihnr27q"

# Local paths to the ssh keys used to ssh on the bastion and nodes
ssh_keys = {
  ssh_public_key  = "~/koiker-oci-ashburn.key.pub"
  ssh_private_key = "~/koiker-oci-ashburn.key"
}

####### Networking #######

vcn_display_name = "hpc_VCN"

vcn_id = "ocid1.vcn.oc1.iad.amaaaaaatyq6jnyavb3ja23nsq2bpau2s6v2rccdxxdduoz7ggo53s24jdpq"

####### ood & identity variables #######

domain_name = "ood-identity-domain"

ood_username = "koiker"

ood_user_email = "koike.rafael@gmail.com"

ood_user_password = "iloveoracle!"

##### ood module #####

ood_ad = "iLlE:US-ASHBURN-AD-1"
targetCompartment = "root"
subnet_ocid = "ocid1.subnet.oc1.iad.aaaaaaaaakgs2mazuyioet2widoyyjgodbh7nfuadu5pe7y7sjoyuqugojta"
cluster_name = "OpenFOAM-Cluster"
ood_shape = "VM.Standard.E3.Flex"
ood_ocpus = 2
ood_memory = 16
ood_boot_volume_size = 50
ood_image_ocid = "ocid1.image.oc1.iad.aaaaaaaatf3vyxzq3pv5jugwixnmnmh7aivqyhtlwalmgwquvp7c4npuy2ba"
ssh_key = "ssh_private_key"



#### Identity module #####

#idcs_settings
timezone = "America/New_York"
schemas = ["urn:ietf:params:scim:schemas:oracle:idcs:Settings"]
setting_id = "Settings"
csr_access = "none"
# ood_app
ood_display_name = "ood"
ood_schemas = ["urn:ietf:params:scim:schemas:oracle:idcs:App"]
active = true
allowed_grants = ["authorization_code", "client_credentials"]
client_type = "confidential"
is_oauth_client = true
force_delete = true
show_in_my_apps = true
client_ip_checking = "anywhere"
# user
user_schemas = ["urn:ietf:params:scim:schemas:core:2.0:User"]
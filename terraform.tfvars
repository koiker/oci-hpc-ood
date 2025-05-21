// Copyright (c) 2025, Oracle and/or its affiliates. All rights reserved.
// Authors: Germain Vargas, Rafael Marcelino Koike, Martin Feyereisen

# Map with compartment name and compartment ocid in which resources will be deployed

compartment_id = "compartment ocid"                    #change this to the ocid of your compartment

# Local paths to the ssh keys used to ssh on the bastion and nodes
ssh_keys = {
  ssh_public_key  = "/path/to/keys"                         #change this to the path of your public key
  ssh_private_key = "/path/to/keys"                        #change this to the path of your private key
}

####### Networking #######

vcn_display_name = "name of the existing VCN"               #change this to the name of your existing VCN

vcn_id = "existing_vcn_ocid"                                #change this to the ocid of your existing VCN

####### ood & identity variables #######

domain_name = "ood-identity-domain"

ood_username = "ood_user"

ood_user_email = "your email address"

ood_user_password = "ilovehpc@oracle"                       #change this to the password you want to use for the ood user

##### ood module #####

ood_ad = 1
targetCompartment = "comp1-ocid"
subnet_ocid = "subnet-ocid"                                 #change this to the ocid of your subnet
cluster_name = "OpenFOAM-Cluster"                           #change this to the name of your cluster
ood_shape = "VM.Standard.E4.Flex"
ood_ocpus = 2
ood_memory = 16
ood_boot_volume_size = 50
ood_image_ocid = "image-ocid"                               #change this to the ocid of your image based on the region



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
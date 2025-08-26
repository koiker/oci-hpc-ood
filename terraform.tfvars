// Copyright (c) 2025, Oracle and/or its affiliates. All rights reserved.
// Authors: Germain Vargas, Rafael Marcelino Koike, Martin Feyereisen

# Map with compartment name and compartment ocid in which resources will be deployed

compartment_id = "ocid1.compartment.oc1..aaaaaaaan4jtye7w3sotkey4qdp2df3ptrzby3ygyw6dc2gvfpw57cdxinmq" #change this to the ocid of your compartment

# Local paths to the ssh keys used to ssh on the bastion and nodes
ssh_keys = {
  ssh_public_key  = "/Users/germainv/Desktop/OCI/ssh.key.pub"                                          #change this to the path of your public key
  ssh_private_key = "/Users/germainv/Desktop/OCI/ssh.key"                                              #change this to the path of your private key
}

####### Networking #######

vcn_display_name = "openfoam-vcn-phx"                                                            #change this to the name of your existing VCN
# phx = openfoam-vcn-phx
# iad = OpenFOAM-VCN

vcn_id = "ocid1.vcn.oc1.phx.amaaaaaanx7g5qqamskab4kkelncvc2nwehksh2ggo5obbnbb7mgpgiqqlwa"    #change this to the ocid of your existing VCN
# phx = ocid1.vcn.oc1.phx.amaaaaaanx7g5qqamskab4kkelncvc2nwehksh2ggo5obbnbb7mgpgiqqlwa
# iad = ocid1.vcn.oc1.iad.amaaaaaanx7g5qqax2lzgjy2qijjp3uhhaz6g3nbmm6a5qsd6spbaqw5g4nq

####### ood & identity variables #######

domain_name = "ood-identity-domain"
ood_username = "ood_user"
ood_user_email = "germain.vargas@oracle.com"               #change this to the email you want to use for the ood user
ood_user_password = "ilovehpc@oracle"                       #change this to the password you want to use for the ood user

##### ood module #####

ood_ad = 1
ood_region = "us-phoenix-1"                                  #change this to the region you want to deploy the cluster in
subnet_ocid = "ocid1.subnet.oc1.phx.aaaaaaaaazzm2ywdh5u66xew6m5wizy7znahguv4sa6n72ob4oezmars5ukq"                                 #change this to the ocid of your subnet
# phx = ocid1.subnet.oc1.phx.aaaaaaaaazzm2ywdh5u66xew6m5wizy7znahguv4sa6n72ob4oezmars5ukq
# iad = ocid1.subnet.oc1.iad.aaaaaaaaoypqx7vv2docgd74cxc52pbfsjfr4vpsqnips6vqksquyn4e6hfa

cluster_name = "HPC-Cluster"                           #change this to the name of your cluster
ood_shape = "VM.Standard.E4.Flex"
ood_ocpus = 2
ood_memory = 16
ood_boot_volume_size = 50
ood_image_ocid = "ocid1.image.oc1.phx.aaaaaaaafp2p2j32mpn6t2mqfoxpfynthm3heztxby3rbmnlwfbse66yjxiq"                               #change this to the ocid of your image based on the region

# iad = ocid1.image.oc1.iad.aaaaaaaaakgxvw456mvvxi6jhustteys2lz2xw6kkn37ikonlpb3rzmj7mfq
# phx = ocid1.image.oc1.phx.aaaaaaaafp2p2j32mpn6t2mqfoxpfynthm3heztxby3rbmnlwfbse66yjxiq

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
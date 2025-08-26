// Copyright (c) 2025, Oracle and/or its affiliates. All rights reserved.
// Authors: Germain Vargas, Rafael Marcelino Koike, Martin Feyereisen

# OCI provider initalization
provider "oci" {
  tenancy_ocid     = var.provider_oci.tenancy
  user_ocid        = var.provider_oci.user_id
  fingerprint      = var.provider_oci.fingerprint
  private_key_path = var.provider_oci.key_file_path
  region           = var.provider_oci.region
}

# Define the data source for availability domains
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_id
}

<<<<<<< HEAD
=======
# # define the data source for the VCN
# data "oci_core_vcn" "existing_vcn" {
#   vcn_id = var.vcn_id
#   subnet_ids =
# }

>>>>>>> 848bab6 (Initialize Terraform project with configs, modules, and state files)
module "controller" {
    source = "./modules/controller"
    compartment_id = var.compartment_id
    region = var.provider_oci.region
    ssh_keys = var.ssh_keys
    ood_ad = var.ood_ad
    subnet_ocid = var.subnet_ocid
    cluster_name = var.cluster_name
    ood_shape = var.ood_shape
    ood_ocpus = var.ood_ocpus
    ood_memory = var.ood_memory
    ood_boot_volume_size = var.ood_boot_volume_size
    ood_image_ocid = var.ood_image_ocid
    ood_username = var.ood_username
    ood_user_email = var.ood_user_email
    ood_user_password = var.ood_user_password

    app_client_id = module.identity.app_client_id
    app_client_secret = module.identity.app_client_secret
    idcs_endpoint = module.identity.idcs_endpoint
}

module "identity" {
    source = "./modules/identity"
    compartment_id = var.compartment_id
    region = var.provider_oci.region
    domain_name = var.domain_name
    timezone = var.timezone
    schemas = var.schemas
    setting_id = var.setting_id
    csr_access = var.csr_access
    ood_display_name = var.ood_display_name
    ood_username = var.ood_username
    ood_user_email = var.ood_user_email
    ood_schemas = var.ood_schemas
    active = var.active
    allowed_grants = var.allowed_grants
    is_oauth_client = var.is_oauth_client
    client_type = var.client_type
    force_delete = var.force_delete
    show_in_my_apps = var.show_in_my_apps
    client_ip_checking = var.client_ip_checking
    user_schemas = var.user_schemas

    ood_public_ip = module.controller.ood_public_ip

}
// Copyright (c) 2025, Oracle and/or its affiliates. All rights reserved.
// Authors: Germain Vargas, Rafael Marcelino Koike, Martin Feyereisen

# Login credentials
variable "provider_oci" {       #map of strings for the OCI provider
  type = map(string)
}

variable "compartment_id" {    #map of strings for the Compartment IDs
  type = string
}

variable "ssh_keys" {           #map of strings for SSH Key pairs for VMs
  type = map(string)
  sensitive = true
}

variable "vcn_display_name" {
  description = "The display name of the existing VCN."
  type        = string
}

variable "vcn_id" {
  description = "The OCID of the existing VCN."
  type        = string
}

# ood varaibles

variable "domain_name" {
  type        = string
}

variable "ood_user_email" {
  type        = string
}

variable "ood_username" {
  type        = string
}

variable "ood_user_password" {
  type        = string
}

variable "ood_ad" {
  type        = number
}

variable "subnet_ocid" {
  type        = string
}

variable "targetCompartment" {
  type        = string
}

variable "cluster_name" {
  type        = string
}

variable "ood_shape" {
  type        = string
}

variable "ood_ocpus" {
  type        = number
}

variable "ood_memory" {
  type        = number
}

variable "ood_boot_volume_size" {
  type        = number
}

variable "ood_image_ocid" {
  type        = string
}

#### identity variables #####

variable "timezone" {
  type        = string
}

variable "schemas" {
  type        = list(string)
}

variable "setting_id" {
  type        = string
}

variable "csr_access" {
  type        = string
}

variable "ood_display_name" {
  type        = string
}

variable "ood_schemas" {
  type        = list(string)
}

variable "active" {
  type        = bool
}

variable "allowed_grants" {
  type        = list(string)
}

variable "client_type" {
  type        = string
}

variable "is_oauth_client" {
  type        = bool
}

variable "force_delete" {
  type        = bool
}

variable "show_in_my_apps" {
  type        = bool
}

variable "client_ip_checking" {
  type        = string
}

variable "user_schemas" {
  type        = list(string)
}
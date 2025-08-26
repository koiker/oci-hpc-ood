// Copyright (c) 2025, Oracle and/or its affiliates. All rights reserved.
// Authors: Germain Vargas, Rafael Marcelino Koike, Martin Feyereisen

# idcs_domain

variable "compartment_id" {    #Provide the compartment where ood will be provisioned
  type = string
}

variable "domain_name" {
  description = "The display name of the identity domain."
  type        = string
}

variable "region" {
  description = "The home region for the identity domain."
  type        = string
}

variable "ood_username" {
  description = "The username for the OOD user."
  type        = string
}

variable "ood_user_email" {
  description = "The email address for the OOD user."
  type        = string
}


#### identity variables #####

variable "timezone" {
  type        = string
}

variable "schemas" {
  type        = list(string)
  default     = ["urn:ietf:params:scim:schemas:oracle:idcs:Settings"]
  description = "The schema for the identity domain settings."
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
  default     = ["urn:ietf:params:scim:schemas:oracle:idcs:App"]
  description = "The schema for the OOD application."
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
  default     = ["urn:ietf:params:scim:schemas:core:2.0:User"]
  description = "The schema for the user."
}

#### ood instance variables #####

variable "ood_public_ip" {
  description = "The public IP address of the OOD instance."
  type        = string
}


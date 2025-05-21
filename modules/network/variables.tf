// Copyright (c) 2025, Oracle and/or its affiliates. All rights reserved.
// Authors: Germain Vargas, Rafael Marcelino Koike, Martin Feyereisen

variable "vcn_display_name" {
  description = "The display name of the existing VCN."
  type        = string
}

variable "vcn_id" {
  description = "The OCID of the existing VCN."
  type        = string
}

variable "compartment_id" {
  description = "The OCID of the compartment in which to create the resources."
  type        = string
}


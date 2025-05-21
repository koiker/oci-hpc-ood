// Copyright (c) 2025, Oracle and/or its affiliates. All rights reserved.
// Authors: Germain Vargas, Rafael Marcelino Koike, Martin Feyereisen

data "oci_core_vcn" "existing_vcn" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = var.vcn_display_name
}

resource "oci_core_subnet" "example_subnet" {
  compartment_id = var.compartment_id
  vcn_id         = data.oci_core_vcn.existing_vcn.id
  cidr_block     = "10.0.1.0/24"
  display_name   = "example_subnet"
  dns_label      = "example-subnet"
}
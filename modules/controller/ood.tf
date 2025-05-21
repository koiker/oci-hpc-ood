// Copyright (c) 2025, Oracle and/or its affiliates. All rights reserved.
// Authors: Germain Vargas, Rafael Marcelino Koike, Martin Feyereisen

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_id
}

resource "oci_core_instance" "ood" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[var.ood_ad].name
  compartment_id      = var.compartment_id
  display_name        = "${var.cluster_name}-ood"
  shape               = var.ood_shape

  create_vnic_details {
    subnet_id        = var.subnet_ocid
    assign_public_ip = true
  }

  source_details {
    source_type = "image"
    source_id   = var.ood_image_ocid
    boot_volume_size_in_gbs = var.ood_boot_volume_size
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_keys["ssh_public_key"])
  }

  shape_config {
    ocpus         = var.ood_ocpus
    memory_in_gbs = var.ood_memory
  }

  freeform_tags = {
    "cluster_name" = var.cluster_name
    "role"         = "ood"
  }
}

resource "random_string" "random_secret" {
  length           = 32
  special          = false
}

locals {
  ood_public_dns = "ood-${replace(oci_core_instance.ood.public_ip, ".", "-")}.nip.io"
}

resource "null_resource" "remote-exec" {
  depends_on = [oci_core_instance.ood]

  # Provisioner to install and configure Open OnDemand
  provisioner "remote-exec" {

    inline = [
      # Download and install the latest version of Open OnDemand
      "wget https://raw.githubusercontent.com/koiker/oci-hpc/master/scripts/ood.sh",
      "chmod +x ood.sh",
      "sudo OOD_DNS=${local.ood_public_dns} OOD_USERNAME=${var.ood_username} CLIENT_ID=${var.app_client_id} CLIENT_SECRET=${var.app_client_secret} IDCS_URL=${var.idcs_endpoint} ./ood.sh",
      "echo 'Customizing UI'",
      "wget https://raw.githubusercontent.com/koiker/oci-hpc/master/scripts/customize_ui.sh",
      "chmod +x customize_ui.sh",
      "sudo ./customize_ui.sh",

    ]

    connection {
      type        = "ssh"
      user        = "opc"
      private_key = file(var.ssh_keys["ssh_private_key"])
      host        = oci_core_instance.ood.public_ip
    }
  }
}
// Copyright (c) 2025, Oracle and/or its affiliates. All rights reserved.
// Authors: Germain Vargas, Rafael Marcelino Koike, Martin Feyereisen

output "ood_private_ip" {
  value = oci_core_instance.ood.private_ip
}

output "ood_public_ip" {
  value = oci_core_instance.ood.public_ip
}

output "ood_boostrap_cmd" {
  value = "sudo OOD_DNS=${local.ood_public_dns} OOD_USERNAME=${var.ood_username} CLIENT_ID=${var.app_client_id} CLIENT_SECRET=${var.app_client_secret} IDCS_URL=${var.idcs_endpoint} ./ood_ol9.sh"
}
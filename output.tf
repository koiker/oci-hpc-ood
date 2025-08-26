// Copyright (c) 2025, Oracle and/or its affiliates. All rights reserved.
// Authors: Germain Vargas, Rafael Marcelino Koike, Martin Feyereisen
output "ood_url" {
  value = module.identity.ood_url
}

output "ood_boostrap_cmd" {
  value = module.controller.ood_boostrap_cmd
}

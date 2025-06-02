// Copyright (c) 2025, Oracle and/or its affiliates. All rights reserved.
// Authors: Germain Vargas, Rafael Marcelino Koike, Martin Feyereisen

resource "oci_identity_domain" "idcs_domain" {

  compartment_id= var.compartment_id
  display_name  = var.domain_name
  description   = "IDCS domain for OOD authentication"
  home_region   = "${var.region}"
  license_type  = "premium" # The license type can be "free" or "premium"
}

resource "oci_identity_domains_setting" "idcs_settings" {

  # Optional attributes
  signing_cert_public_access = true
  timezone = var.timezone
  # Required attributes
  schemas =  var.schemas                                               #["urn:ietf:params:scim:schemas:oracle:idcs:Settings"]
  setting_id =  var.setting_id
  idcs_endpoint = oci_identity_domain.idcs_domain.url
  csr_access = var.csr_access
}

resource "oci_identity_domains_app" "ood_app" {

  display_name = var.ood_display_name
  description = "Identity Domain application"
  idcs_endpoint = oci_identity_domain.idcs_domain.url
  schemas = var.ood_schemas                                             #["urn:ietf:params:scim:schemas:oracle:idcs:App"]
  based_on_template {
    value = "CustomWebAppTemplateId"
  }
  active = var.active
  allowed_grants = var.allowed_grants                                   #["authorization_code", "client_credentials"]
  client_type = var.client_type                                         #"confidential"
  is_oauth_client = var.is_oauth_client                                 #true
  force_delete = var.force_delete                                       #true
  show_in_my_apps = var.show_in_my_apps                                 #true
  client_ip_checking = var.client_ip_checking                           #"anywhere"
  # Dynamically construct redirect URIs using the OOD instance public IP
  redirect_uris = [
    "https://ood-${replace(var.ood_public_ip, ".", "-")}.nip.io/oidc"
  ]
  post_logout_redirect_uris = [
    "https://ood-${replace(var.ood_public_ip, ".", "-")}.nip.io/"
  ]
}

resource "oci_identity_domains_user" "ood_user" {

  idcs_endpoint = oci_identity_domain.idcs_domain.url
  schemas       = var.user_schemas
  user_name     = var.ood_username
  display_name  = var.ood_username
  emails {
    value = var.ood_user_email
    type  = "work"
    primary = true
  }
  name {
    given_name  = var.ood_username
    family_name = var.ood_username
  }
  active = true
}
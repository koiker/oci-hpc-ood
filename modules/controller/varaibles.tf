// Copyright (c) 2025, Oracle and/or its affiliates. All rights reserved.
// Authors: Germain Vargas, Rafael Marcelino Koike, Martin Feyereisen

variable "compartment_id" {    #Provide the compartment where ood will be provisioned
  type = string
}

variable "region" {             #Provide the region where ood will be provisioned
  type = string
}

variable "ssh_keys" {           #Provide the SSH Key pairs for the ood
  type = map(string)
}

variable "ood_ad" {              #Provide the availability domain for the ood
  type = string
}

variable "subnet_ocid" {           #Provide the subnet ocid for the ood
  type = string
}

variable "cluster_name" {        #Provide the name of the ood cluster
  type = string
}

variable "ood_shape" {          #Provide the shape of the ood
  type = string
}

variable "ood_ocpus" {          #Provide the number of OCPUs for the ood
  type = number
}

variable "ood_memory" {         #Provide the memory for the ood
  type = number
}

variable "ood_boot_volume_size" { #Provide the boot volume size for the ood
  type = number
}

variable "ood_image_ocid" {     #Provide the image ocid for the ood
  type = string
}

variable "ood_username" {       #Provide the username for the ood
  type = string
}

variable "ood_user_email" {     #Provide the email for the ood
  type = string
}

variable "ood_user_password" {  #Provide the password for the ood
  type = string
}

variable "app_client_id" {       #Provide the app client id for the ood
  type = string
}

variable "app_client_secret" {   #Provide the app client secret for the ood
  type = string
}

variable "idcs_endpoint" {         #Provide the idcs endpoint for the ood
  type = string
}
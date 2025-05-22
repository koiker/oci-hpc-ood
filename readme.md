# OCI HPC OOD Terraform Module

This repository contains a Terraform module for deploying an Oracle Cloud Infrastructure (OCI) compute instance with Open OnDemand (OOD) on a existing Virtual Cloud Network (VCN).

## Features

- Provisioning of OCI compute instances for HPC workloads.
- Deployment of Open OnDemand for managing HPC resources.
- Configurable network, storage, and compute resources.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed.
- OCI CLI configured with appropriate credentials.
- Access to an OCI tenancy with required permissions.
- Existing VCN and Subnet security list requires to have port 80 and 443 open to be able to access OOD.

## Usage

In the provider.auto.tfvars and terraform.tfvars please update the following files with your credentials and preferences.

Here is reference for Image OCID's based on the region you wish to deploy in.

[Oracle Linux 9](https://docs.oracle.com/en-us/iaas/images/oracle-linux-9x/oracle-linux-9-5-2025-04-16-0.htm)

[Oracle Linux 8](https://docs.oracle.com/en-us/iaas/images/oracle-linux-8x/oracle-linux-8-10-2025-04-16-0.htm)

There is two shell scripts labeled ood.sh which is used for ol8 and ood_ol9 for ol9 please use them accordingly.
Update the remote exec section of the ood.tf file to use the correct script.

```

# Provisioner to install and configure Open OnDemand
  provisioner "remote-exec" {

    inline = [
      # Download and install the latest version of Open OnDemand
      "wget https://raw.githubusercontent.com/koiker/oci-hpc/master/scripts/ood_ol9.sh", <---- update here>
      "chmod +x ood_ol9.sh",                                                            <--- update Here>
      "sudo OOD_DNS=${local.ood_public_dns} OOD_USERNAME=${var.ood_username} CLIENT_ID=${var.app_client_id} CLIENT_SECRET=${var.app_client_secret} IDCS_URL=${var.idcs_endpoint} ./ood_ol9.sh",                                             <--- and here>
      "echo 'Customizing UI'",
      "wget https://raw.githubusercontent.com/koiker/oci-hpc/master/scripts/customize_ui.sh",
      "chmod +x customize_ui.sh",
      "sudo ./customize_ui.sh",

    ]

```

```

// Login credentials
provider_oci = {
  tenancy       = ""        # Tenancy OCID
  user_id       = ""        # User OCID
  fingerprint   = ""        # User fingerprint
  key_file_path = ""        # Local path to private API key
  region        = ""        # Region where resources will be deployed
}

```

```

# Map with compartment name and compartment ocid in which resources will be deployed

compartment_id = "compartment ocid"                    #change this to the ocid of your compartment

# Local paths to the ssh keys used to ssh on the bastion and nodes
ssh_keys = {
  ssh_public_key  = "/path/to/keys"                         #change this to the path of your public key
  ssh_private_key = "/path/to/keys"                        #change this to the path of your private key
}

####### Networking #######

vcn_display_name = "name of the existing VCN"               #change this to the name of your existing VCN

vcn_id = "existing_vcn_ocid"                                #change this to the ocid of your existing VCN

####### ood & identity variables #######

domain_name = "ood-identity-domain1"

ood_username = "ood_user"

ood_user_email = "your email address"

ood_user_password = "ilovehpc@oracle"                       #change this to the password you want to use for the ood user

##### ood module #####

ood_ad = 1
targetCompartment = "comp1-ocid"
subnet_ocid = "subnet-ocid"                                 #change this to the ocid of your subnet
cluster_name = "OpenFOAM-Cluster"
ood_shape = "VM.Standard.E4.Flex"
ood_ocpus = 2
ood_memory = 16
ood_boot_volume_size = 50
ood_image_ocid = "image-ocid"                               #change this to the ocid of your image based on the region

```

Run the following commands to deploy:

```bash
terraform init
terraform plan
terraform apply
```
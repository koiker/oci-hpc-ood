// Copyright (c) 2025, Oracle and/or its affiliates. All rights reserved.
// Authors: Germain Vargas, Rafael Marcelino Koike, Martin Feyereisen

// Login credentials
provider_oci = {
  tenancy       = "ocid1.tenancy.oc1..aaaaaaaa2l6fcfl7tfoun3i72tw4rjx4pja5lo7g5iakvptjzmuezihnr27q"    # Tenancy OCID
  user_id       = "ocid1.user.oc1..aaaaaaaami46ntxp3n5tpfstc5f4ohbp2nnjftqxxerncpzbwsalwfke2bja"       # User OCID
  fingerprint   = "f9:f7:2c:5a:a4:4e:f9:9f:40:c3:f7:b1:fd:35:6f:8d"                                    # User fingerprint
  key_file_path = "~/koiker-oci-rafkwq4udl.pem"                                       # Local path to private API key
  region        = "us-ashburn-1"                                                                       # Region where resources will be deployed
}
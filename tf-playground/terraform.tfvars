# ----------------------------------------
#    Default main config - Staging env
# ----------------------------------------

region_target = "eu-north-1"

resource_tags = {
  project     = "myproject"
  environment = "staging-rch"
  owner       = "raphael.chir@couchbase.com"
}

ssh_public_key_path = "/sandbox/tf-playground/.ssh/id_rsa.pub"
ssh_private_key_path = "/sandbox/tf-playground/.ssh/id_rsa"
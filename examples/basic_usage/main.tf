provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

#-------------------------------------------------------------------------------
# Configure the module.
#-------------------------------------------------------------------------------
module "role_site.example.com" {
  source = "../../"

  providers = {
    aws = "aws"
  }

  account_ids = [
    "563873274798"
  ]
  cert_bucket_name = "cool-certificates"
  hostname         = "site.example.com"
}

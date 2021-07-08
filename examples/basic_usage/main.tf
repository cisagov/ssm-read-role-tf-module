provider "aws" {
  alias = "provision-ssm-read-roles"
  assume_role {
    role_arn     = "arn:aws:iam::123456789011:role/ProvisionParameterStoreReadRoles"
    session_name = "terraform-example-create-ssm-role"
  }
  default_tags {
    tags = {
      Testing = true
    }
  }
  region = "us-east-1"
}

#-------------------------------------------------------------------------------
# Configure the module.
#-------------------------------------------------------------------------------
module "ssm_role" {
  source = "../../"

  providers = {
    aws = aws.provision-ssm-read-roles
  }

  account_ids = ["123456789012"]
  entity_name = "site.example.com"
  ssm_names   = ["/server/openvpn/*", "/server/openvpn-2/*"]
  ssm_regions = ["us-east-1", "us-east-2", "us-west-1", "us-west-2"]
}

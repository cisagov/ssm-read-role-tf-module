provider "aws" {
  region = "us-east-1"
  alias  = "ssm_read_role"
  assume_role {
    role_arn     = "arn:aws:iam::123456789011:role/CreateSSMReadRoles"
    session_name = "terraform-example-create-ssm-role"
  }

}


#-------------------------------------------------------------------------------
# Configure the module.
#-------------------------------------------------------------------------------
module "ssm_role" {
  source = "../../"

  providers = {
    aws = "aws.ssm_read_role"
  }

  account_ids = ["123456789012"]
  hostname    = "site.example.com"
  ssm_names   = ["server/openvpn/*", "server/openvpn-2/*"]
  ssm_regions = ["us-east-1", "us-east-2", "us-west-1", "us-west-2"]
}

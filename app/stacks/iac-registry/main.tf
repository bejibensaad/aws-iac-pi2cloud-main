#################################
#     Common tags               #
#################################

data "aws_region" "current" {}

data "terraform_remote_state" "rbac" {
  backend = "s3"
  config = {
    bucket = "s3-terraform-backend-pi2cloud"
    key    = "iac-rbac.tfstate"
    region = data.aws_region.current.name
  }
}


locals {
  aws_region = data.aws_region.current.name
}

# Create common tags
module "pi2cloud_tags" {
  source            = "git@github.com:TotalEnergiesCode/aws-iac-module-tags.git?ref=v2.0.0"
  g_app_name        = var.g_app_name
  g_environment_tag = var.g_environment_tag
}



#################################
#     S3                        #
#################################

module "pi2cloud_log_bucket" {
  source            = "git@github.com:TotalEnergiesCode/aws-iac-module-log-bucket.git?ref=v2.1.1"
  m_app_name        = var.g_app_name
  m_environment_tag = var.g_environment_tag
  m_tags            = module.pi2cloud_tags.common_tags
}
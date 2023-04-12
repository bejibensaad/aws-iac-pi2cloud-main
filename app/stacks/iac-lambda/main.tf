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
#     Lambda                    #
#################################

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "../../../cicd-tools/lambda-functions/firehose_lambda_function.py"
  output_path = "firehose_lambda_function.zip"
}

resource "aws_lambda_function" "firehose_lambda_function" {
  filename      = "firehose_lambda_function.zip"
  function_name = "firehose_lambda_function"
  role          = data.terraform_remote_state.rbac.outputs.lambda_role_arn
  runtime = "python3.9"
  handler = "firehose_lambda_function.py"
  tags = module.pi2cloud_tags.common_tags
}

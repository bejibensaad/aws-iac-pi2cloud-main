#################################
#     Common tags               #
#################################

data "aws_region" "current" {}

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
#     IAM Role                  #
#################################

#Create basic role for lambda function, the module adds the permission boundary on your behalf
module "iam_role_for_lambda" {

  source                     = "git@github.com:TotalEnergiesCode/aws-iac-module-iam.git?ref=v1.2.1"
  m_app_name                 = var.g_app_name
  m_environment_tag          = var.g_environment_tag
  m_iam_role_label           = "lambdaBasicExecutionRole"
  m_role_description         = "IAM Role for lambda to access cloud watch logs"
  m_trusted_role_services    = ["lambda.amazonaws.com"]
  m_custom_role_policy_arns  = []
  m_tags                     = merge(module.pi2cloud_tags.common_tags, { Name = "lambdaBasicExecutionRole" })
}

#Create policy for lambda role
resource "aws_iam_policy" "cloudwatch_logs_access_policy" {
  name        = "write-cloudwatch-logs"
  path        = "/workload/"
  description = "Policy to access cloudwatch logs"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        }
    ]
  })
}

#Attach policy to lambda role
resource "aws_iam_role_policy_attachment" "add_policy_to_lambda_role" {
  role       = module.iam_role_for_lambda.iam_role_name
  policy_arn = aws_iam_policy.cloudwatch_logs_access_policy.arn
}
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
#     Kinesis                  #
#################################

module "pi2cloud_kinesis_stream" {
  source                               = "git@github.com:TotalEnergiesCode/aws-iac-module-kinesis-stream.git?ref=v0.1.0"
  m_app_name                           = var.g_app_name
  m_environment_tag                    = var.g_environment_tag
  m_tags                               = module.pi2cloud_tags.common_tags
  m_kinesis_stream_name                = var.m_kinesis_stream_name
  m_kinesis_stream_retention_period    = var.m_kinesis_stream_retention_period
  m_kinesis_stream_shrad_level_metrics = var.m_kinesis_stream_shrad_level_metrics
  m_kinesis_stream_encryption_type     = "KMS"
  m_kinesis_stream_kms_key_id          = "alias/aws/kinesis"
  m_kinesis_stream_mode                = var.m_kinesis_stream_mode
}
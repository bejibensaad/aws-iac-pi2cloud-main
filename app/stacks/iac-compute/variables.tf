######################################################
# Global & Common Variables for pi2cloud Application
######################################################

variable "g_environment_tag" {
  type        = string
  description = <<-EOF
  The environment name to be used while tagging the provisioned resources. The list of possible values are as follows:
  - `d` for development environment
  - `t` for test environment
  - `q` for qualification environment
  - `i` for integration environment
  - `s` for staging or pre-production environment
  - `p` for production environment
  Defaults to `d` (for development environment) if no value is specified.
EOF
  default     = "d"
  validation {
    condition     = contains(["d", "t", "q", "i", "s", "p"], lower(var.g_environment_tag))
    error_message = "Unsupported environment tag specified. Supported environments are: 'd', 't', 'q', 'i', 's', and 'p'."
  }
}

variable "g_app_name" {
  type        = string
  description = "The name of the application which requires this module-specific service"
}

//Kinesis Data Stream Variables

variable "m_kinesis_stream_shrad_level_metrics" {
  type        = list(any)
  description = "A list of shard-level CloudWatch metrics which can be enabled for the stream."
  default     = []
}

variable "m_kinesis_stream_mode" {
  type        = string
  description = "Specifies the capacity mode of the stream. Must be either PROVISIONED or ON_DEMAND"
  default     = "ON_DEMAND"
}

variable "m_kinesis_stream_retention_period" {
  type        = string
  description = "Length of time data records are accessible after they are added to the stream."
  default     = "24"
}

variable "m_kinesis_stream_name" {
  type        = string
  description = "A name to identify the stream. This is unique to the AWS account and region the Stream is created in"
}
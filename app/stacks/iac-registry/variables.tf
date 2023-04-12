######################################################
# Global & Common Variables for snowflake Application
######################################################

variable "g_app_name" {
  type        = string
  description = "The name of the application which requires this module-specific service"
}

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
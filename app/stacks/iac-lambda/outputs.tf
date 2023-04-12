output "firehose_lambda_arn" {
  description = "lambda function ARN"
  value       = resource.aws_lambda_function.firehose_lambda_function.arn
}
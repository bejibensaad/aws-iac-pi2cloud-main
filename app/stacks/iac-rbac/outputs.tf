output "lambda_role_arn" {
  description = "IAM Role arn"
  value       = module.iam_role_for_lambda.iam_role_arn
}
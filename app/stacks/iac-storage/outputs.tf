
output "pi2cloud_bucket_id" {
  description = "bucket domain name"
  value       = module.pi2cloud_datalake_bucket.sto_bucket_id
}

output "pi2cloud_bucket_arn" {
  description = "import export bucket arn"
  value       = module.pi2cloud_datalake_bucket.sto_bucket_arn
}
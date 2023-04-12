output "kinesis_arn" {
  description = "smart_station kinesis arn"
  value       = module.pi2cloud_kinesis_stream.kinesis_stream_arn
}
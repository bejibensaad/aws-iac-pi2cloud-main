g_environment_tag = "p"
g_app_name        = "pi2cloud"

//Kinesis Data Stream

m_kinesis_stream_name             = "Data-streaming"
m_kinesis_stream_retention_period = "24"
m_kinesis_stream_mode             = "ON_DEMAND"
m_kinesis_stream_shrad_level_metrics = [
  "IncomingBytes",
  "IncomingRecords",
  "OutgoingBytes",
  "OutgoingRecords",
]
variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}
variable "project_name" {
  description = "AWS region"
  type        = string
}


variable "msk_version" {
  description = "MSK Version"
  type        = string
  default     = "3.5.1"
}
variable "msk_instance_type" {
  description = "MSK Instance Type"
  type        = string
  default     = "kafka.t3.small"
}
variable "msk_public_access" {
  description = "MSK Public Access"
  type        = string
  default     = "DISABLED"
}
variable "msk_volume_size" {
  description = "MSK Volume size"
  type        = number
  default     = 1000
}

variable "msk_brokers_pr_nodes" {
  description = "MSK Broker nodes, remeber you can't scale down if you are scaling up and changes this variable after deployment required a Kafka partion rebalancing."
  type        = number
  default     = 1
}

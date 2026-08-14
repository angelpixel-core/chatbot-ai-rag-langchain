variable "aws_region" {
  description = "AWS region for shared platform bootstrap resources."
  type        = string
  default     = "us-east-1"
}

variable "shared_account_id" {
  description = "AWS account ID for shared/platform."
  type        = string
}

variable "nonprod_account_id" {
  description = "AWS account ID for non-production workloads."
  type        = string
}

variable "prod_account_id" {
  description = "AWS account ID for production workloads."
  type        = string
}

variable "tags" {
  description = "Common tags applied to shared platform resources."
  type        = map(string)
  default     = {}
}

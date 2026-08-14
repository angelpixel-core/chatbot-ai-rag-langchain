variable "aws_region" {
  description = "AWS region for production resources."
  type        = string
  default     = "us-east-1"
}

variable "account_id" {
  description = "AWS account ID for production."
  type        = string
}

variable "shared_account_id" {
  description = "AWS account ID for shared/platform resources."
  type        = string
}

variable "tags" {
  description = "Common tags applied to production resources."
  type        = map(string)
  default     = {}
}

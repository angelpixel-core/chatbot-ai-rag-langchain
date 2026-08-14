variable "aws_region" {
  description = "AWS region for non-production resources."
  type        = string
  default     = "us-east-1"
}

variable "account_id" {
  description = "AWS account ID for non-production."
  type        = string
}

variable "shared_account_id" {
  description = "AWS account ID for shared/platform resources."
  type        = string
}

variable "environment_names" {
  description = "Non-production environments hosted in this account."
  type        = list(string)
  default     = ["qa", "staging"]
}

variable "tags" {
  description = "Common tags applied to non-production resources."
  type        = map(string)
  default     = {}
}

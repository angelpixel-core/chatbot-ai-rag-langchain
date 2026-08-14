variable "region" {
  type        = string
  description = "AWS region for IAM bootstrap context."
}

variable "shared_account_id" {
  type        = string
  description = "AWS account ID for shared/platform."
}

variable "nonprod_account_id" {
  type        = string
  description = "AWS account ID for non-production workloads."
}

variable "prod_account_id" {
  type        = string
  description = "AWS account ID for production workloads."
}

variable "tags" {
  type        = map(string)
  description = "Common tags applied to IAM scaffold artifacts."
  default     = {}
}

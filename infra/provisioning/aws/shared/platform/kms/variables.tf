variable "region" {
  type        = string
  description = "AWS region for KMS bootstrap context."
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
  description = "Common tags applied to KMS scaffold artifacts."
  default     = {}
}

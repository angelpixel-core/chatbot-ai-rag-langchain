variable "region" {
  type        = string
  description = "AWS region for IAM bootstrap context."
}

variable "shared_account_id" {
  type        = string
  description = "AWS account ID for shared/platform."
}

variable "shared_account_email" {
  type        = string
  description = "Root email for the shared/platform AWS account."
}

variable "nonprod_account_id" {
  type        = string
  description = "AWS account ID for non-production workloads."
}

variable "nonprod_account_email" {
  type        = string
  description = "Root email for the non-production AWS account."
}

variable "prod_account_id" {
  type        = string
  description = "AWS account ID for production workloads."
}

variable "prod_account_email" {
  type        = string
  description = "Root email for the production AWS account."
}

variable "tags" {
  type        = map(string)
  description = "Common tags applied to IAM scaffold artifacts."
  default     = {}
}

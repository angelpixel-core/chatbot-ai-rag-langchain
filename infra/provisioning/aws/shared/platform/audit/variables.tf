variable "region" {
  type        = string
  description = "AWS region for audit services."
}

variable "shared_account_id" {
  type        = string
  description = "AWS account ID for shared/platform."
}

variable "tags" {
  type        = map(string)
  description = "Common tags applied to audit scaffold artifacts."
  default     = {}
}

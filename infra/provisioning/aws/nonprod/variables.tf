variable "region" {
  description = "AWS region for non-production resources."
  type        = string
  default     = "us-east-1"
}

variable "account_id" {
  description = "AWS account ID for non-production."
  type        = string

  validation {
    condition     = can(regex("^[0-9]{12}$", var.account_id))
    error_message = "account_id must be a 12-digit AWS account ID."
  }
}

variable "account_email" {
  description = "Root email for the non-production AWS account."
  type        = string
}

variable "shared_account_id" {
  description = "AWS account ID for shared/platform resources."
  type        = string

  validation {
    condition     = can(regex("^[0-9]{12}$", var.shared_account_id))
    error_message = "shared_account_id must be a 12-digit AWS account ID."
  }
}

variable "shared_account_email" {
  description = "Root email for the shared/platform AWS account."
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

variable "region" {
  description = "AWS region for production resources."
  type        = string
  default     = "us-east-1"
}

variable "account_id" {
  description = "AWS account ID for production."
  type        = string

  validation {
    condition     = can(regex("^[0-9]{12}$", var.account_id))
    error_message = "account_id must be a 12-digit AWS account ID."
  }
}

variable "account_email" {
  description = "Root email for the production AWS account."
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

variable "tags" {
  description = "Common tags applied to production resources."
  type        = map(string)
  default     = {}
}

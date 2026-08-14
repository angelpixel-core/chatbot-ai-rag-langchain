variable "region" {
  description = "AWS region for shared platform bootstrap resources."
  type        = string
  default     = "us-east-1"
}

variable "shared_account_id" {
  description = "AWS account ID for shared/platform."
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

variable "nonprod_account_id" {
  description = "AWS account ID for non-production workloads."
  type        = string

  validation {
    condition     = can(regex("^[0-9]{12}$", var.nonprod_account_id))
    error_message = "nonprod_account_id must be a 12-digit AWS account ID."
  }
}

variable "nonprod_account_email" {
  description = "Root email for the non-production AWS account."
  type        = string
}

variable "prod_account_id" {
  description = "AWS account ID for production workloads."
  type        = string

  validation {
    condition     = can(regex("^[0-9]{12}$", var.prod_account_id))
    error_message = "prod_account_id must be a 12-digit AWS account ID."
  }
}

variable "prod_account_email" {
  description = "Root email for the production AWS account."
  type        = string
}

variable "tags" {
  description = "Common tags applied to shared platform resources."
  type        = map(string)
  default     = {}
}

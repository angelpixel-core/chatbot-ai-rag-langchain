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

variable "vpc_cidr_block" {
  description = "CIDR block reserved for the non-production VPC."
  type        = string
  default     = "10.41.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs for non-production."
  type        = list(string)
  default     = ["10.41.0.0/20", "10.41.16.0/20"]
}

variable "private_app_subnet_cidrs" {
  description = "Private app subnet CIDRs for non-production."
  type        = list(string)
  default     = ["10.41.32.0/20", "10.41.48.0/20"]
}

variable "private_data_subnet_cidrs" {
  description = "Private data subnet CIDRs for non-production."
  type        = list(string)
  default     = ["10.41.64.0/20", "10.41.80.0/20"]
}

variable "enable_nat" {
  description = "Whether to create a NAT gateway for non-production."
  type        = bool
  default     = true
}

variable "enable_dns" {
  description = "Whether to create a private Route53 zone for non-production."
  type        = bool
  default     = false
}

variable "private_zone_name" {
  description = "Private DNS zone name for non-production if DNS is enabled."
  type        = string
  default     = "nonprod.internal"
}

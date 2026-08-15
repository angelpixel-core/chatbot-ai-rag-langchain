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

variable "vpc_cidr_block" {
  description = "CIDR block reserved for the production VPC."
  type        = string
  default     = "10.42.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs for production."
  type        = list(string)
  default     = ["10.42.0.0/20", "10.42.16.0/20"]
}

variable "private_app_subnet_cidrs" {
  description = "Private app subnet CIDRs for production."
  type        = list(string)
  default     = ["10.42.32.0/20", "10.42.48.0/20"]
}

variable "private_data_subnet_cidrs" {
  description = "Private data subnet CIDRs for production."
  type        = list(string)
  default     = ["10.42.64.0/20", "10.42.80.0/20"]
}

variable "enable_nat" {
  description = "Whether to create a NAT gateway for production."
  type        = bool
  default     = true
}

variable "enable_dns" {
  description = "Whether to create a private Route53 zone for production."
  type        = bool
  default     = false
}

variable "private_zone_name" {
  description = "Private DNS zone name for production if DNS is enabled."
  type        = string
  default     = "prod.internal"
}

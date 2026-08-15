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

variable "vpc_cidr_block" {
  description = "CIDR block reserved for the shared/platform VPC."
  type        = string
  default     = "10.40.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs for shared/platform."
  type        = list(string)
  default     = ["10.40.0.0/20", "10.40.16.0/20"]
}

variable "private_app_subnet_cidrs" {
  description = "Private app subnet CIDRs for shared/platform."
  type        = list(string)
  default     = ["10.40.32.0/20", "10.40.48.0/20"]
}

variable "private_data_subnet_cidrs" {
  description = "Private data subnet CIDRs for shared/platform."
  type        = list(string)
  default     = ["10.40.64.0/20", "10.40.80.0/20"]
}

variable "enable_nat" {
  description = "Whether to create a NAT gateway for shared/platform."
  type        = bool
  default     = true
}

variable "enable_dns" {
  description = "Whether to create a private Route53 zone for shared/platform."
  type        = bool
  default     = false
}

variable "private_zone_name" {
  description = "Private DNS zone name for shared/platform if DNS is enabled."
  type        = string
  default     = "shared.platform.internal"
}

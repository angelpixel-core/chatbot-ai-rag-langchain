variable "name" {
  description = "Logical name for the VPC and its child resources."
  type        = string
}

variable "region" {
  description = "AWS region where the VPC is created."
  type        = string
}

variable "cidr_block" {
  description = "Primary CIDR block for the VPC."
  type        = string

  validation {
    condition     = can(cidrhost(var.cidr_block, 0))
    error_message = "cidr_block must be a valid CIDR block."
  }
}

variable "azs" {
  description = "Availability zones used by the VPC subnets."
  type        = list(string)

  validation {
    condition     = length(var.azs) > 0
    error_message = "azs must contain at least one availability zone."
  }
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets."
  type        = list(string)
}

variable "private_app_subnet_cidrs" {
  description = "CIDR blocks for private application subnets."
  type        = list(string)
}

variable "private_data_subnet_cidrs" {
  description = "CIDR blocks for private data subnets."
  type        = list(string)
}

variable "enable_nat" {
  description = "Whether to create a NAT gateway for private subnets."
  type        = bool
  default     = true
}

variable "enable_dns" {
  description = "Whether to create a private Route53 zone for the VPC."
  type        = bool
  default     = false
}

variable "private_zone_name" {
  description = "Private DNS zone name to create when enable_dns is true."
  type        = string
  default     = null
  nullable    = true
}

variable "tags" {
  description = "Common tags applied to all VPC resources."
  type        = map(string)
  default     = {}
}

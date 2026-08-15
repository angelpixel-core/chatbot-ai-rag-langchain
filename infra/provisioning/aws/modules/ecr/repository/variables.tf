variable "name" {
  description = "Name of the ECR repository."
  type        = string
}

variable "image_tag_mutability" {
  description = "Image tag mutability setting for the repository."
  type        = string
  default     = "IMMUTABLE"
}

variable "scan_on_push" {
  description = "Whether images are scanned on push."
  type        = bool
  default     = true
}

variable "expire_untagged_after_days" {
  description = "Days before untagged images expire."
  type        = number
  default     = 7
}

variable "tags" {
  description = "Common tags applied to ECR resources."
  type        = map(string)
  default     = {}
}

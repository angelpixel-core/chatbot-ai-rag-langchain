output "key_layout" {
  value       = local.key_layout
  description = "Planned KMS key aliases."
}

output "key_purpose" {
  value       = local.key_purpose
  description = "Purpose of each planned KMS key."
}

output "key_arns" {
  value = {
    for name, key in aws_kms_key.this : name => key.arn
  }
  description = "ARNs for the bootstrap KMS keys."
}

output "aliases" {
  value = {
    for name, alias in aws_kms_alias.this : name => alias.name
  }
  description = "Aliases for the bootstrap KMS keys."
}

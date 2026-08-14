locals {
  audit_layout = {
    cloudtrail = "enabled"
    config     = "enabled"
    logging    = "centralized"
  }

  audit_scope = [
    "CloudTrail",
    "AWS Config",
    "centralized logs",
  ]
}

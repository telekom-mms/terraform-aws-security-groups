// examples/basic-security-groups/outputs.tf

output "web_tier_sg_id" {
  description = "ID of the web tier security group"
  value       = module.security_groups.web_tier_sg_id
}

output "app_tier_sg_id" {
  description = "ID of the application tier security group"
  value       = module.security_groups.app_tier_sg_id
}

output "db_tier_sg_id" {
  description = "ID of the database tier security group"
  value       = module.security_groups.db_tier_sg_id
}

output "management_sg_id" {
  description = "ID of the management security group"
  value       = module.security_groups.management_sg_id
}

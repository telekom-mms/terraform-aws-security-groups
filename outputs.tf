// outputs.tf

output "web_tier_sg_id" {
  description = "The ID of the web tier security group"
  value       = try(aws_security_group.web_tier[0].id, null)
}

output "app_tier_sg_id" {
  description = "The ID of the application tier security group"
  value       = try(aws_security_group.app_tier[0].id, null)
}

output "db_tier_sg_id" {
  description = "The ID of the database tier security group"
  value       = try(aws_security_group.db_tier[0].id, null)
}

output "management_sg_id" {
  description = "The ID of the management security group"
  value       = try(aws_security_group.management[0].id, null)
}

output "web_tier_sg_arn" {
  description = "The ARN of the web tier security group"
  value       = try(aws_security_group.web_tier[0].arn, null)
}

output "app_tier_sg_arn" {
  description = "The ARN of the application tier security group"
  value       = try(aws_security_group.app_tier[0].arn, null)
}

output "db_tier_sg_arn" {
  description = "The ARN of the database tier security group"
  value       = try(aws_security_group.db_tier[0].arn, null)
}

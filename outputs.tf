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

output "web_tier_sg_name" {
  description = "The name of the web tier security group"
  value       = try(aws_security_group.web_tier[0].name, null)
}

output "app_tier_sg_name" {
  description = "The name of the application tier security group"
  value       = try(aws_security_group.app_tier[0].name, null)
}

output "db_tier_sg_name" {
  description = "The name of the database tier security group"
  value       = try(aws_security_group.db_tier[0].name, null)
}

output "management_sg_name" {
  description = "The name of the management security group"
  value       = try(aws_security_group.management[0].name, null)
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

output "management_sg_arn" {
  description = "The ARN of the management security group"
  value       = try(aws_security_group.management[0].arn, null)
}

output "security_group_ids" {
  description = "Map of managed security group IDs"
  value = {
    web        = try(aws_security_group.web_tier[0].id, null)
    app        = try(aws_security_group.app_tier[0].id, null)
    db         = try(aws_security_group.db_tier[0].id, null)
    management = try(aws_security_group.management[0].id, null)
  }
}

output "security_group_names" {
  description = "Map of managed security group names"
  value = {
    web        = try(aws_security_group.web_tier[0].name, null)
    app        = try(aws_security_group.app_tier[0].name, null)
    db         = try(aws_security_group.db_tier[0].name, null)
    management = try(aws_security_group.management[0].name, null)
  }
}

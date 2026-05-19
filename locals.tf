locals {
  name_prefix = var.name_prefix != "" ? var.name_prefix : "${var.project_name}-${var.environment}"

  existing_web_tier_sg_id = try(var.web_tier_sg_ids[0], null)
  existing_app_tier_sg_id = try(var.app_tier_sg_ids[0], null)
  existing_db_tier_sg_id  = try(var.db_tier_sg_ids[0], null)

  common_tags = merge(var.tags, {
    "Project"       = var.project_name
    "Environment"   = var.environment
    "ManagedBy"     = "Terraform"
    "PSA-Compliant" = "true"
  })
}

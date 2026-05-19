// main.tf
# Written by Marc Straubinger - Overhauled for Security-First Best Practices

# Web Tier Security Group
# PSA Compliance: Req 10 (network access control)
resource "aws_security_group" "web_tier" {
  count       = var.create_web_tier_sg ? 1 : 0
  name        = "${local.name_prefix}-sg-web"
  description = "Security group for web tier - PSA compliant"
  vpc_id      = var.vpc_id

  tags = merge(local.common_tags, {
    "Name"          = "${local.name_prefix}-sg-web"
    "Tier"          = "web"
    "PSA-Compliant" = "true"
  })
}

# PSA Compliance: Req 10 (least privilege network access)
resource "aws_security_group_rule" "web_https_ingress" {
  count             = var.create_web_tier_sg ? 1 : 0
  description       = "HTTPS inbound from allowed CIDRs"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.allowed_web_cidrs
  security_group_id = aws_security_group.web_tier[0].id
}

# PSA Compliance: Req 10 (least privilege network access)
resource "aws_security_group_rule" "web_http_ingress" {
  count             = var.create_web_tier_sg && var.allow_http ? 1 : 0
  description       = "HTTP inbound (redirect to HTTPS recommended)"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = var.allowed_web_cidrs
  security_group_id = aws_security_group.web_tier[0].id
}

# PSA Compliance: Req 10 (least privilege network access)
resource "aws_security_group_rule" "web_to_app_egress" {
  count                    = var.create_web_tier_sg ? 1 : 0
  description              = "Outbound to application tier only"
  type                     = "egress"
  from_port                = var.app_port
  to_port                  = var.app_port
  protocol                 = "tcp"
  source_security_group_id = var.create_app_tier_sg ? aws_security_group.app_tier[0].id : local.existing_app_tier_sg_id
  security_group_id        = aws_security_group.web_tier[0].id

  lifecycle {
    precondition {
      condition     = var.create_app_tier_sg || local.existing_app_tier_sg_id != null
      error_message = "app_tier_sg_ids must contain at least one security group ID when create_app_tier_sg is false."
    }
  }
}

# PSA Compliance: Req 10 (least privilege network access)
resource "aws_security_group_rule" "web_https_egress" {
  count             = var.create_web_tier_sg ? 1 : 0
  description       = "HTTPS outbound for security updates"
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.allowed_https_egress_cidrs
  security_group_id = aws_security_group.web_tier[0].id
}

# Application Tier Security Group
# PSA Compliance: Req 10 (network access control)
resource "aws_security_group" "app_tier" {
  count       = var.create_app_tier_sg ? 1 : 0
  name        = "${local.name_prefix}-sg-app"
  description = "Security group for application tier - PSA compliant"
  vpc_id      = var.vpc_id

  tags = merge(local.common_tags, {
    "Name"          = "${local.name_prefix}-sg-app"
    "Tier"          = "application"
    "PSA-Compliant" = "true"
  })
}

# PSA Compliance: Req 10 (least privilege network access)
resource "aws_security_group_rule" "app_from_web_ingress" {
  count                    = var.create_app_tier_sg ? 1 : 0
  description              = "Inbound from web tier only"
  type                     = "ingress"
  from_port                = var.app_port
  to_port                  = var.app_port
  protocol                 = "tcp"
  source_security_group_id = var.create_web_tier_sg ? aws_security_group.web_tier[0].id : local.existing_web_tier_sg_id
  security_group_id        = aws_security_group.app_tier[0].id

  lifecycle {
    precondition {
      condition     = var.create_web_tier_sg || local.existing_web_tier_sg_id != null
      error_message = "web_tier_sg_ids must contain at least one security group ID when create_web_tier_sg is false."
    }
  }
}

# PSA Compliance: Req 10 (least privilege network access)
resource "aws_security_group_rule" "app_to_db_egress" {
  count                    = var.create_app_tier_sg ? 1 : 0
  description              = "Outbound to database tier only"
  type                     = "egress"
  from_port                = var.db_port
  to_port                  = var.db_port
  protocol                 = "tcp"
  source_security_group_id = var.create_db_tier_sg ? aws_security_group.db_tier[0].id : local.existing_db_tier_sg_id
  security_group_id        = aws_security_group.app_tier[0].id

  lifecycle {
    precondition {
      condition     = var.create_db_tier_sg || local.existing_db_tier_sg_id != null
      error_message = "db_tier_sg_ids must contain at least one security group ID when create_db_tier_sg is false."
    }
  }
}

# PSA Compliance: Req 10 (least privilege network access)
resource "aws_security_group_rule" "app_https_egress" {
  count             = var.create_app_tier_sg ? 1 : 0
  description       = "HTTPS outbound for external APIs and updates"
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.allowed_https_egress_cidrs
  security_group_id = aws_security_group.app_tier[0].id
}

# Database Tier Security Group
# PSA Compliance: Req 10 (network access control)
resource "aws_security_group" "db_tier" {
  count       = var.create_db_tier_sg ? 1 : 0
  name        = "${local.name_prefix}-sg-db"
  description = "Security group for database tier - PSA compliant"
  vpc_id      = var.vpc_id

  tags = merge(local.common_tags, {
    "Name"          = "${local.name_prefix}-sg-db"
    "Tier"          = "database"
    "PSA-Compliant" = "true"
  })
}

# PSA Compliance: Req 10 (least privilege network access)
resource "aws_security_group_rule" "db_from_app_ingress" {
  count                    = var.create_db_tier_sg ? 1 : 0
  description              = "Inbound from application tier only"
  type                     = "ingress"
  from_port                = var.db_port
  to_port                  = var.db_port
  protocol                 = "tcp"
  source_security_group_id = var.create_app_tier_sg ? aws_security_group.app_tier[0].id : local.existing_app_tier_sg_id
  security_group_id        = aws_security_group.db_tier[0].id

  lifecycle {
    precondition {
      condition     = var.create_app_tier_sg || local.existing_app_tier_sg_id != null
      error_message = "app_tier_sg_ids must contain at least one security group ID when create_app_tier_sg is false."
    }
  }
}

# Management Security Group
# PSA Compliance: Req 10 (network access control)
resource "aws_security_group" "management" {
  count       = var.create_management_sg ? 1 : 0
  name        = "${local.name_prefix}-sg-mgmt"
  description = "Security group for management/bastion access - PSA compliant"
  vpc_id      = var.vpc_id

  tags = merge(local.common_tags, {
    "Name"          = "${local.name_prefix}-sg-mgmt"
    "Tier"          = "management"
    "PSA-Compliant" = "true"
  })
}

# PSA Compliance: Req 10 (least privilege network access)
resource "aws_security_group_rule" "mgmt_ssh_ingress" {
  count             = var.create_management_sg ? 1 : 0
  description       = "SSH from authorized management networks only"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.allowed_management_cidrs
  security_group_id = aws_security_group.management[0].id
}

# PSA Compliance: Req 10 (least privilege network access)
resource "aws_security_group_rule" "mgmt_rdp_ingress" {
  count             = var.create_management_sg && var.allow_rdp ? 1 : 0
  description       = "RDP from authorized management networks only"
  type              = "ingress"
  from_port         = 3389
  to_port           = 3389
  protocol          = "tcp"
  cidr_blocks       = var.allowed_management_cidrs
  security_group_id = aws_security_group.management[0].id
}

# PSA Compliance: Req 10 (least privilege network access)
resource "aws_security_group_rule" "mgmt_ssh_egress" {
  count             = var.create_management_sg ? 1 : 0
  description       = "SSH outbound to internal VPC networks"
  type              = "egress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.internal_cidrs
  security_group_id = aws_security_group.management[0].id
}

# PSA Compliance: Req 10 (least privilege network access)
resource "aws_security_group_rule" "mgmt_https_egress" {
  count             = var.create_management_sg ? 1 : 0
  description       = "HTTPS outbound for security patches and updates"
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.allowed_https_egress_cidrs
  security_group_id = aws_security_group.management[0].id
}

# Custom Rules
# PSA Compliance: Req 10 (least privilege network access)
resource "aws_security_group_rule" "web_custom" {
  for_each = var.create_web_tier_sg ? { for idx, rule in var.web_custom_ingress : idx => rule } : {}

  security_group_id = aws_security_group.web_tier[0].id
  type              = "ingress"
  from_port         = each.value.from_port
  to_port           = coalesce(each.value.to_port, each.value.from_port)
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_blocks
  description       = each.value.description
}

# PSA Compliance: Req 10 (least privilege network access)
resource "aws_security_group_rule" "app_custom" {
  for_each = var.create_app_tier_sg ? { for idx, rule in var.app_custom_ingress : idx => rule } : {}

  security_group_id = aws_security_group.app_tier[0].id
  type              = "ingress"
  from_port         = each.value.from_port
  to_port           = coalesce(each.value.to_port, each.value.from_port)
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_blocks
  description       = each.value.description
}

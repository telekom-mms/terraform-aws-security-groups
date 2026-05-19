// examples/basic-security-groups/main.tf

provider "aws" {
  region = "eu-central-1"
}

data "aws_vpc" "existing" {
  default = true
}

module "security_groups" {
  source = "../../"

  vpc_id      = data.aws_vpc.existing.id
  name_prefix = var.name_prefix

  create_web_tier_sg = true
  web_allowed_cidrs  = ["0.0.0.0/0"]
  allow_http         = false

  create_app_tier_sg = true
  app_port           = 8080

  create_db_tier_sg = true
  db_port           = 5432

  create_management_sg     = true
  management_allowed_cidrs = ["192.168.1.0/24"]
  allow_rdp                = false
  internal_cidrs           = [data.aws_vpc.existing.cidr_block]

  tags = var.tags
}

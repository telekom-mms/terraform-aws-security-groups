// examples/basic-security-groups/main.tf

provider "aws" {
  region = "eu-central-1"
}

data "aws_vpc" "existing" {
  default = true
}

module "security_groups" {
  source = "../../"

  project_name = var.project_name
  environment  = var.environment
  vpc_id       = data.aws_vpc.existing.id
  name_prefix  = var.name_prefix

  create_web_tier_sg = true
  allowed_web_cidrs  = ["0.0.0.0/0"]
  allow_http         = false

  create_app_tier_sg = true
  app_port           = 8080

  create_db_tier_sg = true
  db_port           = 5432

  create_management_sg     = true
  allowed_management_cidrs = ["192.168.1.0/24"]
  allow_rdp                = false
  internal_cidrs           = [data.aws_vpc.existing.cidr_block]

  tags = var.tags
}

// examples/basic-security-groups/variables.tf

variable "project_name" {
  description = "Project name used for default tags and naming"
  type        = string
  default     = "sg-example"
}

variable "environment" {
  description = "Environment used for default tags and naming"
  type        = string
  default     = "dev"
}

variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "example-sg"
}

variable "tags" {
  description = "Tags for all resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Owner       = "terraform"
    Project     = "sg-example"
  }
}

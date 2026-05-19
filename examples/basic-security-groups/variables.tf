// examples/basic-security-groups/variables.tf

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

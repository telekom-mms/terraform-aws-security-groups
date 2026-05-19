// variables.tf

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment (e.g., prod, dev, test)"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where security groups will be created"
  type        = string
}

variable "name_prefix" {
  description = "Prefix for resource names (e.g., 'myapp-prod')"
  type        = string
}

variable "tags" {
  description = "Additional tags for all resources"
  type        = map(string)
  default     = {}
}

# Web Tier Configuration
variable "create_web_tier_sg" {
  description = "Create security group for web tier"
  type        = bool
  default     = true
}

variable "web_allowed_cidrs" {
  description = "CIDR blocks allowed to access web tier"
  type        = list(string)
  default     = ["0.0.0.0/0"] # Public by default, but should be restricted if possible
}

variable "allow_http" {
  description = "Allow HTTP (port 80) traffic - HTTPS (443) is always enabled"
  type        = bool
  default     = false
}

# Application Tier Configuration
variable "create_app_tier_sg" {
  description = "Create security group for application tier"
  type        = bool
  default     = true
}

variable "app_port" {
  description = "Port for application tier communication"
  type        = number
  default     = 8080
}

variable "web_tier_sg_ids" {
  description = "List of web tier security group IDs (if not creating web tier SG)"
  type        = list(string)
  default     = []
}

# Database Tier Configuration
variable "create_db_tier_sg" {
  description = "Create security group for database tier"
  type        = bool
  default     = true
}

variable "db_port" {
  description = "Port for database communication"
  type        = number
  default     = 5432
}

variable "app_tier_sg_ids" {
  description = "List of application tier security group IDs (if not creating app tier SG)"
  type        = list(string)
  default     = []
}

variable "db_tier_sg_ids" {
  description = "List of database tier security group IDs (if not creating db tier SG)"
  type        = list(string)
  default     = []
}

# Management/Bastion Configuration
variable "create_management_sg" {
  description = "Create security group for management/bastion access"
  type        = bool
  default     = true
}

variable "management_allowed_cidrs" {
  description = "CIDR blocks allowed for management access"
  type        = list(string)
  default     = []
}

variable "allow_rdp" {
  description = "Allow RDP (port 3389) for Windows management"
  type        = bool
  default     = false
}

variable "internal_cidrs" {
  description = "Internal CIDR blocks for management access"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

# Custom Rules
variable "web_custom_ingress" {
  description = "List of custom ingress rules for web tier"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = []
}

variable "app_custom_ingress" {
  description = "List of custom ingress rules for app tier"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = []
}

<!-- BEGIN_TF_DOCS -->


## Requirements

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3 |

## Providers

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.35.1 |

## Resources

## Resources

| Name | Type |
|------|------|
| [aws_security_group.app_tier](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.db_tier](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.management](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.web_tier](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.app_custom](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.app_from_web_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.app_https_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.app_to_db_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.db_from_app_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.mgmt_https_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.mgmt_rdp_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.mgmt_ssh_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.mgmt_ssh_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.web_custom](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.web_http_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.web_https_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.web_https_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.web_to_app_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_management_cidrs"></a> [allowed\_management\_cidrs](#input\_allowed\_management\_cidrs) | CIDR blocks allowed for management access | `list(string)` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (e.g., prod, dev, test) | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the project | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC where security groups will be created | `string` | n/a | yes |
| <a name="input_allow_http"></a> [allow\_http](#input\_allow\_http) | Allow HTTP (port 80) traffic - HTTPS (443) is always enabled | `bool` | `false` | no |
| <a name="input_allow_rdp"></a> [allow\_rdp](#input\_allow\_rdp) | Allow RDP (port 3389) for Windows management | `bool` | `false` | no |
| <a name="input_allowed_https_egress_cidrs"></a> [allowed\_https\_egress\_cidrs](#input\_allowed\_https\_egress\_cidrs) | CIDR blocks allowed for HTTPS egress from managed security groups | `list(string)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_allowed_web_cidrs"></a> [allowed\_web\_cidrs](#input\_allowed\_web\_cidrs) | CIDR blocks allowed to access the web tier | `list(string)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_app_custom_ingress"></a> [app\_custom\_ingress](#input\_app\_custom\_ingress) | List of custom ingress rules for app tier | <pre>list(object({<br/>    from_port   = number<br/>    to_port     = optional(number)<br/>    protocol    = optional(string, "tcp")<br/>    cidr_blocks = list(string)<br/>    description = optional(string, "Custom application ingress rule")<br/>  }))</pre> | `[]` | no |
| <a name="input_app_port"></a> [app\_port](#input\_app\_port) | Port for application tier communication | `number` | `8080` | no |
| <a name="input_app_tier_sg_ids"></a> [app\_tier\_sg\_ids](#input\_app\_tier\_sg\_ids) | List of application tier security group IDs (if not creating app tier SG) | `list(string)` | `[]` | no |
| <a name="input_create_app_tier_sg"></a> [create\_app\_tier\_sg](#input\_create\_app\_tier\_sg) | Create security group for application tier | `bool` | `true` | no |
| <a name="input_create_db_tier_sg"></a> [create\_db\_tier\_sg](#input\_create\_db\_tier\_sg) | Create security group for database tier | `bool` | `true` | no |
| <a name="input_create_management_sg"></a> [create\_management\_sg](#input\_create\_management\_sg) | Create security group for management/bastion access | `bool` | `true` | no |
| <a name="input_create_web_tier_sg"></a> [create\_web\_tier\_sg](#input\_create\_web\_tier\_sg) | Create security group for web tier | `bool` | `true` | no |
| <a name="input_db_port"></a> [db\_port](#input\_db\_port) | Port for database communication | `number` | `5432` | no |
| <a name="input_db_tier_sg_ids"></a> [db\_tier\_sg\_ids](#input\_db\_tier\_sg\_ids) | List of database tier security group IDs (if not creating db tier SG) | `list(string)` | `[]` | no |
| <a name="input_internal_cidrs"></a> [internal\_cidrs](#input\_internal\_cidrs) | Internal CIDR blocks for management access | `list(string)` | <pre>[<br/>  "10.0.0.0/16"<br/>]</pre> | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for resource names (if not provided, will use project-environment pattern) | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags for all resources | `map(string)` | `{}` | no |
| <a name="input_web_custom_ingress"></a> [web\_custom\_ingress](#input\_web\_custom\_ingress) | List of custom ingress rules for web tier | <pre>list(object({<br/>    from_port   = number<br/>    to_port     = optional(number)<br/>    protocol    = optional(string, "tcp")<br/>    cidr_blocks = list(string)<br/>    description = optional(string, "Custom web ingress rule")<br/>  }))</pre> | `[]` | no |
| <a name="input_web_tier_sg_ids"></a> [web\_tier\_sg\_ids](#input\_web\_tier\_sg\_ids) | List of web tier security group IDs (if not creating web tier SG) | `list(string)` | `[]` | no |

## Outputs

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_tier_sg_arn"></a> [app\_tier\_sg\_arn](#output\_app\_tier\_sg\_arn) | The ARN of the application tier security group |
| <a name="output_app_tier_sg_id"></a> [app\_tier\_sg\_id](#output\_app\_tier\_sg\_id) | The ID of the application tier security group |
| <a name="output_app_tier_sg_name"></a> [app\_tier\_sg\_name](#output\_app\_tier\_sg\_name) | The name of the application tier security group |
| <a name="output_db_tier_sg_arn"></a> [db\_tier\_sg\_arn](#output\_db\_tier\_sg\_arn) | The ARN of the database tier security group |
| <a name="output_db_tier_sg_id"></a> [db\_tier\_sg\_id](#output\_db\_tier\_sg\_id) | The ID of the database tier security group |
| <a name="output_db_tier_sg_name"></a> [db\_tier\_sg\_name](#output\_db\_tier\_sg\_name) | The name of the database tier security group |
| <a name="output_management_sg_arn"></a> [management\_sg\_arn](#output\_management\_sg\_arn) | The ARN of the management security group |
| <a name="output_management_sg_id"></a> [management\_sg\_id](#output\_management\_sg\_id) | The ID of the management security group |
| <a name="output_management_sg_name"></a> [management\_sg\_name](#output\_management\_sg\_name) | The name of the management security group |
| <a name="output_security_group_ids"></a> [security\_group\_ids](#output\_security\_group\_ids) | Map of managed security group IDs |
| <a name="output_security_group_names"></a> [security\_group\_names](#output\_security\_group\_names) | Map of managed security group names |
| <a name="output_web_tier_sg_arn"></a> [web\_tier\_sg\_arn](#output\_web\_tier\_sg\_arn) | The ARN of the web tier security group |
| <a name="output_web_tier_sg_id"></a> [web\_tier\_sg\_id](#output\_web\_tier\_sg\_id) | The ID of the web tier security group |
| <a name="output_web_tier_sg_name"></a> [web\_tier\_sg\_name](#output\_web\_tier\_sg\_name) | The name of the web tier security group |
<!-- END_TF_DOCS -->
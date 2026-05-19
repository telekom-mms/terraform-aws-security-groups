# AWS Security Groups Basic Example

This example demonstrates how to use the AWS Security Groups module to create a set of tiered security groups.

## Features

- Web, Application, Database, and Management tier security groups.
- HTTPS access to web tier from anywhere.
- Application tier access only from web tier.
- Database tier access only from application tier.
- SSH access to management tier from a specified CIDR.

## Usage

1.  Copy this example to your project.
2.  Update `variables.tf` with your specific values.
3.  **Important**: Modify `management_allowed_cidrs` in `main.tf` to your actual management network CIDR.
4.  Initialize and apply:
    ```bash
    terraform init
    terraform plan
    terraform apply
    ```

## Variables

See `variables.tf` for all configurable options.

## Outputs

- IDs of the created security groups.

## Requirements

- AWS CLI configured
- Terraform >= 1.0
- A default VPC must exist in your AWS account, or you need to provide a `vpc_id`.

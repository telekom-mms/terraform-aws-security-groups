<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a id="readme-top"></a>

<!-- PROJECT SHIELDS -->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![Unlicense License][license-shield]][license-url]

<br />

<!-- PROJECT LOGO -->
<div align="center">
  <a href="https://github.com/telekom-mms/terraform-aws-security-groups">
    <img src="logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">AWS Security Groups Module</h3>

  <p align="center">
    PSA-compliant 3-tier security group architecture with mandatory rule descriptions and zero-egress database defaults.
    <br />
    <a href="https://github.com/telekom-mms/terraform-aws-security-groups"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/telekom-mms/terraform-aws-security-groups">View Demo</a>
    ·
    <a href="https://github.com/telekom-mms/terraform-aws-security-groups/issues/new?labels=bug&template=bug-report---.md">Report Bug</a>
    ·
    <a href="https://github.com/telekom-mms/terraform-aws-security-groups/issues/new?labels=enhancement&template=feature-request---.md">Request Feature</a>
  </p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about-the-project">About The Project</a></li>
    <li><a href="#getting-started">Getting Started</a></li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#security-features">Security Features</a></li>
    <li><a href="#psa-compliance-features">PSA Compliance Features</a></li>
    <li><a href="#outputs">Outputs</a></li>
    <li><a href="#troubleshooting">Troubleshooting</a></li>
    <li><a href="#license">License</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About The Project

This module implements a hardened 3-tier network security architecture (Web, App, Database) plus a dedicated Management tier. It enforces mandatory descriptions for all firewall rules to ensure auditability and PSA compliance.

### Features

- **3-Tier Isolation**: Pre-configured flows between tiers (Web -> App -> DB).
- **Mandatory Descriptions**: Every ingress/egress rule must have a human-readable description.
- **Zero-Egress Database**: The database tier is configured with NO outbound rules by default.
- **HTTPS Enforcement**: Web tier defaults to port 443 with optional port 80.
- **Management Tier**: Dedicated SG for restricted SSH/RDP access.
- **Custom Rules**: Support for injecting project-specific rules while maintaining the base security posture.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- USAGE -->
## Usage

### Basic Usage

```hcl
module "security_groups" {
  source = "./terraform-aws-security-groups"

  project_name = "myapp"
  environment  = "prod"
  vpc_id       = "vpc-12345678"
  name_prefix  = "myapp-prod"

  allowed_web_cidrs        = ["0.0.0.0/0"]
  allowed_management_cidrs = ["203.0.113.0/24"]
  app_port                 = 8080
  db_port                  = 5432
}
```

### Advanced Usage with Custom Rules

```hcl
module "sg" {
  source = "./terraform-aws-security-groups"

  project_name             = "complex-app"
  environment              = "prod"
  vpc_id                   = module.vpc.vpc_id
  name_prefix              = "complex-app"
  allowed_management_cidrs = ["203.0.113.0/24"]

  web_custom_ingress = [
    {
      from_port   = 8443
      to_port     = 8443
      protocol    = "tcp"
      cidr_blocks = ["1.2.3.4/32"]
      description = "Custom management webhook"
    }
  ]
}
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- SECURITY FEATURES -->
## Security Features

- **Description Enforcement**: Prevents the creation of "blind" firewall rules.
- **Lateral Movement Protection**: Rules are strictly limited to the necessary target security groups.
- **No Wide-Open Egress**: All tiers have scoped egress; DB tier has NONE.
- **Management Lockdown**: SSH/RDP access is disabled by default and requires explicit CIDR whitelisting.
- **ICMP Disabled**: Standard ping/discovery is disabled by default to reduce the attack surface.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- PSA COMPLIANCE FEATURES -->
## PSA Compliance Features

This module implements the following PSA compliance features (referencing `10-Strukturierte_PSA_Anforderungen_Netzwerk_LLM.pdf`):

### Security Controls

- **Req 6 (Access Control)**: Strict ACL-like protection for management interfaces.
- **Req 14 (L7 Inspection)**: Designed to sit behind ALB/WAF for deep inspection.
- **Req 3.66-04 (Isolation)**: Consistent naming and tagging for multi-tenant isolation.
- **Auditability**: Mandatory descriptions ensure every rule is traceable to a requirement.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- TROUBLESHOOTING -->
## Troubleshooting

### Connection Refused between Tiers

- Verify the `app_port` or `db_port` matches your application configuration.
- Check that the resources (e.g., EC2, RDS) are actually assigned to the correct security group IDs output by this module.

### SSH/RDP Not Working

- Ensure your IP is included in `allowed_management_cidrs`.
- Verify the `create_management_sg = true`.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
[contributors-shield]: https://img.shields.io/github/contributors/telekom-mms/terraform-aws-security-groups.svg?style=for-the-badge
[contributors-url]: https://github.com/telekom-mms/terraform-aws-security-groups/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/telekom-mms/terraform-aws-security-groups.svg?style=for-the-badge
[forks-url]: https://github.com/telekom-mms/terraform-aws-security-groups/network/members
[stars-shield]: https://img.shields.io/github/stars/telekom-mms/terraform-aws-security-groups.svg?style=for-the-badge
[stars-url]: https://github.com/telekom-mms/terraform-aws-security-groups/stargazers
[issues-shield]: https://img.shields.io/github/issues/telekom-mms/terraform-aws-security-groups.svg?style=for-the-badge
[issues-url]: https://github.com/telekom-mms/terraform-aws-security-groups/issues
[license-shield]: https://img.shields.io/github/license/telekom-mms/terraform-aws-security-groups.svg?style=for-the-badge
[license-url]: https://github.com/telekom-mms/terraform-aws-security-groups/blob/master/LICENSE.txt

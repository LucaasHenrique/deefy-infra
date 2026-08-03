# Infrastructure as Code (IaC) Template for AWS

This repository contains a complete Infrastructure as Code (IaC) solution, built with Terraform, to provision a production-grade AWS environment. **This is a study and learning project**, intended to explore modern AWS architecture in practice. The structure is modular, scalable, and follows AWS best practices, enabling rapid deployment and management of secure, highly-available infrastructure for containerized or VM-based applications.

## Overview

- **Modular Terraform structure** for flexible and reusable components
- **S3-backed remote state** for collaboration and reliability
- **Multi-AZ VPC** with public and private networks
- **Automated provisioning** for core AWS resources (networking, compute, storage, security)
- **Declarative architecture**—easy to adapt for different projects or environments

## Main Components & Modules

- **VPC & Subnets**: Managed and scalable, with multiple public and private subnets across Availability Zones
- **Internet Gateway, NAT Gateway, Route Tables**: For secure and efficient routing between public internet and private resources
- **Security Groups**: Customizable, least-privilege network access for instances and load balancers
- **EC2 Instances**: Declarative mapping—launch as many as you need, with flexible types/tags
- **Application Load Balancer (ALB)**: Highly-available HTTP/HTTPS endpoint ready for container or VM load distribution
- **S3 Buckets**: For static asset and artifact storage
- **ECR Repositories**: For container image hosting
- **RDS**: Extendable for managed relational databases (not included by default in `main.tf` but modules are present)

## Folder Layout

```
modules/                  # Reusable Terraform modules for each AWS resource
main.tf                   # Root composition of the infrastructure modules
variables.tf              # All configurable variables, with safe defaults
provider.tf               # AWS provider configuration
backend.tf                # Remote state backend (S3)
outputs.tf                # Useful outputs (ids, endpoints, etc.)
terraform.tfvars          # Project/environment-specific variables
```

## Getting Started

### Prerequisites
- [Terraform](https://www.terraform.io/) >= 1.0.0
- AWS credentials (environment variables or profile)
- (Optional) S3 bucket & DynamoDB table for remote state locking

### Setup and Usage
1. **Clone the repository**
2. **Configure variables**: Edit `terraform.tfvars` or export variables as needed
3. **Initialize Terraform**:
   ```bash
   terraform init
   ```
4. **Preview the changes**:
   ```bash
   terraform plan
   ```
5. **Apply the infrastructure**:
   ```bash
   terraform apply
   ```
6. **(Optional) Destroy when done**:
   ```bash
   terraform destroy
   ```

> **Tip:** State is stored remotely in S3 as defined in `backend.tf`. Make sure the bucket exists and credentials have write access.

## Variables
All configurable options are defined in `variables.tf` and can be overridden via `terraform.tfvars`. Example variables include:
- `vpc_cidr` (default: 10.0.0.0/16)
- `project_name` (default: "deefy")
- Subnet CIDRs
- Availability Zones
- EC2 instance definitions

## Outputs
After `apply`, useful IDs (VPC, subnets, security groups, etc.) will be shown, ready for composition with additional stacks or use in your CI/CD pipeline.

## Security and Best Practices
- Secrets (keys, tokens, etc.) must **never** be committed. Use secure variable injection.
- S3 remote state backend provides safer and team-ready state synchronization.
- Follows AWS recommendations for network isolation (public/private subnets, NAT, SGs).

## Extensibility
- Add or modify modules as needed (RDS, Redis, Lambda, etc.).
- Easily adapt for new environments by duplicating the `terraform.tfvars` file.
- Use the output values for orchestration or further automation.

---

Feel free to fork, adapt, and extend this template for your own AWS infrastructure needs.

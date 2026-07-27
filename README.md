```markdown
# AWS Static Hosting GitOps Lifecycle

[![Terraform](https://img.shields.io/badge/IaC-Terraform-7B42BC?logo=terraform)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-S3%20%7C%20CloudFront-232F3E?logo=amazon-aws)](https://aws.amazon.com/)
[![GitOps](https://img.shields.io/badge/GitOps-Enabled-2088FF?logo=github)](https://github.com/)

## 📌 Architecture Overview

This repository provisions an enterprise-grade static web hosting pipeline on AWS using Terraform. 

Public access to the Amazon S3 origin bucket is completely blocked to enforce security best practices. Web traffic is routed exclusively through an Amazon CloudFront Content Delivery Network (CDN) utilizing **Origin Access Control (OAC)** to sign and authorize requests to the underlying S3 storage layer.


```

```
              [ User Request ]
                     │
                     ▼
         ┌──────────────────────┐
         │   Amazon CloudFront  │ (HTTPS / Edge Caching)
         └──────────┬───────────┘
                    │ OAC Signed Request
                    ▼
         ┌──────────────────────┐
         │      Amazon S3       │ (Private / Block Public Access)
         └──────────────────────┘

```

```

---

## 🚀 Key Features

* **Strict S3 Security:** All public access to S3 is blocked; content is served securely through CloudFront OAC.
* **Reusable Static Site Module:** Clean encapsulation inside `modules/static-site`.
* **Multi-Environment Configuration:** Dedicated `dev` and `prod` environment directories managing isolated Terraform state files.
* **Separation of Content:** Website application code (`src/index.html`) is decoupled from infrastructure definitions.

---

## 🛠️ Technology Stack

* **Cloud Provider:** Amazon Web Services (AWS)
* **Core Services:** AWS S3, Amazon CloudFront, Origin Access Control (OAC)
* **Infrastructure as Code:** Terraform
* **Application Stack:** HTML5 (`src/index.html`)

---

## 📁 Repository Structure

```text
aws-static-hosting-gitops/
├── environments/
│   ├── dev/
│   │   ├── main.tf              # Development environment declaration
│   │   ├── terraform.tfstate    # Local dev state file (ignored in remote)
│   │   └── .terraform.lock.hcl
│   └── prod/
│       ├── main.tf              # Production environment declaration
│       ├── terraform.tfstate    # Local prod state file (ignored in remote)
│       └── .terraform.lock.hcl
├── modules/
│   └── static-site/             # Core reusable Terraform module
│       ├── main.tf              # Module resource definitions
│       ├── output.tf            # Module output variables
│       └── variable.tf          # Input parameters
├── src/
│   └── index.html               # Website static content source
└── .gitignore                   # Ignores sensitive terraform files & state

```

---

## ⚡ Quickstart Guide

### Prerequisites

1. [AWS CLI](https://aws.amazon.com/cli/) configured with proper access credentials.
2. [Terraform CLI](https://developer.hashicorp.com/terraform/downloads) installed locally.

### 1. Deploy Development Environment

```bash
# Navigate to the dev environment directory
cd environments/dev

# Initialize providers and modules
terraform init

# Validate configuration
terraform validate

# Review deployment plan
terraform plan

# Provision infrastructure
terraform apply

```

### 2. Verify Deployment

Find your CloudFront distribution domain name output from `terraform apply` and test in your browser or via curl:

```bash
curl -I https://<your-cloudfront-domain-id>.cloudfront.net

```

---

## 🔒 Security Best Practices

* **Zero Public Buckets:** S3 bucket policies grant access exclusively to CloudFront OAC principals.
* **State & Secret Isolation:** Sensitivity checks in `.gitignore` ensure state history (`.tfstate`) and provider caches (`.terraform/`) are excluded from Git commits.

---

## 🧹 Cleanup

To tear down provisioned AWS resources and avoid extra costs:

```bash
cd environments/dev
terraform destroy

```

```

```
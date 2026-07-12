terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "prod_static_site" {
  source      = "../../modules/static-site"
  bucket_name = "tsonenyo-portfolio-site" # Keeps the base name consistent
  environment = "prod"
}

output "prod_site_url" {
  value       = module.prod_static_site.cloudfront_domain_name
  description = "The production public URL"
}
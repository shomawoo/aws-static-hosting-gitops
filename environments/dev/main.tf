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

module "dev_static_site" {
  source      = "../../modules/static-site"
  bucket_name = "tsonenyo-portfolio-site" # Must be globally unique! Feel free to tweak this name slightly.
  environment = "dev"
}

output "dev_site_url" {
  value       = module.dev_static_site.cloudfront_domain_name
  description = "The public URL to access your deployed website"
}
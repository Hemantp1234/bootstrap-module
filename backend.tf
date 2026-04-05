terraform {
  backend "s3" {
    bucket         = "sre-portfolio-terraform-state-hemantpatil"
    key            = "bootstrap-module/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "sre-portfolio-state-lock"
    encrypt        = true
    
  }
}
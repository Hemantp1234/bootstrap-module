variable "aws_region" {
  default = "ap-south-1"
}

variable "github_repo" {
  description = "Format: username/repo-name"
  type        = string
}

variable "project_name" {
  default = "sre-portfolio"
}

variable "iam_policy_arn" {
  description = "The ARN of the policy you want to give to GitHub Actions"
  type        = string
  default     = "arn:aws:iam::aws:policy/AdministratorAccess" # Default to high power for your lab
}
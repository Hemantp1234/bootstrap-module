# --- 1. THE STORAGE (S3 & DynamoDB) ---
resource "aws_s3_bucket" "state" {
  bucket        = "${var.project_name}-terraform-state-hemantpatil"
  force_destroy = false # Safety first!
}

resource "aws_s3_bucket_versioning" "state_versioning" {
  bucket = aws_s3_bucket.state.id
  versioning_configuration {
    status = "Enabled" # Your backup "Undo" button
  }
}

resource "aws_dynamodb_table" "lock" {
  name         = "${var.project_name}-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

# --- 2. THE TRUST (OIDC) ---
resource "aws_iam_openid_connect_provider" "github" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

# --- 3. THE IDENTITY (IAM Role) ---
resource "aws_iam_role" "gh_role" {
  name = "${var.project_name}-github-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRoleWithWebIdentity"
      Effect = "Allow"
      Principal = { Federated = aws_iam_openid_connect_provider.github.arn }
      Condition = {
        StringLike = {
          "token.actions.githubusercontent.com:sub" : "repo:${var.github_repo}:*"
        }
      }
    }]
  })
}

# --- 4. THE POWER (Flexible Policy) ---
resource "aws_iam_role_policy_attachment" "custom_attachment" {
  role       = aws_iam_role.gh_role.name
  policy_arn = var.iam_policy_arn
}
output "GITHUB_ROLE_ARN" {
  value = aws_iam_role.gh_role.arn
}

output "STATE_BUCKET_NAME" {
  value = aws_s3_bucket.state.id
}

output "DYNAMODB_TABLE" {
  value = aws_dynamodb_table.lock.name
}
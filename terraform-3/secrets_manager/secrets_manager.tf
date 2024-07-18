module "secrets_manager_dockerhub_credentials" {
  source  = "terraform-aws-modules/secrets-manager/aws"
  version = "1.1.2"

  # Secret names must contain 1-512 Unicode characters and be prefixed with ecr-pullthroughcache/
  name_prefix = "ecr-pullthroughcache/dockerhub-credentials"
  description = "Dockerhub credentials"

  # For example only
  recovery_window_in_days = 0
  secret_string = jsonencode({
    username    = "example"
    accessToken = "YouShouldNotStoreThisInPlainText"
  })

  # Policy
  create_policy       = true
  block_public_policy = true
  policy_statements = {
    read = {
      sid = "AllowAccountRead"
      principals = [{
        type        = "AWS"
        identifiers = ["arn:aws:iam::${local.account_id}:root"]
      }]
      actions   = ["secretsmanager:GetSecretValue"]
      resources = ["*"]
    }
  }

  tags = local.tags
}

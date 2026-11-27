resource "aws_codestarconnections_connection" "github-connection" {
  name          = var.aws_codestarconnections_connection_name
  provider_type = var.aws_codestar_provider_type
}

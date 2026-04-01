locals {
  common_tags = {
    Environment = var.environment
    Project     = "terraform-aws-alb"
  }
}

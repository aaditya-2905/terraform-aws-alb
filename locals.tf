locals {
  common_tags = {
    Environment = var.environment
    Project     = "alb-wrapper"
  }
}

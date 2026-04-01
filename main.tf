module "alb" {
  source = "./modules/alb"

  create_alb                 = true
  name                       = var.name
  internal                   = var.internal
  vpc_id                     = var.vpc_id
  subnets                    = var.subnet_ids
  security_groups            = [var.sg_id]
  enable_deletion_protection = var.enable_deletion_protection

  target_groups = var.target_groups
  listeners     = var.listeners

  tags = merge(local.common_tags, var.tags)
}

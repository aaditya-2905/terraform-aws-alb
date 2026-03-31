module "alb" {
  source = "./modules/alb"

  vpc_id            = var.vpc_id
  subnet_ids        = var.subnet_ids
  security_group_id = var.sg_id
  target_port       = 80
  tags              = local.common_tags
}

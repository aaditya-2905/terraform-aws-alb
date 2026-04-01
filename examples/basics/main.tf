module "alb_basic" {
  source = "../../"

  environment = "example"
  name        = "basic-alb"
  vpc_id      = var.vpc_id
  subnet_ids  = var.subnet_ids
  sg_id       = "sg-12345678"

  target_groups = {
    web-tg = {
      port = 80
    }
  }

  listeners = {
    http = {
      port             = 80
      target_group_key = "web-tg"
    }
  }

  tags = {
    Project = "example-project"
  }
}

output "alb_dns_name" {
  value = module.alb_basic.alb_dns_name
}

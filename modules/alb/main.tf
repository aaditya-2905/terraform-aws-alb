locals {
  create_alb           = var.create_alb
  create_target_groups = var.create_alb && length(var.target_groups) > 0
  create_listeners     = var.create_alb && length(var.listeners) > 0
}

resource "aws_lb" "this" {
  count = local.create_alb ? 1 : 0

  name               = var.name
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnets

  enable_deletion_protection = var.enable_deletion_protection

  tags = merge(
    {
      Name = var.name
    },
    var.tags
  )
}

resource "aws_lb_target_group" "this" {
  for_each = local.create_target_groups ? var.target_groups : {}

  name        = each.key
  port        = try(each.value.port, 80)
  protocol    = try(each.value.protocol, "HTTP")
  vpc_id      = var.vpc_id
  target_type = try(each.value.target_type, "instance")

  deregistration_delay = try(each.value.deregistration_delay, 300)

  dynamic "health_check" {
    for_each = length(keys(try(each.value.health_check, {}))) > 0 ? [each.value.health_check] : []
    content {
      enabled             = try(health_check.value.enabled, true)
      interval            = try(health_check.value.interval, 30)
      path                = try(health_check.value.path, "/")
      port                = try(health_check.value.port, "traffic-port")
      protocol            = try(health_check.value.protocol, "HTTP")
      timeout             = try(health_check.value.timeout, 5)
      healthy_threshold   = try(health_check.value.healthy_threshold, 3)
      unhealthy_threshold = try(health_check.value.unhealthy_threshold, 3)
      matcher             = try(health_check.value.matcher, "200")
    }
  }

  tags = merge(
    {
      Name = each.key
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener" "this" {
  for_each = local.create_listeners ? var.listeners : {}

  load_balancer_arn = aws_lb.this[0].arn
  port              = try(each.value.port, 80)
  protocol          = try(each.value.protocol, "HTTP")

  ssl_policy      = try(each.value.ssl_policy, null)
  certificate_arn = try(each.value.certificate_arn, null)

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this[each.value.target_group_key].arn
  }

  tags = merge(
    {
      Name = each.key
    },
    var.tags
  )
}

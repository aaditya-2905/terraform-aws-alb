output "alb_dns_name" {
  description = "The DNS name of the VPC"
  value       = module.alb.lb_dns_name
}

output "target_group_arns" {
  description = "ARNs of the target groups"
  value       = module.alb.target_group_arns
}

output "listener_arns" {
  description = "ARNs of the listeners"
  value       = module.alb.listener_arns
}

output "target_group_arns" {
  description = "Map of target group ARNs"
  value = {
    for k, v in aws_lb_target_group.this :
    k => v.arn
  }
}

output "alb_dns_name" {
  description = "The DNS name of the VPC"
  value       = module.alb.lb_dns_name
}

output "listener_arns" {
  description = "ARNs of the listeners"
  value       = module.alb.listener_arns
}

output "target_group_arns" {
  description = "Map of target group ARNs"
  value       = module.alb.target_group_arns
}

output "lb_arn" {
  description = "ARN's of the load balancer"
  value       = module.alb.lb_arn
}

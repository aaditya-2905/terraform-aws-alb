output "lb_id" {
  description = "The ID and ARN of the load balancer we created"
  value       = try(aws_lb.this[0].id, "")
}

output "lb_arn" {
  description = "The ID and ARN of the load balancer we created"
  value       = try(aws_lb.this[0].arn, "")
}

output "lb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = try(aws_lb.this[0].dns_name, "")
}

output "lb_zone_id" {
  description = "The zone_id of the load balancer to assist with creating DNS records"
  value       = try(aws_lb.this[0].zone_id, "")
}

output "target_group_arns" {
  description = "Map of target group ARNs"
  value = {
    for k, v in aws_lb_target_group.this :
    k => v.arn
  }
}

output "target_group_names" {
  description = "Names of the target groups"
  value       = { for k, v in aws_lb_target_group.this : k => v.name }
}

output "listener_arns" {
  description = "ARNs of the listeners"
  value       = { for k, v in aws_lb_listener.this : k => v.arn }
}

# AWS Application Load Balancer (ALB) Terraform Module

A production-grade, highly flexible, and reusable Terraform module for provisioning an AWS Application Load Balancer (ALB) following Terraform Registry standards.

## 🚀 Features

- **Fully Dynamic**: Supports any number of target groups and listeners using `for_each`.
- **Flexible Configuration**: Uses `optional()` types and `try()` logic for optional attributes (HTTPS, health checks, etc.).
- **Production-Ready**: Adheres to AWS best practices with configurable deletion protection, tagging, and health checks.
- **Minimal Inputs**: Works with sensible defaults while allowing deep customization.

## 📦 Usage

### Minimal Example
```hcl
module "alb" {
  source  = "aaditya-2905/alb/aws"
  version = "~> 1.0"

  environment = "dev"
  name        = "my-alb"
  vpc_id      = "vpc-12345678"
  subnet_ids  = ["subnet-12345678", "subnet-87654321"]
  sg_id       = "sg-12345678"
  
  target_groups = {
    web-tg = {}
  }

  listeners = {
    http = {
      target_group_key = "web-tg"
    }
  }
}
```

### Advanced Example (HTTPS & Custom Health Checks)
```hcl
module "alb" {
  source  = "aaditya-2905/alb/aws"

  environment     = "prod"
  name            = "app-alb"
  internal        = false
  vpc_id          = "vpc-12345678"
  subnet_ids      = ["subnet-12345678", "subnet-87654321"]
  sg_id           = "sg-12345678"

  target_groups = {
    api-tg = {
      port     = 8080
      protocol = "HTTP"
      health_check = {
        path     = "/health"
        interval = 60
      }
    }
  }

  listeners = {
    https = {
      port             = 443
      protocol         = "HTTPS"
      ssl_policy       = "ELBSecurityPolicy-2016-08"
      certificate_arn  = "arn:aws:acm:region:account:certificate/uuid"
      target_group_key = "api-tg"
    }
  }

  tags = {
    Project = "my-app"
  }
}
```

## 📥 Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `environment` | Environment name (e.g. dev, prod) | `string` | n/a | **Yes** |
| `name` | The name of the ALB | `string` | n/a | **Yes** |
| `vpc_id` | The VPC ID where resources will be created | `string` | n/a | **Yes** |
| `subnet_ids` | A list of subnet IDs to attach to the LB | `list(string)` | n/a | **Yes** |
| `sg_id` | Security Group ID for ALB | `string` | n/a | **Yes** |
| `internal` | If true, the LB will be internal | `bool` | `false` | No |
| `enable_deletion_protection` | If true, deletion of the load balancer will be disabled | `bool` | `false` | No |
| `target_groups` | Map of target group configurations | `map(object)` | `{}` | No |
| `listeners` | Map of listener configurations | `map(object)` | `{}` | No |
| `tags` | A map of tags to add to all resources | `map(string)` | `{}` | No |

## 📤 Outputs

| Name | Description |
|------|-------------|
| `alb_dns_name` | The DNS name of the ALB |
| `target_group_arns` | ARNs of the target groups created |
| `listener_arns` | ARNs of the listeners created |

## 🛠️ Requirements

- Terraform >= 1.3.0
- AWS Provider >= 4.0.0

## 📄 License

MIT

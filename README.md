# Terraform AWS ALB Module

This module provisions an AWS Application Load Balancer (ALB) along with a target group and listener. It is designed to be reusable and can be integrated with EC2, Auto Scaling Groups, or container-based workloads.

---

## 🚀 Features

* Creates an Application Load Balancer (ALB)
* Configures target group for backend instances
* Sets up HTTP listener (port 80)
* Supports health checks
* Integrates with VPC and security groups
* Environment-based tagging

---

## 📦 Usage

```hcl
provider "aws" {
  region = "ap-south-1"
}

module "alb" {
  source = "aaditya-2905/alb/aws"

  environment = "dev"
  vpc_id      = "vpc-xxxxxxxx"
  subnet_ids  = ["subnet-xxxxxx", "subnet-yyyyyy"]
  sg_id       = "sg-xxxxxxxx"
}
```

---

## 📥 Inputs

| Name        | Description                               | Type         | Required |
| ----------- | ----------------------------------------- | ------------ | -------- |
| environment | Environment name (dev/prod)               | string       | ✅        |
| vpc_id      | VPC ID                                    | string       | ✅        |
| subnet_ids  | List of subnet IDs (multi-AZ recommended) | list(string) | ✅        |
| sg_id       | Security Group ID for ALB                 | string       | ✅        |

---

## 📤 Outputs

| Name             | Description             |
| ---------------- | ----------------------- |
| alb_dns_name     | DNS name of the ALB     |
| target_group_arn | ARN of the target group |

---

## 🧠 Notes

* ALB must be deployed in public subnets for internet-facing access
* Ensure security group allows inbound HTTP (port 80)
* Backend instances must be registered to the target group
* Health check path is set to `/` by default

---

## 🔗 Example

See the `examples/basic` directory for a working example.

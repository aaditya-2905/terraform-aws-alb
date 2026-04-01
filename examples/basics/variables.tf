variable "vpc_id" {
  description = "VPC ID for the example"
  type        = string
  default     = "vpc-12345678"
}

variable "subnet_ids" {
  description = "Subnet IDs for the example"
  type        = list(string)
  default     = ["subnet-12345678", "subnet-87654321"]
}

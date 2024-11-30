# AWS EC2 Security Group Terraform Outputs

output "public_sg_group_id" {
  description = "The ID of the security group"
  value       = module.public_sg.security_group_id
}

output "public_sg_group_vpc_id" {
  description = "The VPC ID"
  value       = module.public_sg.security_group_vpc_id
}

output "public_sg_group_name" {
  description = "The name of the security group"
  value       = module.public_sg.security_group_name
}

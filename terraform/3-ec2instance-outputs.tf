# AWS EC2 Instance Terraform Outputs
output "ec2_poc-master_ids" {
  description = "EC2 Poc Master instance ID"
  value       = module.ec2_public.id
}

output "ec2_poc-master_public-ip" {
  description = "Public IP address EC2 instance"
  value       = module.ec2_public.public_ip 
}
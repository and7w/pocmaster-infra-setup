# AWS EC2 Instance Terraform Outputs
# Public EC2 Instances - PocMaster Host

## ec2_pocmaster_public_instance_ids
output "ec2_pocmaster_public_instance_ids" {
  description = "EC2 instance ID"
  value       = module.ec2_public.id
}

## ec2_pocmaster_public_ip
output "ec2_pocmaster_public_ip" {
  description = "Public IP address EC2 instance"
  value       = module.ec2_public.public_ip 
}

## ec2_pocmaster_private_ip
output "ec2_pocmaster_private_ip" {
  description = "Private IP address EC2 instance"
  value       = module.ec2_public.private_ip
}
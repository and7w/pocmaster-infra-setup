# AWS EC2 Security Group Terraform Module
# Security Group for Public Host
module "public_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.2"
  name        = "pocmaster-public-sg"
  description = "Security group with SSH port open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id      = module.vpc.vpc_id
  # Ingress Rules & CIDR Block
  ingress_rules = ["ssh-tcp","https-443-tcp", "http-80-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      cidr_blocks = "0.0.0.0/0"
      description = "Allow HTTP traffic on port 8080"
      protocol    = "tcp"
    },
    {
      from_port   = 8081
      to_port     = 8081
      cidr_blocks = "0.0.0.0/0"
      description = "Allow HTTP traffic on port 8080"
      protocol    = "tcp"
    },
    {
      from_port   = 3000
      to_port     = 3000
      cidr_blocks = "0.0.0.0/0"
      description = "Allow traffic on port 3000"
      protocol    = "tcp"
    },
    {
      from_port   = 9090
      to_port     = 9090
      cidr_blocks = "0.0.0.0/0"
      description = "Allow traffic on port 9090"
      protocol    = "tcp"
    }
  ]

  # Egress Rule - all-all open
  egress_rules = ["all-all"]
  tags = local.common_tags  
}
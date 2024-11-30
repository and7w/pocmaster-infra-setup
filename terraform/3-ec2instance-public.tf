# AWS EC2 Instance Terraform Module
module "ec2_public" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.0"
  name                   = "${var.business_divsion}-Host"
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  monitoring             = false
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.public_sg.security_group_id]
  tags = local.common_tags
}

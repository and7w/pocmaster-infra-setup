# Create a Null Resource and Provisioners
resource "null_resource" "name" {
  depends_on = [module.ec2_public]
  # Connection Block for Provisioners to connect to EC2 Instance
  connection {
    type     = "ssh"
    host     = aws_eip.poc-master_eip.public_ip
    user     = "ec2-user"
    password = ""
    private_key = file("~/.ssh/key-terraform.pem")
  }

}


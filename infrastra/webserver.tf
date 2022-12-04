# create an EC2 instance
resource "aws_instance" "webserver" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  # the VPC subnet
  subnet_id = aws_subnet.main-public.id
  # the security group
  vpc_security_group_ids = [aws_security_group.sg.id]
  # the public SSH key
  key_name = aws_key_pair.mykey.key_name
  # user data
  user_data = file("scripts/webserver.sh")
  tags = {
    Name = "webserver"
  }

# Provision config files to /tmp directory
  provisioner "file" {
    source      = "configs/webserver/"
    destination = "/tmp"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("yuriy_ec2.pem")
      host        = aws_instance.webserver.public_ip
    }
  }

}

output "instances" {
  value = aws_instance.webserver.public_ip
  description = "PublicIP address details for Webserver"
}

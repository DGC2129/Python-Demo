resource "aws_instance" "web-1" {
  ami                         = var.imagename
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.subnet1-public.id
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name  = "${var.vpc_name}-Public-Server-1"
    Env   = var.environment
    Owner = var.owner
  }
  user_data = <<-EOF
		#!/bin/bash
        sudo apt-get update
		sudo apt-get install -y nginx jq net-tools 
		sudo systemctl start nginx
		sudo systemctl enable nginx
		echo "<center><h1>Deployed via Terraform</h1></center>" | sudo tee /var/www/html/index.nginx-debian.html
        echo "<center><h1>${var.vpc_name}-Public-Server-1</h1></center>" | sudo tee /var/www/html/index.nginx-debian.html
	EOF
}

#resource "aws_instance" "web-2" {
#  ami                         = var.imagename
#  instance_type               = var.instance_type
#  key_name                    = var.key_name
#  subnet_id                   = aws_subnet.subnet2-public.id
#  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
#  associate_public_ip_address = true
#  tags = {
#    Name  = "${var.vpc_name}-Public-Server-2"
#    Env   = var.environment
#    Owner = var.owner
#  }
#  user_data = <<-EOF
#		#!/bin/bash
#        sudo apt-get update
#		sudo apt-get install -y nginx jq net-tools 
#		sudo systemctl start nginx
#		sudo systemctl enable nginx
#		echo "<center><h1>Deployed via Terraform</h1></center>" | sudo tee /var/www/html/index.nginx-debian.html
#        echo "<center><h1>${var.vpc_name}-Public-Server-2</h1></center>" | sudo tee /var/www/html/index.nginx-debian.html
#	EOF
#}
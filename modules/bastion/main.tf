# locals {
#   instance_name = "${terraform.workspace} - instance"
# }

# Bastion Host
resource "aws_instance" "bastion" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = var.vpc_security_group_ids
  subnet_id                   = var.subnet_id
  availability_zone           = var.az1
  key_name                    = var.key_name
  associate_public_ip_address = true
  provisioner "file" {
    source      = "~/Keypairs/jengomartkeypair"
    destination = "/home/ec2-user/Keypairs/jengomartkeypair"
  }
  connection {
    type        = "ssh"
    host        = self.public_ip
    private_key = file("~/Keypairs/jengomartkeypair")
    user        = "ec2-user"
  }
  user_data = <<-EOF
  #!/bin/bash
  sudo chmod 400 Keypairs/jengomartkeypair
  sudo hostnamectl set-hostname bastion
  EOF
  tags = {
    Name = var.bastion_name
  }
}
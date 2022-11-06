# Bastion Host Security Group
resource "aws_security_group" "bastionSG" {
  name        = var.sg_name1
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "ssh from VPC"
    from_port   = var.port_ssh
    to_port     = var.port_ssh
    protocol    = "tcp"
    cidr_blocks = var.all
  }

  egress {
    from_port   = var.egress
    to_port     = var.egress
    protocol    = "-1"
    cidr_blocks = var.all
  }

  tags = {
    Name = var.sg_name1
  }
}

# Database Security Group
resource "aws_security_group" "rdsSG" {
  name        = var.sg_name2
  description = "Allow inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow Mysql access"
    from_port   = var.port_mysql
    to_port     = var.port_mysql
    protocol    = "tcp"
    cidr_blocks = var.public_cidr
  }

  egress {
    from_port   = var.egress
    to_port     = var.egress 
    protocol    = "-1"
    cidr_blocks = var.all
  }

  tags = {
    Name = var.sg_name2
  }
}

# Docker Host Security Group
resource "aws_security_group" "dockerSG" {
  name        = var.sg_name3
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from VPC"
    from_port   = var.port_ssh
    to_port     = var.port_ssh
    protocol    = "tcp"
    cidr_blocks = var.all
  }

  ingress {
    description = "Allow custom_http from VPC"
    from_port   = var.port_custom
    to_port     = var.port_custom
    protocol    = "tcp"
    cidr_blocks = var.all
  }

  ingress {
    description = "Allow http from VPC"
    from_port   = var.port_http
    to_port     = var.port_http
    protocol    = "tcp"
    cidr_blocks = var.all
  }

  egress {
    from_port   = var.egress
    to_port     = var.egress 
    protocol    = "-1"
    cidr_blocks = var.all
  }

  tags = {
    Name = var.sg_name3
  }
} 

# Jenkins Security Group
resource "aws_security_group" "jenkinsSG" {
  name        = var.sg_name4
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from VPC"
    from_port   = var.port_ssh
    to_port     = var.port_ssh
    protocol    = "tcp"
    cidr_blocks = var.all
  }

  ingress {
    description = "Allow custom_http from VPC"
    from_port   = var.port_custom
    to_port     = var.port_custom
    protocol    = "tcp"
    cidr_blocks = var.all
  }

  egress {
    from_port   = var.egress
    to_port     = var.egress
    protocol    = "-1"
    cidr_blocks = var.all
  }

  tags = {
    Name = var.sg_name4
  }
} 
 
# Ansible Security Group
resource "aws_security_group" "ansibleSG" {
  name        = var.sg_name5
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "all traffic from VPC"
    from_port   = var.port_ssh
    to_port     = var.port_ssh
    protocol    = "tcp"
    cidr_blocks = var.all
  }

  egress {
    from_port        = var.egress
    to_port          = var.egress 
    protocol         = "-1"
    cidr_blocks      = var.all
  }

  tags = {
    Name = var.sg_name5 
  }
}

# Sonarqube Security Group
resource "aws_security_group" "sonarSG" {
  name        = var.sg_name6
  description = "Allow inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = var.port_sonar
    to_port     = var.port_sonar
    protocol    = "tcp"
    cidr_blocks = var.all
  }

  ingress {
    description = "SSH"
    from_port   = var.port_ssh
    to_port     = var.port_ssh
    protocol    = "tcp"
    cidr_blocks = var.all
  }

  egress {
    from_port   = var.egress
    to_port     = var.egress
    protocol    = "-1"
    cidr_blocks = var.all
  }

  tags = {
    Name = var.sg_name6 
  }
}

# Docker_lb Security Group
resource "aws_security_group" "docker_lbSG" {
  name        = var.sg_name7
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow http from VPC"
    from_port   = var.port_http
    to_port     = var.port_http
    protocol    = "tcp"
    cidr_blocks = var.all
  }

  egress {
    from_port   = var.egress
    to_port     = var.egress
    protocol    = "-1"
    cidr_blocks = var.all
  }

  tags = {
    Name = var.sg_name7
  }
} 

# Jenkins_lb Security Group
resource "aws_security_group" "jenkins_lbSG" {
  name        = var.sg_name8
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow http from VPC"
    from_port   = var.port_http
    to_port     = var.port_http
    protocol    = "tcp"
    cidr_blocks = var.all
  }

    ingress {
    description = "Allow http from VPC"
    from_port   = var.port_custom
    to_port     = var.port_custom
    protocol    = "tcp"
    cidr_blocks = var.all
  }

  egress {
    from_port   = var.egress
    to_port     = var.egress 
    protocol    = "-1"
    cidr_blocks = var.all
  }

  tags = {
    Name = var.sg_name8
  }
}
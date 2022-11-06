# An EC2 Instance for Docker host using a t2.micro RedHat ami
  resource "aws_instance" "docker" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = var.vpc_security_group_ids
  subnet_id                   = var.subnet_id
  availability_zone           = var.availability_zone
  key_name                    = var.key_name
  
  user_data = <<-EOF
#!/bin/bash
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum update -y
sudo yum install docker-ce docker-ce-cli -y
sudo yum install python3 python3-pip -y
sudo alternatives --set python /usr/bin/python3
sudo pip3 install docker-py 
sudo systemctl start docker
sudo systemctl enable docker
echo "license_key: 3e384ca1e73f3e00902f23574f7f847cb486NRAL" | sudo tee -a /etc/newrelic-infra.yml
sudo curl -o /etc/yum.repos.d/newrelic-infra.repo https://download.newrelic.com/infrastructure_agent/linux/yum/el/7/x86_64/newrelic-infra.repo
sudo yum -q makecache -y --disablerepo='*' --enablerepo='newrelic-infra'
sudo yum install newrelic-infra -y
sudo usermod -aG docker ec2-user
sudo hostnamectl set-hostname Docker
EOF
  tags = {
    Name = "docker"
  }
}
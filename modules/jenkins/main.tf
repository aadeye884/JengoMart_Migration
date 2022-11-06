# Jenkins Server (using Red Hat for ami and t2.medium for instance type)
resource "aws_instance" "jenkins" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id              = var.subnet_id
  availability_zone      = var.availability_zone
  key_name               = var.key_name

  user_data = <<-EOF
#!/bin/bash
sudo yum update -y
sudo yum install wget -y
sudo yum install git -y
sudo yum install maven -y
sudo wget https://get.jenkins.io/redhat/jenkins-2.346-1.1.noarch.rpm
sudo rpm -ivh jenkins-2.346-1.1.noarch.rpm
sudo yum install java-11-openjdk -y
sudo systemctl daemon-reload
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user
sudo usermod -aG docker jenkins
echo "license_key: fbf50d8307cef908acf2a16f0e73317ccf92NRAL" | sudo tee -a /etc/newrelic-infra.yml
sudo curl -o /etc/yum.repos.d/newrelic-infra.repo https://download.newrelic.com/infrastructure_agent/linux/yum/el/7/x86_64/newrelic-infra.repo
sudo yum -q makecache -y --disablerepo='*' --enablerepo='newrelic-infra'
sudo yum install newrelic-infra -y
sudo hostnamectl set-hostname Jenkins
EOF 
  tags = {
    Name = "jenkins"
  }
}

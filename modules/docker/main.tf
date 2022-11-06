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
sudo yum upgrade -y
sudo yum install unzip -y
sudo yum install httpd -y
sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y
sudo yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y
sudo dnf module install php:remi-7.3 -y
sudo yum install php-mysql -y
sudo yum install php-gd -y
sudo yum install php-intl -y
sudo yum install git -y
git clone https://aadeye884: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@github.com/aadeye884/JengoMart_Migration.git
sudo chmod -R 777 /var/www/html/
cd Planet-Project-Mgt-CRM-Application-Teams
cp pipm_crm.zip /var/www/html/
cd /var/www/html/
sudo yum install unzip -y
sudo unzip pipm_crm.zip
cd For_Deployment
cp -r * /var/www/html/
cd /var/www/html/
sudo rm -rf For_Deployment pipm_crm.zip __MACOSX
cd /var/www/
sudo chmod -R 777 html/
sudo setenforce 0
sudo service httpd start
sudo chkconfig httpd on
EOF
  tags = {
    Name = "docker"
  }
}
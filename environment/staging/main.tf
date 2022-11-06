module "staging_vpc" {
  source = "../../modules/vpc"
}

module "staging_keypair" {
  source   = "../../modules/keypair"
  key_name = "jengomartkeypair"
}

module "staging_security_group" {
  source   = "../../modules/security_group"
  sg_name1 = "bastion_sg"   
  sg_name2 = "rds_sg"
  sg_name3 = "dockerSG"
  sg_name4 = "jenkinsSG"
  sg_name5 = "ansibleSG"
  sg_name6 = "sonarSG"
  sg_name7 = "docker_lbSG"
  sg_name8 = "jenkins_lbSG"
  vpc_id   = module.staging_vpc.vpc-id
}

module "staging_bastion" {
  source                 = "../../modules/bastion"
  instance_type          = "t2.micro"
  ami                    = "ami-06640050dc3f556bb"
  subnet_id              = module.staging_vpc.subnet-id1
  availability_zone      = "us-east-1a"
  key_name               = module.staging_keypair.key_name
  vpc_security_group_ids = [module.staging_security_group.bastionSG]
}

# module "staging_rds" {
#   source    = "../../modules/rds"
#   rds_name  = "rds_subnet_groups"
#   vpc_sg_id = [module.staging_security_group.rdsSG]
#   subnet_id = [module.staging_vpc.subnet-id3, module.staging_vpc.subnet-id4]
# }

module "staging_docker" {
  source                 = "../../modules/docker"
  ami                    = "ami-06640050dc3f556bb"
  instance_type          = "t2.medium"
  availability_zone      = "us-east-1a"
  vpc_security_group_ids = [module.staging_security_group.dockerSG]
  subnet_id              = module.staging_vpc.subnet-id3
  key_name               = module.staging_keypair.key_name
}

module "staging_jenkins" {
  source                 = "../../modules/jenkins"
  ami                    = "ami-06640050dc3f556bb"
  instance_type          = "t2.medium"
  availability_zone      = "us-east-1a"
  vpc_security_group_ids = [module.staging_security_group.jenkinsSG]
  subnet_id              = module.staging_vpc.subnet-id3
  key_name               = module.staging_keypair.key_name
}

module "staging_iam" {
    source = "../../modules/iam"
}

module "staging_ansible" {
  source                 = "../../modules/ansible"
  ami                    = "ami-06640050dc3f556bb"
  instance_type          = "t2.micro"
  availability_zone      = "us-east-1a"
  vpc_security_group_ids = [module.staging_security_group.ansibleSG]
  subnet_id              = module.staging_vpc.subnet-id3
  key_name               = module.staging_keypair.key_name
  iam_instance_profile   = module.staging_iam.ansible-nody-instance-profile
}

module "staging_sonarqube" {
  source                 = "../../modules/sonarqube"
  instance_type_sonar    = "t2.medium"
  sonar_ami              = "ami-08c40ec9ead489470"
  subnet_id              = module.staging_vpc.subnet-id1
  availability_zone      = "us-east-1a"
  key_name               = module.staging_keypair.key_name
  vpc_security_group_ids = [module.staging_security_group.sonarSG]
}

module "staging_docker_lb" {
  source = "../../modules/docker_lb"
  vpc_name = module.staging_vpc.vpc-id
  vpc_security_group_ids = [module.staging_security_group.docker_lbSG]
  subnet_id = [module.staging_vpc.subnet-id1, module.staging_vpc.subnet-id2]
}

module "staging_jenkins_lb" {
  source = "../../modules/jenkins_lb"
  elb_name = "jenkins-lb"
  subnet_id = [module.staging_vpc.subnet-id1]
  elb_sg1 = [module.staging_security_group.jenkins_lbSG]
  elb_tag      = "jenkins-lb"
  elb_instance = module.staging_jenkins.jenkins_ID
}

module "staging_asg" {
  source = "../../modules/asg"
  ami-name = "staging-DockerASG"
  instance-type       = "t2.medium"
  launch-configname = "stage-docker-lc"
  sg_name3 = [module.staging_security_group.dockerSG]
  key_name = module.staging_keypair.key_name
  asg-group-name = "staging-docker-asg"
  vpc-zone-identifier = [module.staging_vpc.subnet-id3, module.staging_vpc.subnet-id4]
  target-group-arn = module.staging_docker_lb.tg_arn
  asg-policy = "docker-asg-policy"
  target-instance = module.staging_docker.docker_id
  depends_on = [time_sleep.wait_600_seconds]
}

resource "time_sleep" "wait_600_seconds" {
  depends_on = [module.staging_docker]

  create_duration = "600s"
}

module "staging_route53" {
  source      = "../../modules/route53"
  domain_name = "www.elizabethfolzgroup.com"
  dns_name    = module.staging_docker_lb.Load_Balancer_dns
  zone_id     = module.staging_docker_lb.Load_Balancer_zone_id 
}
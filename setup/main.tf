locals {
  vpc_name          = "${terraform.workspace}-newproject-vpc"
  bastion_name      = "${terraform.workspace}-newproject-bastion"
  rds_name          = "${terraform.workspace}-newproject-rds"
  docker_name       = "${terraform.workspace}-newproject-docker"
  alb_name          = "${terraform.workspace}-newproject-alb"
  tg_name           = "${terraform.workspace}-newproject-tg"
  pubsn1            = "${terraform.workspace}-newproject-pubsn1"
  pubsn2            = "${terraform.workspace}-newproject-pubsn2"
  prvsn1            = "${terraform.workspace}-newproject-prvsn1"
  prvsn2            = "${terraform.workspace}-newproject-prvsn2"
  prvsn3            = "${terraform.workspace}-newproject-prvsn3"
  prvsn4            = "${terraform.workspace}-newproject-prvsn4"
  igw_name          = "${terraform.workspace}-newproject-igw"
  pubsnrt           = "${terraform.workspace}-newproject-pubsnrt"
  nat-gw_name       = "${terraform.workspace}-newproject-nat-gw"
  prvsnrt           = "${terraform.workspace}-newproject-prvsnrt"
  ami-name          = "${terraform.workspace}-newproject-Dockerami"
  asg_lc_name       = "${terraform.workspace}-newproject-asg_lc"
  instance_name_asg = "${terraform.workspace}-newproject-Dockerinstanceasg"
}

module "vpc" {
  source      = "../modules/vpc"
  vpc_name    = local.vpc_name
  vpc_cidr    = var.vpc_cidr
  pubsn1      = local.pubsn1
  pubsn1_cidr = var.pubsn1_cidr
  pubsn2      = local.pubsn2
  pubsn2_cidr = var.pubsn2_cidr
  pubsnrt     = local.pubsnrt
  prvsnrt     = local.prvsnrt
  az1         = var.az1
  az2         = var.az2
  prvsn1      = local.prvsn1
  prvsn1_cidr = var.prvsn1_cidr
  prvsn2      = local.prvsn2
  prvsn2_cidr = var.prvsn2_cidr
  prvsn3      = local.prvsn3
  prvsn3_cidr = var.prvsn3_cidr
  prvsn4      = local.prvsn4
  prvsn4_cidr = var.prvsn4_cidr
  igw_name    = local.igw_name
  nat-gw_name = local.nat-gw_name
  all_cidr    = var.all_cidr
}

module "keypair" {
  source   = "../modules/keypair"
  key_name = "Keypairs/newkeypair"
}

module "security_group" {
  source   = "../modules/security_group"
  sg_name1 = "bastion_sg"
  sg_name2 = "rds_sg"
  sg_name3 = "dockerSG"
  sg_name4 = "docker_lbSG"
  vpc_id   = module.vpc.vpc-id
}

module "bastion" {
  source                 = "../modules/bastion"
  instance_type          = var.instance_type
  ami                    = var.ami
  subnet_id              = module.vpc.subnet-id1
  az1                    = var.az1
  key_name               = module.keypair.key_name
  vpc_security_group_ids = [module.security_group.bastionSG]
  bastion_name           = local.bastion_name
}

module "rds" {
  source    = "../modules/rds"
  rds_name  = local.rds_name
  vpc_sg_id = [module.security_group.rdsSG]
  subnet_id = [module.vpc.subnet-id5, module.vpc.subnet-id6]
}

module "docker" {
  source                 = "../modules/docker"
  ami                    = var.ami
  instance_type_docker   = var.instance_type_docker
  availability_zone      = var.az1
  vpc_security_group_ids = [module.security_group.dockerSG]
  subnet_id              = module.vpc.subnet-id3
  key_name               = module.keypair.key_name
  docker_name            = local.docker_name
}

module "docker_lb" {
  source                 = "../modules/docker_lb"
  vpc_name               = module.vpc.vpc-id
  vpc_security_group_ids = [module.security_group.docker_lbSG]
  subnet_id              = [module.vpc.subnet-id1, module.vpc.subnet-id2]
  port                   = 8080
  tg_name                = local.tg_name
  alb_name               = local.alb_name
}

module "asg" {
  source              = "../modules/asg"
  ami-name            = local.ami-name
  asg_lc_name         = local.asg_lc_name
  instance-type_asg   = var.instance-type_asg
  launch-configname   = "stage-docker-lc"
  sg_name3            = [module.security_group.dockerSG]
  key_name            = module.keypair.key_name
  asg-group-name      = "docker-asg"
  vpc-zone-identifier = [module.vpc.subnet-id3, module.vpc.subnet-id4]
  target-group-arn    = module.docker_lb.tg_arn
  asg-policy          = "docker-asg-policy"
  target-instance     = module.docker.docker_id
  depends_on          = [time_sleep.wait_600_seconds]
  instance_name_asg   = local.instance_name_asg
}

resource "time_sleep" "wait_600_seconds" {
  depends_on = [module.docker]

  create_duration = "600s"
}

module "route53" {
  source      = "../modules/route53"
  domain_name = "www.elizabethfolzgroup.com"
  dns_name    = module.docker_lb.Load_Balancer_dns
  zone_id     = module.docker_lb.Load_Balancer_zone_id
}
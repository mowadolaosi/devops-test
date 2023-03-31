module "vpc" {
  source   = "../../modules/VPC"
  vpc_cidr = var.vpc_cidr

}

module "Subnet" {
  source             = "../../modules/subnets"
  SSKEU1pubsub1_cidr = var.SSKEU1pubsub1_cidr
  SSKEU1pubsub2_cidr = var.SSKEU1pubsub2_cidr
  SSKEU1prvsub1_cidr = var.SSKEU1prvsub1_cidr
  SSKEU1prvsub2_cidr = var.SSKEU1prvsub2_cidr
  all_ip             = var.all_ip
  vpc_id             = module.vpc.vpc_id
}

module "Security_groups" {
  source   = "../../modules/Security-groups"
  ssh_port = var.ssh_port
  jenkins_port = var.jenkins_port
  vpc_id   = module.vpc.vpc_id
  all_ip   = var.all_ip
  
}

module "keypair" {
  source = "../../modules/keypair"
}

module "ansible" {
  source           = "../../modules/ansible"
  keypair          = module.keypair.SSKEU1_pub_key
  ami              = var.ami
  instance_type    = var.instance_type
  ansible_sg       = module.Security_groups.ansible_sg
  SSKEU1pubsub1_id = module.Subnet.pubsub_1
  prv_key          = module.keypair.prv_key
  dockerblueIP = module.dockerhosts.dockerblue_private_ip
  dockergreenIP = module.dockerhosts.dockergreen_private_ip
  

}

module "bastion" {
  source           = "../../modules/bastion"
  keypair          = module.keypair.SSKEU1_pub_key
  prv_key          = module.keypair.prv_key
  ami              = var.ami
  instance_type    = var.instance_type
  bastion_sg       = module.Security_groups.bastion_sg
  SSKEU1pubsub1_id = module.Subnet.pubsub_1
}

module "jenkins" {
  source           = "../../modules/jenkins"
  keypair          = module.keypair.SSKEU1_pub_key
  prv_key          = module.keypair.prv_key
  ami              = var.amiredhart
  instance_type    = var.instance_type
  jenkins_sg       = module.Security_groups.jenkins_sg
  SSKEU1pubsub1_id = module.Subnet.pubsub_1
}



module "dockerhosts" {
  source            = "../../modules/dockerhosts"
  keypair           = module.keypair.SSKEU1_pub_key
  ami               = var.ami
  instance_type     = var.instance_type
  SSKEU1_docker_sg  = module.Security_groups.SSKEU1_docker_sg
  SSKEU1pubsub1_id = module.Subnet.pubsub_1
}



module "ASG" {
  source = "../../modules/ASG"
  keypair = module.keypair.SSKEU1_pub_key
   ami               = var.ami
  instance_type = var.instance_type
  SSKEU1_workers_sg = module.Security_groups.SSKEU1_docker_sg
  SSKEU1pubsub1_id = [module.Subnet.pubsub_1, module.Subnet.pubsub_2]
  SSKEU1-tgarn = module.lb.target_group_arn
}

module "lb" {
  source = "../../modules/application_lb"
  SSKEU1pubsub1_id = [module.Subnet.pubsub_1, module.Subnet.pubsub_2]
  vpc_id   = module.vpc.vpc_id
  SSKEU1_Master_sg = module.Security_groups.master_sg
  dockerblueid = module.dockerhosts.dockerblueid
  dockergreenid = module.dockerhosts.dockergreenid
  
}


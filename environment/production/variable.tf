# VPC CIDR 
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

#Public Subnet 1 CIDR
variable "SSKEU1pubsub1_cidr" {
  default = "10.0.1.0/24"
}

#Public Subnet 2 CIDR
variable "SSKEU1pubsub2_cidr" {
  default = "10.0.2.0/24"
}

#Private Subnet 1 CIDR
variable "SSKEU1prvsub1_cidr" {
  default = "10.0.3.0/24"
}

#Private Subnet 2 CIDR
variable "SSKEU1prvsub2_cidr" {
  default = "10.0.4.0/24"
}

#All IP CIDR
variable "all_ip" {
  default = "0.0.0.0/0"
}

#vpc id
variable "vpc_id" {
  default = ""
}

#ssh port
variable "ssh_port" {
  default = 22
}

#keypair variable
variable "keypair" {
  default = ""
}

#security group
variable "ansible_sg" {
  default = ""
}

#ami
variable "ami" {
  default = "ami-0fdf70ed5c34c5f52"
}

#ami
variable "amiredhart" {
  default = "ami-05c96317a6278cfaa"
}

#instance type
variable "instance_type" {
  default = "t2.medium"

}

#public subnet id
variable "SSKEU1pubsub1_id" {
  default = ""
}


variable "SSKEU1_prv_sn1_id" {
  default = ""
}

#security group
variable "jenkins_sg" {
  default = ""
}

#security group
variable "bastion_sg" {
  default = ""
}

#prv_key
variable "prv_key" {
  default = ""
}


#docker blue ip
variable "dockerblue_public_ip" {
  default = ""
}

#docker green ip
variable "dockergreen_public_ip" {
  default = ""
}

#workerip
variable "worker1IP" {
  default = ""
}

#workerip
variable "worker2IP" {
  default = ""
}

# Cluster.yml
variable "cluster_yml" {
  default = ""
}

# Deployment.yml
variable "deployment_yml" {
  default = ""

}

# Join.yml
variable "join_yml" {
  default = ""
}

#Installation.yml
variable "installation_yml" {
  default = ""
}

# Monitoring.yml
variable "monitoring_yml" {
  default = ""
}

#jenkins port
variable "jenkins_port" {
  default = 8080
}

#HAproxy_port
variable "HAproxy_port" {
  default = 6443
}

#HAproxy
variable "HAproxy_sg" {
  default = ""
}

#security group
variable "SSKEU1_Master_sg"{
  default = ""
    
}

#Target group id
variable "Master1id"{
  default = ""
    
}

#Target group id
variable "Master2id"{
  default = ""
    
}

#Target group id
variable "worker1id"{
  default = ""
    
}

#Target group id
variable "worker2id"{
  default = ""
    
}

#Target group arn
variable "SSKEU1-tgarn"{
  default = ""
  }

variable "HAproxy_IP" {
  default = ""
}
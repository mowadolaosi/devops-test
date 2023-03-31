output "ansible_IP" {
  value       = module.ansible.ansible_IP
  description = "Ansible public IP"
}

output "bastion_public_ip" {
  value       = module.bastion.bastion_public_ip
  description = "Bastion public IP"
}
output "worker1_public_ip" {
  value       = module.workers.worker1_public_ip
  description = "worker1 public IP"
}

output "worker2_public_ip" {
  value       = module.workers.worker2_public_ip
  description = "worker2 public IP"
}

output "Master1_public_ip" {
  value       = module.master.Master1_public_ip
  description = "master public IP"
}

output "Master2_public_ip" {
  value       = module.master.Master2_public_ip
  description = "master2 public IP"
}

output "jenkins_public_ip" {
  value       = module.jenkins.jenkins_IP
  description = "jenkins public IP"

}

output "HA_public_ip" {
  value       = module.HAProxy.HAproxy_IP
  description = "HAproxy public IP"

}

output "lb_dns" {
  value = module.lb.lb_dns
  
}

output "ansible_sg" {
  value = aws_security_group.SSKEU1_ansible_sg.id
}

output "SSKEU1_docker_sg" {
  value = aws_security_group.SSKEU1_docker_sg.id
}

output "pacadeu1_docker_prod_lb_sg" {
  value = aws_security_group.pacadeu1_docker_prod_lb_sg.id
}

output "bastion_sg" {
  value = aws_security_group.SSKEU1_bastion_sg.id
}

output "jenkins_sg" {
  value = aws_security_group.SSKEU1_jenkins_sg.id
}


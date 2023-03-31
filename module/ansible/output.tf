output "ansible_IP" {
  value       = aws_instance.SSKEU1_ansible.public_ip
  description = "Ansible public IP"
}
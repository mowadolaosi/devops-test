output "jenkins_IP" {
  value       = aws_instance.SSKEU1_jenkins.public_ip
  description = "jenkins public IP"
}
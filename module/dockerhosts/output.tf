#docker prod OUTPUT
output "dockerblue_private_ip" {
  value       = aws_instance.SSKEU1_dockerblue.private_ip
  description = "blue private IP"
}

#docker stage OUTPUT
output "dockergreen_private_ip" {
  value       = aws_instance.SSKEU1_dockergreen.private_ip
  description = "green public IP"
}

#dockerblue id OUTPUT
output "dockerblueid" {
  value       = aws_instance.SSKEU1_dockerblue.id
  description = "dockerblueid"
}

#dockergreen OUTPUT
output "dockergreenid" {
  value       = aws_instance.SSKEU1_dockergreen.id
  description = "dockergreenid"
}
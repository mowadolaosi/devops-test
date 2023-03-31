

output "lb_dns" {
  value = aws_lb.SSKEU1-lb.dns_name
  
}

output "target_group_arn" {
  value = aws_lb_target_group.SSKEU1-tg.arn
  
}

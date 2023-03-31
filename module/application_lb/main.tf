
# Provision an applicaction load balancer
resource "aws_lb" "SSKEU1-lb" {
  name                      = "SSKEU1-lb" 
  internal                  = false 
  load_balancer_type        = "application"
  security_groups           = [var.pacadeu1_docker_prod_lb_sg]
  subnets                   = var.SSKEU1pubsub1_id
  enable_deletion_protection = false  
  
}


# Add a load balancer listener HTTP
resource "aws_lb_listener" "SSKEU1-lb-listener" {
  load_balancer_arn           = aws_lb.SSKEU1-lb.arn
  port                        = "80"
  protocol                    = "HTTP"

  default_action {
    type               = "forward"
    target_group_arn          = aws_lb_target_group.SSKEU1-tg.arn
  } 
}

# Add a load balancer listener HTTPS
resource "aws_lb_listener" "SSKEU1-lb-listenerSSL" {
  load_balancer_arn           = aws_lb.SSKEU1-lb.arn
  port                        = "443"
  protocol                    = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${aws_acm_certificate.sskeu1cert.arn}"
  default_action {
    type               = "forward"
    target_group_arn          = aws_lb_target_group.SSKEU1-tg.arn
  } 
}

#certificate
resource "aws_acm_certificate" "sskeu1cert" {
  domain_name       = "mowadola.com"
  validation_method = "DNS"

  tags = {
    Environment = "sskeu1cert"
  }

  lifecycle {
    create_before_destroy = true
  }
}





# get details about a route 53 hosted zone
data "aws_route53_zone" "SSKEU1route53_zone" {
  name         = "mowadola.com"
  private_zone = false
}

# create a record set in route 53 for domain validatation
resource "aws_route53_record" "SSKEU1_record" {
  for_each = {
    for dvo in aws_acm_certificate.sskeu1cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.SSKEU1route53_zone.zone_id
}

# validate acm certificates
resource "aws_acm_certificate_validation" "acm_certificate_validation" {
  certificate_arn         = aws_acm_certificate.sskeu1cert.arn
  validation_record_fqdns = [for record in aws_route53_record.SSKEU1_record : record.fqdn]
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.SSKEU1route53_zone.zone_id
  name    = "mowadola.com"
  type    = "A"

  alias {
    name                   = aws_lb.SSKEU1-lb.dns_name
    zone_id                = aws_lb.SSKEU1-lb.zone_id
    evaluate_target_health = true
  }
}



# Add a target group for load balancer
resource "aws_lb_target_group" "SSKEU1-tg" {
  name                      = "SSKEU1-tg"
  port                      =  80
  protocol                  = "HTTP"
  vpc_id                    = var.vpc_id
  health_check {
    healthy_threshold       = 3
    unhealthy_threshold     = 5
    interval                = 30
    timeout                 = 5
  
  } 
  }

  # Add target group attachment for docker-stage
resource "aws_lb_target_group_attachment" "SSKEU1-tg-attach-dockerstage" {
  target_group_arn            = aws_lb_target_group.SSKEU1-tg.arn
  target_id                   = var.dockerstageid
  port                        = 80
  
}

# Add target group attachment for docker-prod
resource "aws_lb_target_group_attachment" "SSKEU1-tg-attach-dockerprod" {
  target_group_arn            = aws_lb_target_group.SSKEU1-tg.arn
  target_id                   = var.dockerprodid
  port                        = 80
  
}



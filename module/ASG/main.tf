#Add High Availability


#Create launch template
resource "aws_launch_template" "SSKEU1-lt" {
  name_prefix                 = "SSKEUEU1-lt"
  image_id                    = var.ami
  instance_type               = var.instance_type

  key_name                    = var.keypair

  monitoring {
    enabled = false
}

  network_interfaces{
  associate_public_ip_address = true
  security_groups             = [var.SSKEU1_docker_sg]
  }

}

# Create Autoscaling group
resource "aws_autoscaling_group" "SSKEU1-asg" {
  name                      = "SSKEU1-asg"
  
  max_size                  = 3
  min_size                  = 2
  health_check_grace_period = 300
  default_cooldown          = 60
  health_check_type         = "EC2"
  desired_capacity          = 2
  force_delete              = true
  vpc_zone_identifier       = var.SSKEU1pubsub1_id
  target_group_arns         = [var.SSKEU1-tgarn]
 
launch_template {
    id                      = aws_launch_template.SSKEU1-lt.id
    version                 = "$Latest"
}

tag {
    key                 = "Name"
    value               = "SSKEU1-asg"
    propagate_at_launch = true
  }
}

# create Autoscaling group policy
resource "aws_autoscaling_policy" "SSKEU1-asg-pol" {
  name                   = "SSKEU1-asg-pol"
  policy_type            = "TargetTrackingScaling"
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = aws_autoscaling_group.SSKEU1-asg.name
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 40
  }
} 

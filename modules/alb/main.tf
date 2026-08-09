resource "aws_lb" "app_load_balancer" {
  name               = var.lb_name
  load_balancer_type = "application"
  security_groups    =  var.security_group_ids
  subnets            = var.subnets_ids
  ip_address_type = "ipv4"
  tags = var.tags
}

resource "aws_lb_target_group" "tg_app_lb" {
  name     = var.tg_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id 
}

resource "aws_lb_target_group_attachment" "test" {
  for_each = toset(var.instances_id)

  target_group_arn = aws_lb_target_group.tg_app_lb.arn
  target_id        = each.value
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.app_load_balancer.arn
  port              = 80
  protocol          = "HTTP" 

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_app_lb.arn
  }
}

#resource "aws_lb_listener" "https" {
#  load_balancer_arn = aws_lb.this.arn
#  port              = 443
#  protocol          = "HTTPS"
#  ssl_policy        = "ELBSecurityPolicy-2016-08"
#  certificate_arn   = var.certificate_arn
#  default_action {
#    type             = "forward"
#    target_group_arn = aws_lb_target_group.app.arn
#  }
#}


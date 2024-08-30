resource "aws_lb_target_group" "target-to-app1" {
  name        = local.Environment.target_group_1_name
  port        = local.Environment.app1.host_port
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id
  target_type = "ip"
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    port                = local.Environment.app1.host_port
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 10
    interval            = 30
  }
}

resource "aws_lb_target_group" "target-to-app2" {
  name        = local.Environment.target_group_2_name
  port        = local.Environment.app2.host_port
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id
  target_type = "instance"
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    port                = local.Environment.app2.host_port
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 10
    interval            = 30
  }
}

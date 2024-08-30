resource "aws_lb_listener" "redirect_to_https" {
  load_balancer_arn = aws_lb.my_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "forward_to_target_group" {
  load_balancer_arn = aws_lb.my_lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.wildcard-test-dhawal-in-net.arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>This is Test Domain, You are not supposed to visit here.</h1>"
      status_code  = "200"
    }
  }
}

resource "aws_lb_listener_rule" "apache-rule" {
  listener_arn = aws_lb_listener.forward_to_target_group.arn
  priority     = 2
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-to-app1.arn
  }
  condition {
    host_header {
      values = [local.Environment.my_domains[0]]
    }
  }
  depends_on = [aws_lb_listener.forward_to_target_group, aws_lb_target_group.target-to-app1]
}

resource "aws_lb_listener_rule" "nginx-rule" {
  listener_arn = aws_lb_listener.forward_to_target_group.arn
  priority     = 1
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-to-app2.arn
  }
  condition {
    host_header {
      values = [local.Environment.my_domains[1]]
    }
  }
  depends_on = [aws_lb_listener.forward_to_target_group, aws_lb_target_group.target-to-app2]
}
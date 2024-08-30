
resource "aws_ecs_service" "service-apache" {
  name                   = "app1-service"
  cluster                = aws_ecs_cluster.my_ecs_cluster.id
  task_definition        = aws_ecs_task_definition.app1.arn
  desired_count          = 1
  launch_type            = "FARGATE"
  enable_execute_command = true

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = module.vpc.private_subnets
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.target-to-app1.arn
    container_name   = local.Environment.app1.name
    container_port   = local.Environment.app1.container_port
  }
}



# resource "aws_ecs_service" "service-nginx" {
#   name     = "app2-service"
#   cluster  = aws_ecs_cluster.my_ecs_cluster.id
#   iam_role = aws_iam_role.ecs_service_role.arn

#   task_definition        = aws_ecs_task_definition.app2.arn
#   desired_count          = 1
#   launch_type            = "EC2"
#   enable_execute_command = true

#   load_balancer {
#     target_group_arn = aws_lb_target_group.target-to-app2.arn
#     container_name   = local.Environment.app2.name
#     container_port   = local.Environment.app2.container_port
#   }
# }


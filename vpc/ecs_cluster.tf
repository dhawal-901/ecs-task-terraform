# resource "aws_key_pair" "key" {
#   key_name   = "${var.key_name}"
#   public_key = "${file("${var.ssh_key_file_ecs}")}"
# }


resource "aws_ecs_cluster" "my_ecs_cluster" {
  name = local.Environment.ecs_name
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

# resource "aws_launch_template" "ec2-launch-configuration" {
#   name_prefix            = "ecs-launch-configuration"
#   image_id               = local.Environment.launch_configuration.ami
#   instance_type          = local.Environment.launch_configuration.instance_type
#   vpc_security_group_ids = [aws_security_group.ecs_tasks.id]
#   key_name               = "my_private_instance_key"
#   monitoring { enabled = true }
#   iam_instance_profile { arn = aws_iam_instance_profile.ec2_instance_role_profile.name }

#   lifecycle {
#     create_before_destroy = true
#   }
#   user_data = base64encode(<<-EOF
#       #!/bin/bash
#       echo ECS_CLUSTER=${aws_ecs_cluster.my_ecs_cluster.name} >> /etc/ecs/ecs.config;
#     EOF
#   )
# }


# resource "aws_autoscaling_group" "ecs" {
#   name_prefix               = "test-ecs-asg-"
#   vpc_zone_identifier       = aws_subnet.public[*].id
#   min_size                  = 2
#   max_size                  = 8
#   health_check_grace_period = 0
#   health_check_type         = "EC2"
#   protect_from_scale_in     = false

#   launch_template {
#     id      = aws_launch_template.ecs_ec2.id
#     version = "$Latest"
#   }

#   tag {
#     key                 = "Name"
#     value               = "demo-ecs-cluster"
#     propagate_at_launch = true
#   }

#   tag {
#     key                 = "AmazonECSManaged"
#     value               = ""
#     propagate_at_launch = true
#   }
# }




resource "aws_launch_configuration" "ec2-launch-configuration" {
  name_prefix                 = "ecs-launch-configuration"
  image_id                    = local.Environment.launch_configuration.ami
  instance_type               = local.Environment.launch_configuration.instance_type
  security_groups             = [aws_security_group.ecs_tasks.id]
  associate_public_ip_address = false
  key_name                    = "my_private_instance_key"

  iam_instance_profile = aws_iam_instance_profile.ec2_instance_role_profile.name

  lifecycle {
    create_before_destroy = true
  }

  user_data = <<-EOF
              #!/bin/bash
              echo ECS_CLUSTER=${aws_ecs_cluster.my_ecs_cluster.name} >> /etc/ecs/ecs.config
              EOF
}

resource "aws_autoscaling_group" "ecs" {
  launch_configuration = aws_launch_configuration.ec2-launch-configuration.id
  min_size             = 1
  max_size             = 1
  desired_capacity     = 1
  vpc_zone_identifier  = module.vpc.public_subnets

  tag {
    key                 = "Name"
    value               = "ecs-instance"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.ecs.name
}























# resource "aws_ecs_task_definition" "hello_world" {
#   family                   = "hello-world-app"
#   network_mode             = "awsvpc"
#   requires_compatibilities = ["FARGATE"]
#   cpu                      = 1024
#   memory                   = 2048

#   container_definitions = <<DEFINITION
# [
#   {
#     "image": "registry.gitlab.com/architect-io/artifacts/nodejs-hello-world:latest",
#     "cpu": 512,
#     "memory": ,
#     "name": "hello-world-app",
#     "networkMode": "awsvpc",
#     "portMappings": [
#       {
#         "containerPort": 3000,
#         "hostPort": 3000
#       }
#     ]
#   }
# ]
# DEFINITION
# }
# resource "aws_ecs_task_definition" "hello_world2" {
#   family                   = "hello-world-app"
#   network_mode             = "awsvpc"
#   requires_compatibilities = ["EC2"]
#   cpu                      = 1024
#   memory                   = 2048

#   container_definitions = <<DEFINITION
# [
#   {
#     "image": "registry.gitlab.com/architect-io/artifacts/nodejs-hello-world:latest",
#     "cpu": 512,
#     "memory": ,
#     "name": "hello-world-app",
#     "networkMode": "awsvpc",
#     "portMappings": [
#       {
#         "containerPort": 3000,
#         "hostPort": 3000
#       }
#     ]
#   }
# ]
# DEFINITION
# }

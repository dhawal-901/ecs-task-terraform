# data "aws_iam_role" "ecs_task_execution_role" {
#   name = "ecsTaskExecutionRole"
# }


# resource "aws_iam_role" "ecs_instance_role" {
#   name = "ecsInstanceRole"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole",
#         Effect = "Allow",
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy" "ecs_instance_policy" { 
#   name = "ecs_instance_role_policy"
#   role = "${aws_iam_role.ecs_instance_role.id}"
#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Action": [
#       "ec2:AuthorizeSecurityGroupIngress",
#       "ec2:Describe*",
#       "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
#       "elasticloadbalancing:DeregisterTargets",
#       "elasticloadbalancing:Describe*",
#       "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
#       "elasticloadbalancing:RegisterTargets",
#       "ec2:DescribeTags",
#       "logs:CreateLogGroup",
#       "logs:CreateLogStream",
#       "logs:DescribeLogStreams",
#       "logs:PutSubscriptionFilter",
#       "logs:PutLogEvents"
#       ],
#       "Resource": "*"
#     }
#   ]
# }
# EOF
# }

# resource "aws_iam_role_policy_attachment" "ecs_instance_policy" {
#   role       = aws_iam_role.ecs_instance_role.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
# }

# resource "aws_iam_instance_profile" "ecs_instance_profile" {
#   name = "ecsInstanceProfile"
#   role = aws_iam_role.ecs_instance_role.name
# }



data "aws_iam_policy_document" "ec2_instance_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = [
        "ec2.amazonaws.com",
        "ecs.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role" "ec2_instance_role" {
  name               = "ec2InstanceRole"
  assume_role_policy = data.aws_iam_policy_document.ec2_instance_role_policy.json
}

resource "aws_iam_role_policy_attachment" "ec2_instance_role_policy" {
  role       = aws_iam_role.ec2_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ec2_instance_role_profile" {
  name = "ec2InstanceRoleProfile"
  role = aws_iam_role.ec2_instance_role.id
}




resource "aws_iam_role" "ecs_service_role" {
  name               = "ecsServiceRole"
  assume_role_policy = data.aws_iam_policy_document.ecs_service_policy.json
}

data "aws_iam_policy_document" "ecs_service_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com",]
    }
  }
}

resource "aws_iam_role_policy" "ecs_service_role_policy" {
  name   = "ecsServiceRolePolicy"
  policy = data.aws_iam_policy_document.ecs_service_role_policy.json
  role   = aws_iam_role.ecs_service_role.id
}

data "aws_iam_policy_document" "ecs_service_role_policy" {
  statement {
    effect  = "Allow"
    actions = [
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:Describe*",
      "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
      "elasticloadbalancing:DeregisterTargets",
      "elasticloadbalancing:Describe*",
      "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
      "elasticloadbalancing:RegisterTargets",
      "ec2:DescribeTags",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogStreams",
      "logs:PutSubscriptionFilter",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
}


# resource "aws_iam_role" "ecs_task_execution_role" {
#   name               = "ecsTaskExecutionRole"
#   assume_role_policy = data.aws_iam_policy_document.task_assume_role_policy.json
# }

data "aws_iam_policy_document" "task_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
#   role       = aws_iam_role.ecs_task_execution_role.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
# }

data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
}

resource "aws_iam_role" "ecs_task_iam_role" {
  name               = "ecsTaskIAMRole"
  assume_role_policy = data.aws_iam_policy_document.task_assume_role_policy.json
}




# # data "aws_iam_policy_document" "ecs_agent" {
# #   statement {
# #     actions = ["sts:AssumeRole"]

# #     principals {
# #       type        = "Service"
# #       identifiers = ["ec2.amazonaws.com"]
# #     }
# #   }
# # }

# # resource "aws_iam_role" "ecs_agent" {
# #   name               = "ecs-agent"
# #   assume_role_policy = data.aws_iam_policy_document.ecs_agent.json
# # }

# # resource "aws_iam_role_policy_attachment" "Cloudwatch_FullAccess" {
# #   role       = aws_iam_role.ecs_agent.name
# #   policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
# # }

# # resource "aws_iam_role_policy_attachment" "ecs_agent" {
# #   role       = aws_iam_role.ecs_agent.name
# #   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
# #   depends_on = ["aws_iam_role.ecs_agent"]
# # }

# # resource "aws_iam_instance_profile" "ecs_agent" {
# #   name = "ecs-agent"
# #   role = aws_iam_role.ecs_agent.name

# # }



# resource "aws_iam_role" "ec2_instance_role" {
#   name               = "${var.namespace}_EC2_InstanceRole_${var.environment}"
#   assume_role_policy = data.aws_iam_policy_document.ec2_instance_role_policy.json

#   tags = {
#     Scenario = var.scenario
#   }
# }

# resource "aws_iam_role_policy_attachment" "ec2_instance_role_policy" {
#   role       = aws_iam_role.ec2_instance_role.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
# }

# resource "aws_iam_instance_profile" "ec2_instance_role_profile" {
#   name = "${var.namespace}_EC2_InstanceRoleProfile_${var.environment}"
#   role = aws_iam_role.ec2_instance_role.id

#   tags = {
#     Scenario = var.scenario
#   }
# }

# data "aws_iam_policy_document" "ec2_instance_role_policy" {
#   statement {
#     actions = ["sts:AssumeRole"]
#     effect  = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = [
#         "ec2.amazonaws.com",
#         "ecs.amazonaws.com"
#       ]
#     }
#   }
# }

# ########################################################################################################################
# ## Create service-linked role used by the ECS Service to manage the ECS Cluster
# ########################################################################################################################

# resource "aws_iam_role" "ecs_service_role" {
#   name               = "${var.namespace}_ECS_ServiceRole_${var.environment}"
#   assume_role_policy = data.aws_iam_policy_document.ecs_service_policy.json

#   tags = {
#     Scenario = var.scenario
#   }
# }

# data "aws_iam_policy_document" "ecs_service_policy" {
#   statement {
#     actions = ["sts:AssumeRole"]
#     effect  = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["ecs.amazonaws.com",]
#     }
#   }
# }

# resource "aws_iam_role_policy" "ecs_service_role_policy" {
#   name   = "${var.namespace}_ECS_ServiceRolePolicy_${var.environment}"
#   policy = data.aws_iam_policy_document.ecs_service_role_policy.json
#   role   = aws_iam_role.ecs_service_role.id
# }

# data "aws_iam_policy_document" "ecs_service_role_policy" {
#   statement {
#     effect  = "Allow"
#     actions = [
#       "ec2:AuthorizeSecurityGroupIngress",
#       "ec2:Describe*",
#       "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
#       "elasticloadbalancing:DeregisterTargets",
#       "elasticloadbalancing:Describe*",
#       "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
#       "elasticloadbalancing:RegisterTargets",
#       "ec2:DescribeTags",
#       "logs:CreateLogGroup",
#       "logs:CreateLogStream",
#       "logs:DescribeLogStreams",
#       "logs:PutSubscriptionFilter",
#       "logs:PutLogEvents"
#     ]
#     resources = ["*"]
#   }
# }

# ########################################################################################################################
# ## IAM Role for ECS Task execution
# ########################################################################################################################

# resource "aws_iam_role" "ecs_task_execution_role" {
#   name               = "${var.namespace}_ECS_TaskExecutionRole_${var.environment}"
#   assume_role_policy = data.aws_iam_policy_document.task_assume_role_policy.json

#   tags = {
#     Scenario = var.scenario
#   }
# }

# data "aws_iam_policy_document" "task_assume_role_policy" {
#   statement {
#     actions = ["sts:AssumeRole"]

#     principals {
#       type        = "Service"
#       identifiers = ["ecs-tasks.amazonaws.com"]
#     }
#   }
# }

# resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
#   role       = aws_iam_role.ecs_task_execution_role.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
# }

# ########################################################################################################################
# ## IAM Role for ECS Task
# ########################################################################################################################

# resource "aws_iam_role" "ecs_task_iam_role" {
#   name               = "${var.namespace}_ECS_TaskIAMRole_${var.environment}"
#   assume_role_policy = data.aws_iam_policy_document.task_assume_role_policy.json

#   tags = {
#     Scenario = var.scenario
#   }
# }
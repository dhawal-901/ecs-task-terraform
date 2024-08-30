
data "template_file" "app-1-template" {
  template = file("./templates/ecs.json.tpl")

  vars = {
    name           = local.Environment.app1.name
    app_image      = local.Environment.app1.image
    host_port      = local.Environment.app1.host_port
    network_mode   = local.Environment.app1.network_mode
    container_port = local.Environment.app1.container_port
    cpu            = local.Environment.app1.cpu
    memory         = local.Environment.app1.memory
    aws_region     = local.Environment.app1.region
  }
}

resource "aws_ecs_task_definition" "app1" {
  family                   = "app1-task"
  execution_role_arn       = data.aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_iam_role.arn
  network_mode             = local.Environment.app1.network_mode
  requires_compatibilities = ["FARGATE"]
  cpu                      = local.Environment.app1.cpu
  memory                   = local.Environment.app1.memory
  container_definitions    = data.template_file.app-1-template.rendered
}

# data "template_file" "app-2-template" {
#   template = file("./templates/ecs.json.tpl")

#   vars = {
#     name           = local.Environment.app2.name
#     app_image      = local.Environment.app2.image
#     network_mode   = local.Environment.app2.network_mode
#     host_port      = local.Environment.app2.host_port
#     container_port = local.Environment.app2.container_port
#     cpu            = local.Environment.app2.cpu
#     memory         = local.Environment.app2.memory
#     aws_region     = local.Environment.app2.region
#   }
# }

# resource "aws_ecs_task_definition" "app2" {
#   family                   = "app2-task"
#   execution_role_arn       = data.aws_iam_role.ecs_task_execution_role.arn
#   task_role_arn            = aws_iam_role.ecs_task_iam_role.arn
#   network_mode             = local.Environment.app2.network_mode
#   requires_compatibilities = ["EC2"]
#   cpu                      = 2 * local.Environment.app2.cpu
#   memory                   = 2 * local.Environment.app2.memory
#   container_definitions    = data.template_file.app-2-template.rendered
# }




# data "template_file" "app-1-template" {
#   template = file("./templates/ecs.json.tpl")

#   vars = {
#     name           = local.Environment.app1.name
#     app_image      = local.Environment.app1.image
#     host_port      = local.Environment.app1.host_port
#     container_port = local.Environment.app1.container_port
#     cpu            = local.Environment.app1.cpu
#     memory         = local.Environment.app1.memory
#     aws_region     = local.Environment.app1.region
#   }
# }

# resource "aws_ecs_task_definition" "app1" {
#   family                   = "app1-task"
#   execution_role_arn       = data.aws_iam_role.ecs_task_execution_role.arn
#   task_role_arn            = data.aws_iam_role.ecs_task_execution_role.arn
#   network_mode             = "awsvpc"
#   requires_compatibilities = ["FARGATE"]
#   cpu                      = local.Environment.app1.cpu
#   memory                   = local.Environment.app1.memory
#   container_definitions    = data.template_file.app-1-template.rendered
# }

# data "template_file" "app-2-template" {
#   template = file("./templates/ecs.json.tpl")

#   vars = {
#     name           = local.Environment.app2.name
#     app_image      = local.Environment.app2.image
#     host_port      = local.Environment.app2.host_port
#     container_port = local.Environment.app2.container_port
#     cpu            = local.Environment.app2.cpu
#     memory         = local.Environment.app2.memory
#     aws_region     = local.Environment.app2.region
#   }
# }

# resource "aws_ecs_task_definition" "app2" {
#   family                   = "app2-task"
#   execution_role_arn       = data.aws_iam_role.ecs_task_execution_role.arn
#   task_role_arn            = data.aws_iam_role.ecs_task_execution_role.arn
#   network_mode             = "bridge"
#   requires_compatibilities = ["EC2"]
#   cpu                      = local.Environment.app2.cpu
#   memory                   = local.Environment.app2.memory
#   container_definitions    = data.template_file.app-2-template.rendered
# }
locals {
  config = {
    test = {
      vpc_name        = "tf_vpc_28aug"
      vpc_cidr        = "10.3.0.0/16"
      public_subnets  = ["10.3.1.0/24", "10.3.2.0/24"]
      private_subnets = ["10.3.3.0/24"]
      azs             = ["ap-south-1a", "ap-south-1b"]

      lb_sg_name       = "alb_sq_28aug"
      instance_sg_name = "ecs_tasks_sq_28aug"
      lb_name          = "tf-lb-28aug"

      # app_ports = [3000, 3001]

      ecs_name = "tf_ecs_28aug"
      launch_configuration = {
        ami           = "ami-018bf378c35021448"
        instance_type = "t2.medium"
      }


      app1 = {
        name           = "app1"
        image          = "nginx:latest"
        network_mode   = "awsvpc"
        host_port      = "80"
        container_port = "80"
        cpu            = 512
        memory         = 1024
        region         = "ap-south-1"
      }
      app2 = {
        name           = "app2"
        image          = "apache:latest"
        network_mode   = "bridge"
        host_port      = "3000"
        container_port = "80"
        cpu            = 512
        memory         = 512
        region         = "ap-south-1"
      }


      target_group_1_name = "ecs-httpd-target-28aug"
      target_group_2_name = "ecs-nginx-target-28aug"

      ubuntu_ami           = "ami-0ad21ae1d0696ad58"
      ubuntu_instance_type = "t2.micro"

      hosted_zone      = "dhawal.in.net"
      domain_name_1    = "apache.test"
      domain_name_2    = "nginx.test"
      cert_domain_name = "*.test.dhawal.in.net"
      my_domains       = ["apache.test.dhawal.in.net", "nginx.test.dhawal.in.net"]

      # db_name              = "postgres2"
      # db_identifier        = "postgres2"
      # db_username          = "root"
      # db_password          = "root1234"
      # db_allocated_storage = 10
      # db_engine            = "postgres"
      # db_engine_version    = "16.3"
      # db_instance_class    = "db.t3.micro"
      # db_storage_type      = "gp2"
    }
  }

  Environment = local.config.test
}

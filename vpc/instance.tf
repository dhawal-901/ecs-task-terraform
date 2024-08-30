

resource "aws_instance" "my_public_instance" {
  ami                         = local.Environment.ubuntu_ami
  instance_type               = local.Environment.ubuntu_instance_type
  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = [aws_security_group.ecs_tasks.id]
  key_name                    = "my_public_instance_key"
  associate_public_ip_address = true

  tags = {
    Name = "PUBLIC_INSTANCE_TF_${terraform.workspace}"
  }
  depends_on = [module.vpc]
}

# resource "aws_instance" "my_private_instance" {
#   count                  = 3
#   ami                    = local.Environment.ubuntu_ami
#   instance_type          = local.Environment.ubuntu_instance_type
#   subnet_id              = module.vpc.private_subnets[(count.index) % 2]
#   vpc_security_group_ids = [aws_security_group.my_public_sg.id, aws_security_group.my_public_sg_2.id]
#   key_name               = aws_key_pair.my_key.key_name
#   tags = {
#     Name = "PRIVATE_INSTANCE_TF_${count.index + 1}_${terraform.workspace}"
#   }
#   depends_on = [module.vpc, aws_key_pair.my_key]
# }
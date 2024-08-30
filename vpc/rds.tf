# resource "aws_db_subnet_group" "my_db_subnet_group" {
#   name       = "my_db_subnet_group"
#   subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]

#   tags = {
#     Name = "DB_SUBNET_GROUP_${terraform.workspace}"
#   }
# }

# resource "aws_db_instance" "default" {
#   allocated_storage      = local.Environment.db_allocated_storage
#   db_name                = local.Environment.db_name
#   engine                 = local.Environment.db_engine
#   engine_version         = local.Environment.db_engine_version
#   instance_class         = local.Environment.db_instance_class
#   username               = local.Environment.db_username
#   password               = local.Environment.db_password
#   db_subnet_group_name   = aws_db_subnet_group.my_db_subnet_group.name
#   vpc_security_group_ids = [aws_security_group.my_rds_sg.id]
#   identifier             = local.Environment.db_identifier
#   storage_type           = local.Environment.db_storage_type
#   skip_final_snapshot    = true
#   publicly_accessible    = false
# }
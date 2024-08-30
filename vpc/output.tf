# output "public_ip" {
#   description = "Public Instance IP"
#   value       = aws_instance.my_public_instance.public_ip
# }
# output "private_ips" {
#   description = "Private Instance IPs"
#   value       = [for ip in aws_instance.my_private_instance : ip.private_ip]
# }





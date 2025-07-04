output "rds_endpoint" {
  description = "The endpoint of tyhe RDS MySQL Instance"
  value       = aws_db_instance.mysql_database.endpoint
}

resource "aws_db_subnet_group" "my_db_subnet_group" {
  subnet_ids = aws_subnet.private_subnets[*].id
  name       = "my_db_subnet_group"
}

resource "aws_kms_key" "example" {
  description = "Example KMS Key"
}

output "ec2_public_ip" {
  description = "The public IP addreess of teh EC2 Instance"
  value       = aws_instance.public_ec2.public_ip
}

output "ec2_endpoint" {
  description = "DNS name of the EC2 Instance"
  value       = aws_instance.public_ec2.public_dns
}

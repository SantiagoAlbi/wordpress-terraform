resource "aws_db_instance" "mysql_database" {
  allocated_storage             = 20
  engine                        = "mysql"
  engine_version                = "8.0"
  instance_class                = "db.t3.micro"
  username                      = "admin"
  manage_master_user_password   = true
  master_user_secret_kms_key_id = aws_kms_key.example.id
  db_subnet_group_name          = aws_db_subnet_group.my_db_subnet_group.name
  vpc_security_group_ids        = [aws_security_group.private_rds_sg.id]
  db_name                       = "wordpress"
  identifier                    = "wordpress-ow"
  skip_final_snapshot           = true #en produccion necesario.
  storage_encrypted             = true
  multi_az                      = true #por dev se pued prencindir

  tags = {
    "Name" = "MySQL RDS Instance"
  }
}

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

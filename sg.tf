resource "aws_security_group" "public_whitelisted" {
  name        = "public-whitelisted-ips"
  description = "Allows access via vpn"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "VPN IP"
    from_port   = 22 #probar 443 y otros
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.white_listed_ips
  }

  ingress {
    description = "VPN IP"
    from_port   = 80 #probar 443 y otros
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.white_listed_ips
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "outgoing traffic"
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
}

resource "aws_security_group" "private_rds_sg" { #ver si no cambiar nombre a private
  name        = "private-rds"
  description = "Allows EC2 Instance in public subnet to connect to RDS"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Alows MySQL access from RDS"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.public_whitelisted.id] #ver esto si no cambiar con -rds
  }
}

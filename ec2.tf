resource "aws_instance" "public_ec2" {
  ami                         = "ami-05ffe3c48a9991133" #buscar linux o ubuntu
  instance_type               = "t2.micro"
  subnet_id                   = element(aws_subnet.public_subnets[*].id, 0)
  key_name                    = "ow-test"
  vpc_security_group_ids      = [aws_security_group.public_whitelisted.id]
  associate_public_ip_address = true
  user_data                   = file("user_data.sh")
  tags = {
    Name = "Public EC2 Instance"
  }
}

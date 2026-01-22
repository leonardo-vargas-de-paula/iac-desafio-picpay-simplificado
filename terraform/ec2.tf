resource "aws_instance" "back_picpay" {
  ami                    = "ami-0b6c6ebed2801a5cb" # Ubuntu Server 24.04 LTS (HVM), SSD Volume Type
  instance_type          = "t3.micro"
  key_name               = "server-prod-back-picpay"
  vpc_security_group_ids = [aws_security_group.back_picpay_sg.id]
  iam_instance_profile   = "ECR-EC2"


  tags = {
    Name        = "back_picpay"
    Provisioned = "Terraform"
  }
}

resource "aws_security_group" "back_picpay_sg" {
  name        = "back_picpay_sg"
  description = "Security group para o server"
  vpc_id      = "vpc-0be04a32025621b61"

  tags = {
    Name        = "back_picpay_sg"
    Provisioned = "Terraform"
  }
}



resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.back_picpay_sg.id
  cidr_ipv4         = "${var.ip_ssh}/32"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.back_picpay_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.back_picpay_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.back_picpay_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
}
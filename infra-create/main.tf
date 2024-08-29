resource "aws_instance" "tool" {
  ami                     = data.aws_ami.rhel9.image_id
  instance_type           = var.instance_type
  vpc_security_group_ids  = aws_security_group.infra-sg.id
}
resource "aws_route53_record" "public_record" {
  zone_id = var.hosted_zone_id
  name    = var.name
  type    = "A"
  ttl     = 300
  records = [aws_instance.tool.public_ip]
}
resource "aws_route53_record" "private_record" {
  zone_id = var.hosted_zone_id
  name    = var.name
  type    = "A"
  ttl     = 10
  records = [aws_instance.tool.private_ip]
}
resource "aws_security_group" "infra-sg" {
  name        = "${var.name}-sg"
  description = "${var.name}-sg"

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  dynamic "ingress" {
    for_each = var.ports
    content {
      description = ingress.key
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  tags = {
    Name = "${var.name}-sg"
  }
}
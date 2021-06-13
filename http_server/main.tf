variable "instance_type" {}

resource "aws_instance" "default" {
  ami = "ami-0a4fb3ab11fbc4969"
  vpc_security_group_ids = [aws_security_group.tf_sg_sample1.id]
  instance_type = var.instance_type

  user_data = <<EOF
    #!/bin/bash
    yum install -y httpd
    systemctl start httpd.service
EOF
}

resource "aws_security_group" "tf_sg_sample1" {
  name = "tf_sg_sample1"

  ingress {
    description = "my ingress"
    cidr_blocks = [ "0.0.0.0/0" ]
    protocol = "tcp"
    from_port = 80
    to_port = 80
  }

  egress {
    description = "my egress"
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }
}

output "public_dns" {
  value = aws_instance.default.public_dns
}
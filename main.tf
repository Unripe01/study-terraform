resource "aws_instance" "tf-ec2-sample1" {
 ami = "ami-0a4fb3ab11fbc4969"
 instance_type = "t2.micro"
 vpc_security_group_ids = [aws_security_group.tf_sg_sample1.id]

 user_data = file("./user_dat.sh")

 tags = {
  Name = "tf-ec2-sample1"
 }
}

resource "aws_security_group" "tf_sg_sample1" {
  name = "tf-sg-sample1"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "example_instance_id" {
  value = aws_instance.tf-ec2-sample1.public_dns
}

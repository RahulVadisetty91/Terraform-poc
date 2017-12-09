provider "aws" {
    region = "${var.aws_region}"
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
}



resource "aws_instance" "example" {
  ami           = "ami-cfdafaaa"
  instance_type = "t2.micro"
  key_name = "Rahul-Terraform"
  subnet_id = "${var.subnet_id}"
  ebs_block_device {
    device_name           = "/dev/sda1"
    volume_type           = "gp2"
    volume_size           = 10
    delete_on_termination = true
  }
  tags {
    Name = "Development"
    Owner = "Rahul"
    Environment = "SandBox"
    Project = "demo"
  }
vpc_security_group_ids = ["${aws_security_group.web.id}"]
}

resource "aws_security_group" "web" {
        name = "Default-VPC-SG"
                description = "Allow incoming HTTP connections."
                ingress {
                from_port = 22
                        to_port = 80
                        protocol = "tcp"
                        cidr_blocks = ["68.134.122.117/32"]
        }
        ingress {
                from_port = 22
                        to_port = 22
                        protocol = "tcp"
                        cidr_blocks = ["38.127.201.3/32"]
        }

        egress {
                from_port = 0
                        to_port = 0
                        protocol = "-1"
                        cidr_blocks = ["0.0.0.0/0"]
        }
  vpc_id = "${var.vpc_id}"
}

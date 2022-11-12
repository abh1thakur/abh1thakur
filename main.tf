terraform {
  backend "s3" {
    bucket = "terraform-state-abh1"
    key    = "provisioners"
    region = "us-east-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.31.0"
    }
  }
}
locals {
  instance_name = "terraform"
}
provider "aws" {
  region  = "us-east-1"
  profile = "default"

}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("${var.pub_key}")
}

# data "aws_vpc" "main" {
#   id = "vpc-06859e9faf2f10c8b"
# }

data "aws_subnet" "public_subnet" {
  vpc_id = var.vpc
  tags = {
    "Purpose" = "public"
  }
}

resource "aws_instance" "webapp" {
  ami                         = "ami-09d3b3274b6c5d4aa"
  instance_type               = var.instance_type
  subnet_id                   = data.aws_subnet.public_subnet.id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.webapp.id]
  user_data = file("./init.sh")

  #  
  # provisioner "local-exec" {
  #   command = "echo ${self.private_ip} >> private_ip.txt"
  # }
  # provisioner "remote-exec" {
  #   script = file("init.sh")
  # }
  # connection {
  #   host = self.public_ip
  #   type = "ssh"
  #   user = "centos"
  #   private_key = file("C:/Users/abhishek.g.thakur/.ssh/id_rsa")
  # }
  # tags = {
  #   "Name" = "webapp-${local.instance_name}"
  # }
  
}

# resource "null_resource" "status_check" {
#   provisioner "local-exec" {
#     command = "aws ec2 wait instance-status-ok --instance-ids ${aws_instance.webapp.id}"    
#   }
#   depends_on = [
#     aws_instance.webapp
#   ]
  
# }

resource "aws_security_group" "webapp" {
  name = "webapp_sg"
  vpc_id = var.vpc
  ingress = [{
    cidr_blocks = ["${var.myip}/32"]
    description = "value"
    from_port   = 80
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol = "tcp"
    security_groups = []
    self    = false
    to_port = 80
    },
    {
      cidr_blocks = ["${var.myip}/32"]
      description = "webapp inbound rules"
      from_port   = 22
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      protocol = "tcp"
      security_groups = []
      self    = false
      to_port = 22
    }
  ]
  egress = [{
    cidr_blocks = ["0.0.0.0/0"]
    description = "webapp outbound rules"
    from_port   = 0
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol = -1
    self     = false
    to_port  = 0
    security_groups = []
  }]
}
# data "template_file" "user_data" {
#   template = file("./userdata.yaml")
# }

# resource "aws_subnet" "web_subnet" {
#   vpc_id            = module.vpc.vpc_id

# }
output "public_ip" {
  value = aws_instance.webapp.public_ip
}
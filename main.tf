
locals {
  instance_name = "terraform"
}
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("${var.pub_key}")
}

data "aws_ami" "ami-id" {
    name_regex = "amzn2-ami-kernel-5.10-hvm-2.0.20221103.3-x86_64-gp2"
    owners = [ "amazon" ]
}
resource "aws_instance" "webapp" {
  ami                         = data.aws_ami.ami-id.id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  key_name                    = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.webapp.id]
  user_data = file("./init.sh")
  tags = {
    "Name" = "webapp-${local.instance_name}"
  }
}

resource "aws_security_group" "webapp" {
  name = "webapp_sg"
  vpc_id = var.vpc
  ingress = [
    {
      cidr_blocks = ["${var.myip}/32"]
      description = "Allow app port"
      from_port   = 3000
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      protocol = "tcp"
      security_groups = []
      self    = false
      to_port = 3000
    },
    {
      cidr_blocks = ["${var.myip}/32"]
      description = "SSH port allow"
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
    description = "Allow all outbound traffic"
    from_port   = 0
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol = -1
    self     = false
    to_port  = 0
    security_groups = []
  }]
}
output "public_ip" {
  value = aws_instance.webapp.public_ip
}
variable "instance_type" {
  type = string
  default = "t2.micro"
}
variable "region" {
  type = string
  default = "us-east-1"
}
variable "profile" {
  type = string
  default = "default"
}
variable "myip" {
  type = string
}
variable "vpc" {
  type = string
}
variable "pub_key" {
  type = string
}
variable "instance_type" {
  type = string
  default = "t2.micro"
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
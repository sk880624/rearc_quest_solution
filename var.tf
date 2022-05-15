=~=~=~=~=~=~=~=~=~=~=~= PuTTY log 2022.05.15 21:28:53 =~=~=~=~=~=~=~=~=~=~=~=
cat var.tf
variable "region" {

}

variable "vpc_cidr" {

}


variable "public_subnet_cidr" {
  type = "list"
}

variable "instance_count" {
  default = "2"
}


variable "availability_zone" {
  type = "list"
}
[root@ip-172-31-15-18 terraform_rearc_project]# 
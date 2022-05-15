=~=~=~=~=~=~=~=~=~=~=~= PuTTY log 2022.05.15 21:29:21 =~=~=~=~=~=~=~=~=~=~=~=
cat vpc.tf
resource "aws_vpc" "mainVpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"
  tags = {
    Name = "mainVPC"
  }
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "mainIGW" {
  vpc_id = "${aws_vpc.mainVpc.id}"
  tags = {
    Name = "main_IGW"
  }
}
[root@ip-172-31-15-18 terraform_rearc_project]# 
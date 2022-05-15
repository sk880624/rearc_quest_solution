=~=~=~=~=~=~=~=~=~=~=~= PuTTY log 2022.05.15 21:27:59 =~=~=~=~=~=~=~=~=~=~=~=
cat public_subnet.tf
resource "aws_subnet" "mainPublicSubnets" {
  count                   = "${length(var.public_subnet_cidr)}"
  vpc_id                  = "${aws_vpc.mainVpc.id}"
  cidr_block              = "${element(var.public_subnet_cidr, count.index)}"
  availability_zone       = "${element(var.availability_zone, count.index)}"
  map_public_ip_on_launch = true
  tags = {
    Name = "PublicSubnet_${element(var.public_subnet_cidr, count.index)}"
  }
}



[root@ip-172-31-15-18 terraform_rearc_project]# 
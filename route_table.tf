=~=~=~=~=~=~=~=~=~=~=~= PuTTY log 2022.05.15 21:28:24 =~=~=~=~=~=~=~=~=~=~=~=
cat route_table.tf
resource "aws_route_table" "main_Public_RT" {
  vpc_id = "${aws_vpc.mainVpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.mainIGW.id}"
  }

  tags = {
    Name = "main_Public_RT"
  }
}



resource "aws_route_table_association" "Public_subnet_association" {
  subnet_id      = "${element(aws_subnet.mainPublicSubnets.*.id, count.index)}"
  count          = "${length(var.public_subnet_cidr)}"
  route_table_id = "${aws_route_table.main_Public_RT.id}"
}

[root@ip-172-31-15-18 terraform_rearc_project]# 
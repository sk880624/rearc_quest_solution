=~=~=~=~=~=~=~=~=~=~=~= PuTTY log 2022.05.15 21:25:59 =~=~=~=~=~=~=~=~=~=~=~=
cat ec2.tf
resource "aws_instance" "my_instance" {
  ami                    = "ami-079b5e5b3971bd10d"
  count                  = var.instance_count
  instance_type          = "t2.micro"
  key_name               = "${aws_key_pair.custom_key.key_name}"
  vpc_security_group_ids = ["${aws_security_group.custom-sg.id}"]
  subnet_id              = "${element(aws_subnet.mainPublicSubnets.*.id, count.index)}"
  tags = {
    Name = "tf_created_ins-${count.index + 1}"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("${path.module}/id_rsa")
    host        = "${self.public_ip}"
  }

  provisioner "file" {
    source      = "Dockerfile"
    destination = "/home/ec2-user/Dockerfile"

  }
  provisioner "file" {
    source      = "index.js"
    destination = "/home/ec2-user/index.js"

  }
  provisioner "file" {
    source      = "package.json"
    destination = "/home/ec2-user/package.json"

  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install docker -y",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo sleep 40",
      "sudo docker build -t custom_node_image .",
      "sudo sleep 70",
      "sudo docker run -itd --name node_app -p 80:8080 custom_node_image",
    ]
  }

  #  user_data = <<-EOF
  ##!/bin/bash
  #yum update -y
  #yum install docker -y
  #systemctl start docker
  #systemctl enable docker
  #EOF


}



resource "aws_key_pair" "custom_key" {
  key_name   = "custom_key"
  public_key = file("${path.module}/id_rsa.pub")
}

#output "keyname" {
#value = "${aws_key_pair.custom_key.key_name}"
#}


resource "aws_security_group" "custom-sg" {
  name        = "custom-sg"
  description = "Assignment"
  vpc_id      = "${aws_vpc.mainVpc.id}"

  dynamic "ingress" {
    for_each = [22, 80, 8080, 3000, 4444, 27107]
    iterator = port
    content {
      description = "TLS from VPC"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Custom-SG-Terraform"
  }
  depends_on = ["aws_vpc.mainVpc"]
}
[root@ip-172-31-15-18 terraform_rearc_project]# 
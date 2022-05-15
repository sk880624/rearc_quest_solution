=~=~=~=~=~=~=~=~=~=~=~= PuTTY log 2022.05.15 21:25:33 =~=~=~=~=~=~=~=~=~=~=~=
cat application_load_balancer.tf
resource "aws_lb" "mainALB" {
  load_balancer_type = "application"
  name               = "mainALB"
  internal           = "false"
  security_groups    = ["${aws_security_group.elb_security_group.id}"]

  subnets = "${aws_subnet.mainPublicSubnets.*.id}"
  tags = {
    Name = "mainALB"
  }
}

resource "aws_security_group" "elb_security_group" {
  name        = "ELB-SG"
  description = "Security group for Application Load Balancer"
  vpc_id      = "${aws_vpc.mainVpc.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow web traffic to load balancer"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elb_security_group"
  }
}


resource "aws_alb_target_group" "mainTG" {
  name     = "mainTG"
  vpc_id   = "${aws_vpc.mainVpc.id}"
  port     = 80
  protocol = "HTTP"
  health_check {
    path                = "/"
    port                = "80"
    healthy_threshold   = 3
    unhealthy_threshold = 10
    interval            = 10
    timeout             = 5

  }

  tags = {
    Name = "mainTG"
  }
}



resource "aws_alb_target_group_attachment" "mainTG_attachment" {
  target_group_arn = "${aws_alb_target_group.mainTG.arn}"
  count            = "${length(var.public_subnet_cidr)}"
  port             = 80
  target_id        = "${element(aws_instance.my_instance.*.id, count.index)}"
}


resource "aws_alb_listener" "front-end-nodes" {
  load_balancer_arn = "${aws_lb.mainALB.arn}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.mainTG.arn}"
  }
}
[root@ip-172-31-15-18 terraform_rearc_project]# 
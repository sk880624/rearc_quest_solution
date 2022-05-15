output "load_balancer_dns" {
        value = "${aws_lb.mainALB.dns_name}"
}

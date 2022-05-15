=~=~=~=~=~=~=~=~=~=~=~= PuTTY log 2022.05.15 21:27:11 =~=~=~=~=~=~=~=~=~=~=~=
cat production.tfvars
vpc_cidr           = "10.0.0.0/16"
public_subnet_cidr = ["10.0.0.0/24", "10.0.1.0/24"]
availability_zone  = ["ap-south-1a", "ap-south-1b"]
region             = "ap-south-1"
[root@ip-172-31-15-18 terraform_rearc_project]# 
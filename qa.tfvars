vpc_cidr = "10.1.0.0/16"

environment = "qa"

public_subnet_cidrs = ["10.1.1.0/24", "10.1.3.0/24"]

private_subnet_cidrs = ["10.1.50.0/24", "10.1.51.0/24"]

availability_zones = ["us-east-1a", "us-east-1b"]

max_size = 1

min_size = 1

desired_capacity = 1

instance_type = "t2.micro"

ecs_aws_ami = "ami-275ffe31"

provider "aws" {
  region = "us-east-1"
}

module "ecs" {
  source = "modules/ecs"

  environment          = "${var.environment}"
  cluster              = "${var.environment}"
  cloudwatch_prefix    = "${var.environment}"           #See ecs_instances module when to set this and when not!
  vpc_cidr             = "${var.vpc_cidr}"
  public_subnet_cidrs  = "${var.public_subnet_cidrs}"
  private_subnet_cidrs = "${var.private_subnet_cidrs}"
  availability_zones   = "${var.availability_zones}"
  max_size             = "${var.max_size}"
  min_size             = "${var.min_size}"
  desired_capacity     = "${var.desired_capacity}"
  key_name             = "${aws_key_pair.ecs.key_name}"
  instance_type        = "${var.instance_type}"
  ecs_aws_ami          = "${var.ecs_aws_ami}"
}

resource "aws_key_pair" "ecs" {
  key_name   = "ecs-key-${var.environment}"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDySaHA85axXRL25SMnHV8+DXnsGZMcy+zuQoJURDKZRkpsbo90iZgbugGtIal/6pw8voF/z/7FBJrNaZeo05kTCbqmftnDaKnqj24OlE8p5eIiiht02rXYSKQugDP7eyVK6s8iYOE9z8FhxjsfafgXBOJedhXwZj78WaRZ17P6/vp0+BgRupCWmM9otH4maN6jTHS8A4eYgketfYVk9WDo3Yvq3i+/6KYbFp6nx0kgjpwuR2zz7kRLV/IBSxFEf5TKnrhbj+DV4WFuMQjG2VjGjtnpEw6Lfz4aQ8FsAaHac2k0sbZwuG5NYEL7p+Sgx8uKp/K2CQRoGV7pgkVfj5af production_key"
}

variable "vpc_cidr" {}
variable "environment" {}
variable "max_size" {}
variable "min_size" {}
variable "desired_capacity" {}
variable "instance_type" {}
variable "ecs_aws_ami" {}

variable "private_subnet_cidrs" {
  type = "list"
}

variable "public_subnet_cidrs" {
  type = "list"
}

variable "availability_zones" {
  type = "list"
}

output "default_alb_target_group" {
  value = "${module.ecs.default_alb_target_group}"
}

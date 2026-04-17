module "vpc" {
  source = "./modules/vpc"
  aws_region = var.aws_region
  environment_name = var.environment_name
  subnet_newbits = var.subnet_newbits
  vpc_cidr = var.vpc_cidr
}
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet" {
  value = module.vpc.public_subnet
}

output "private_subnet" {
  value = module.vpc.private_subnet
}

output "public_subnet_map" {
  value = module.vpc.public_subnet_map
}

output "public_subnet_range" {
  value = module.vpc.public_subnet_range
}

output "cidrBlock_AvailabilityZone_Public"{
    value = module.vpc.cidrBlock_AvailabilityZone_Public
}
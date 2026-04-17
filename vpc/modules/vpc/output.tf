output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet" {
  value = [for s in aws_subnet.public_subnet : s.id]
}

output "private_subnet" {
  value = [for s in aws_subnet.private_subnet : s.id]
}

output "public_subnet_map" {
  value = {
    for az, subnet in aws_subnet.public_subnet : az => subnet.id
  }
}

output "public_subnet_range" {
  value = [ for ip_range in local.public_subnet : ip_range ]
}

output "cidrBlock_AvailabilityZone_Public"{
    value = { for i, az in local.azs : az => local.public_subnet[i] }
}
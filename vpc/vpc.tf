resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = merge(var.tags, {
    Name = "${var.environment_name}-vpc"
  })
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.tags, {
    Name = "${var.environment_name}-igw"
  })
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  for_each                = { for idx, az in local.azs : az => local.public_subnet[idx] }
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true
  tags = merge(var.tags, {
    Name = "${var.environment_name}-public_subnet"
  })
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main.id
  for_each          = { for idx, az in local.azs : az => local.private_subnet[idx] }
  cidr_block        = each.value
  availability_zone = each.key
  tags = merge(var.tags, {
    Name = "${var.environment_name}-private_subnet"
  })
}

resource "aws_eip" "eip" {
  tags = merge(var.tags, {
    Name = "${var.environment_name}-nateip"
  })
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = values(aws_subnet.public_subnet)[0].id
  tags = merge(var.tags, {
    Name = "${var.environment_name}-nat"
  })
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge(var.tags, { Name = "${var.environment_name}-publicroutetable" })
}

resource "aws_route_table_association" "public_route_ass" {
  for_each       = aws_subnet.public_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = merge(var.tags, { Name = "${var.environment_name}-nat" })
}

resource "aws_route_table_association" "private_route_ass" {
  for_each       = aws_subnet.private_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_route.id
}

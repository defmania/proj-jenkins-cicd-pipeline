#Setup VPC
resource "aws_vpc" "app_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

#Setup Public Subnets
resource "aws_subnet" "public_subnet" {
  count                   = length(var.cidr_public_subnet)
  vpc_id                  = aws_vpc.app_vpc.id
  cidr_block              = element(var.cidr_public_subnet, count.index)
  map_public_ip_on_launch = true
  availability_zone       = element(var.availability_zone, count.index)

  tags = {
    Name = "public_app_subnet-${count.index + 1}"
  }
}

#Setup Private Subnets
resource "aws_subnet" "private_subnet" {
  count                   = length(var.cidr_private_subnet)
  vpc_id                  = aws_vpc.app_vpc.id
  cidr_block              = element(var.cidr_private_subnet, count.index)
  map_public_ip_on_launch = false
  availability_zone       = element(var.availability_zone, count.index)

  tags = {
    Name = "private_app_subnet-${count.index + 1}"
  }
}

#Setup Internet Gateway
resource "aws_internet_gateway" "app_igw" {
  vpc_id = aws_vpc.app_vpc.id


  tags = {
    Name = "app-internet-gw"
  }
}

#Setup Public RT
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.app_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.app_igw.id
  }

  tags = {
    Name = "public_app_rt"
  }
}

resource "aws_route_table_association" "public_rt_association" {
  count          = length(aws_subnet.public_subnet)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_rt.id

}
#Setup Private RT
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.app_vpc.id

  tags = {
    Name = "private_app_rt"
  }
}

resource "aws_route_table_association" "private_rt_association" {
  count          = length(aws_subnet.private_subnet)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_rt.id
}

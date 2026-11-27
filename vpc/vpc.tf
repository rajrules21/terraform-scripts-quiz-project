##########################################################################################################################

# Create VPC and Subnets for ECS Service

resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
}

resource "aws_subnet" "subnet_1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.subnet_1_cidr_block
  availability_zone = var.subnet_1_availability_zone
}

resource "aws_subnet" "subnet_2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.subnet_2_cidr_block
  availability_zone = var.subnet_2_availability_zone
}

resource "aws_internet_gateway" "my_internet_gateway" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table" "main-rt" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route" "internet_gateway_route" {
  route_table_id         = aws_route_table.main-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_internet_gateway.id
}

resource "aws_route_table_association" "subnet_association_1" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.main-rt.id
}

resource "aws_route_table_association" "subnet_association_2" {
  subnet_id      = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.main-rt.id
}




##########################################################################################################################
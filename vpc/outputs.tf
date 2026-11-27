output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "subnet_ids" {
  value = [
    aws_subnet.subnet_1.id,
    aws_subnet.subnet_2.id
  ]
}

output "route_table_id" {
  value = aws_route_table.main-rt.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.my_internet_gateway.id
}




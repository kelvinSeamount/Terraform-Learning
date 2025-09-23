output "vpc_id" {
  value = aws_vpc.my-vpc.id
}

output "subnet_id" {
  value = aws_subnet.my-subnet.id
}

output "sg_id" {
  value = aws_security_group.my-sg.id
}
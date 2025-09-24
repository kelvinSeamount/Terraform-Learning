output "publicip" {
  value = [for instance in aws_instance.my-instance : instance.public_ip]
}
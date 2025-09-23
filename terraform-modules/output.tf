output "instance_public_ip" {
  value = module.instance.publicip # Pass the public IP from the instance module output
}

# Development Environment Outputs

output "dev_instance_public_ip" {
  value = module.instance_dev.publicip
}
output "prod_instance_public_ip" {
  value = module.instance_prod.publicip
}
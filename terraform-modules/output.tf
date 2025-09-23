output "instance_public_ip" {
  value = module.instance.publicip # Pass the public IP from the instance module output
}
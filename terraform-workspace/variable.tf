variable "region" {
  description = "AWS Region"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default = "10.0.0.0/16"
}

variable "cidr_block_subnet" {
  description = "CIDR block for the subnet"
  default = "10.0.1.0/24"
  
}

variable "azone" {
  description = "Availability Zone for the subnet"
  default = "eu-central-1a"
  
}

variable "key_name" {
  description = "Key pair name for EC2 instance"
}

variable "itype" {
  description = "Instance type for EC2 instance"
  default = "t2.micro"
}

variable "instance_count" {
  description = "Number of EC2 instances to launch"
  default = 1
}

variable "volume_size" {
  description = "Size of the EBS volume in GB"
  default = 8   
}

variable "volume_type" {
  description = "Type of the EBS volume"
  default = "gp2"
  
}
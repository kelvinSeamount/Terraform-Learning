provider "aws" {
  region = var.region
}

data "aws_ami" "ubuntu_lts"{
    most_recent = true 

     filter {
         name = "name"
         values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-*-*.04-amd64-server-*"]
     }

     filter {
       name = "virtualization-type"
       values = ["hvm"]
     }

        owners = ["099720109477"] # Canonical
}

module "vpc" {
  source = "./terraform-modules/modules/vpc"
    vpc_cidr = var.vpc_cidr
    vpc_name = var.vpc_name
    cidr_block_subnet = var.cidr_block_subnet
    subnet_name = var.subnet_name
    azone = var.azone
    sg_name = var.sg_name
    igw_name = var.igw_name
    route_table_name = var.route_table_name
}

module "instance" {
  source = "./terraform-modules/modules/instance"
  instance_name = var.instance_name
  instance_count = var.instance_count
  itype = var.itype
  key_name = var.key_name
  volume_size = var.volume_size
  volume_type = var.volume_type
  ami = data.aws_ami.ubuntu_lts.id
  subnet_id = module.vpc.subnet_id # Pass the subnet ID from the VPC module output
  vpc_security_group_ids = module.vpc.sg_id # Pass the security group ID from the VPC module output
}


#simulating prod  env 

module "vpc_prod" {
  source = "./terraform-modules/modules/vpc"
  vpc_cidr = var.dev_vpc_cidr
  vpc_name = var.dev_vpc_name
  cidr_block_subnet = var.dev_cidr_block_subnet
  subnet_name = var.dev_subnet_name
  azone = var.dev_azone
  sg_name = var.dev_sg_name
  igw_name = var.dev_igw_name
  route_table_name = var.dev_route_table_name
}

module "instance_prod" {
  source = "./terraform-modules/modules/instance"
  instance_name= var.dev_instance_name
  instance_count = var.dev_instance_count
  itype = var.dev_itype
  key_name = var.dev_key_name
  volume_size = var.dev_volume_size
  volume_type = var.dev_volume_type
  ami = data.aws_ami.ubuntu_lts.id
  subnet_id = module.vpc_prod.subnet_id # Pass the subnet ID from the VPC module output
  vpc_security_group_ids = module.vpc_prod.sg_id # Pass the security group ID from the VPC module output
}

# simulating dev env
module "vpc_dev" {
  source = "./terraform-modules/modules/vpc"
  vpc_cidr =var.dev_vpc_cidr
  vpc_name = var.dev_vpc_name
  cidr_block_subnet = var.dev_cidr_block_subnet
  subnet_name = var.dev_subnet_name
  azone = var.dev_azone
  sg_name = var.dev_sg_name
  igw_name = var.dev_igw_name
  route_table_name = var.dev_route_table_name
}

module "instance_dev" {
  source = "./terraform-modules/modules/instance"
  instance_name= var.dev_instance_name
  instance_count = var.dev_instance_count
  itype = var.dev_itype
  key_name = var.dev_key_name
  volume_size = var.dev_volume_size
  volume_type = var.dev_volume_type
  ami = data.aws_ami.ubuntu_lts.id
  subnet_id = module.vpc_dev.subnet_id # Pass the subnet ID from the VPC module output
  vpc_security_group_ids = module.vpc_dev.sg_id # Pass the security group ID from the VPC module output
}

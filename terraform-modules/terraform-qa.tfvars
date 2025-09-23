region = "eu-central-1"
vpc_cidr = "10.0.0.0/16"
vpc_name = "my-vpc"
cidr_block_subnet = "10.0.1.0/24"
subnet_name = "my-subnet"
azone = "eu-central-1a"
sg_name = "my-sg"
igw_name = "my-igw"
route_table_name = "my-route-table"
instance_name = "my-instance"
instance_count = 1
itype = "t2.micro"
key_name = "Meka-Devops"
volume_size = 8
volume_type = "gp3"


# simulating prod env
prod_vpc_cidr = "10.0.0.0/16"
prod_vpc_name = "my-vpc-prod"
prod_cidr_block_subnet = "10.0.1.0/24"
prod_subnet_name = "my-subnet-prod"
prod_azone = "eu-central-1b"
prod_sg_name = "my-sg-prod"
prod_igw_name = "my-igw-prod"
prod_route_table_name = "my-route-table-prod"
prod_instance_name = "my-instance-prod"
prod_instance_count = 1
prod_itype = "t2.micro"
prod_key_name = "Meka-Devops"
prod_volume_size = 8
prod_volume_type = "gp3"


# simulating dev env
dev_vpc_cidr = "10.1.0.0/16"
dev_vpc_name = "my-vpc-dev"
dev_cidr_block_subnet = "10.1.1.0/24"
dev_subnet_name = "my-subnet-dev"
dev_azone = "eu-central-1a"
dev_sg_name = "my-sg-dev"
dev_igw_name = "my-igw-dev"
dev_route_table_name = "my-route-table-dev"
dev_instance_name = "my-instance-dev"
dev_instance_count = 1
dev_itype = "t2.micro"
dev_key_name = "Ride-Ark"
dev_volume_size = 8
dev_volume_type = "gp2"
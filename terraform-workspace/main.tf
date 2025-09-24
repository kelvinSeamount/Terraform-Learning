provider "aws" {
  region = var.region
}

terraform {
	backend "s3" {
		bucket = "terraform-state-remote-mekadevops"
		key    = "state/terraform.tfstate"
		region = "eu-central-1"
		dynamodb_table = "terra-lock-mekadevops"
		encrypt =true

	}
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

resource "aws_vpc" "my-vpc" {
  
  cidr_block = var.vpc_cidr
  
  tags = {
    Name = local.vpc_name
  }
  
}

resource "aws_subnet" "my-subnet" {
 
  vpc_id = aws_vpc.my-vpc.id # Reference the VPC created above
  cidr_block = var.cidr_block_subnet # Use the variable for subnet CIDR block
  map_public_ip_on_launch = true
  availability_zone = var.azone 

    tags = {
       Name = local.subnet_name
    }
  
}

resource "aws_security_group" "my-sg" {
  vpc_id = aws_vpc.my-vpc.id
  name = "SG-1"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
    egress  {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = local.sg_name
    }
}

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "My-IGW"
  }
}

resource "aws_route_table" "my-route-table" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }
    tags = {
        Name = "My-Route-Table"
    }
}

resource "aws_route_table_association" "my-route-table-association" {
  subnet_id = aws_subnet.my-subnet.id
  route_table_id = aws_route_table.my-route-table.id
}

resource "aws_instance" "my-instance" {
  count = var.instance_count
    ami = data.aws_ami.ubuntu_lts.id
    instance_type = var.itype
    key_name = var.key_name
    subnet_id = aws_subnet.my-subnet.id
    vpc_security_group_ids = [aws_security_group.my-sg.id]

    root_block_device {
        volume_size = var.volume_size
        volume_type = var.volume_type
        
    }
    tags = {
        Name = "${local.instance_name}-${count.index + 1}"
    }
}
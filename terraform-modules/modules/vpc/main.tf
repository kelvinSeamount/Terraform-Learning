resource "aws_vpc" "my-vpc" {
  
  cidr_block = var.vpc_cidr
  
  tags = {
    Name = var.vpc_name
  }

}

resource "aws_subnet" "my-subnet" {
 
  vpc_id = aws_vpc.my-vpc.id 
  cidr_block = var.cidr_block_subnet
  map_public_ip_on_launch = true
  availability_zone = var.azone 

    tags = {
       
        Name = var.subnet_name
    }
}


resource "aws_security_group" "my-sg" {
  vpc_id = aws_vpc.my-vpc.id
  name = var.sg_name

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
    Name = var.sg_name
  }
}


resource "aws_internet_gateway" "my-igw" {
    vpc_id = aws_vpc.my-vpc.id

    tags = {
        Name = var.igw_name
    }
}

resource "aws_route_table" "my-route-table" {
   vpc_id = aws_vpc.my-vpc.id

   route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my-igw.id
   }

   tags ={
        Name =var.route_table_name  
   }
}
 
resource "aws_route_table_association" "my_route_table_association" {
  subnet_id = aws_subnet.my-subnet.id
  route_table_id = aws_route_table.my-route-table.id
}
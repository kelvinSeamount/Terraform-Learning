provider "aws" {
  region = var.region
}


#based on datasource "aws_ami" "ubuntu" 
data "aws_ami" "ubuntu_lts" {
    most_recent = true 

    #filter based on ubuntu official ami
     filter {
         name = "name"
            # values based public ubuntu ami
         values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-*-*.04-amd64-server-*"]
         # * is a wildcard
     }
     # bbased on virtualization type

     filter {
       name = "virtualization-type"
       values = ["hvm"]
     }

        owners = ["099720109477"] # Canonical
}

resource "aws_vpc" "my-vpc" {
  
  cidr_block = var.vpc_cidr
  
  tags = {
    Name = var.vpc_name
  }

}

resource "aws_subnet" "my-subnet" {
 
  vpc_id = aws_vpc.my-vpc.id # Reference the VPC created above
  cidr_block = var.cidr_block_subnet # Use the variable for subnet CIDR block
  map_public_ip_on_launch = true
  availability_zone = var.azone 

    tags = {
       
        Name = var.subnet_name
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
 

 # this block is for importing existing instances created outside terraform
resource "aws_instance" "imported_instance" {
  # This resource is intentionally left blank for import purposes
   ami = "ami-0a116fa7c861dd5f9"
   key_name = var.key_name
   subnet_id = "subnet-07102c002187d5822"
   vpc_security_group_ids = ["sg-0f356daf808549338"]
   instance_type = "t2.medium"
   

    tags = {
          Name = "VM"
    }

    root_block_device {
      volume_size = 15
        volume_type = "gp3"
    }
}

resource "aws_route_table_association" "my_route_table_association" {
  subnet_id = aws_subnet.my-subnet.id
  route_table_id = aws_route_table.my-route-table.id
}

resource "aws_instance" "my_instance" {
   
   ami = data.aws_ami.ubuntu_lts.id # Use the latest Ubuntu LTS AMI from the data source
   key_name = var.key_name
   subnet_id = aws_subnet.my-subnet.id
   vpc_security_group_ids = [aws_security_group.my-sg.id]
   instance_type = var.itype
   count =var.instance_count # Number of instances to create

    provisioner "file" {
      source = "emeka.txt"
      destination = "/home/ubuntu/emeka.txt"

      # define connection details
       connection {
         type = "ssh"
            user = "ubuntu"
            private_key = file("/home/ubuntu/Infra/Meka-Devops.pem")
            host = self.public_ip
       }
    }

    # execute a command on the local instance

    provisioner "local-exec" {
      command = "echo Instance created with Public IP: ${self.public_ip}"
    }

  #execute a command on the remote instance to install maven
    provisioner "remote-exec" {
      inline = [ 
        "sudo apt-get update -y",
        "sudo apt-get install maven -y",
        "mvn -version"
       ]

       # define connection details
       connection {
          type = "ssh"
            user = "ubuntu"
            private_key = file("/home/ubuntu/Infra/Meka-Devops.pem")
            host = self.public_ip
       }
    }
    tags = {
          Name = "${var.instance_name}-${count.index +1}" # Tag each instance with a unique name
    }

    root_block_device {
      volume_size = var.volume_size
        volume_type = var.volume_type
    }
}
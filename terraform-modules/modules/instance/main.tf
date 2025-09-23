resource "aws_instance" "my_instance" {
   
   ami = var.ami 
   key_name = var.key_name
   subnet_id = var.subnet_id # Pass the subnet ID
   vpc_security_group_ids = [var.vpc_security_group_ids] # Pass the security group ID
   instance_type = var.itype
   count =var.instance_count 

    tags = {
          Name = "${var.instance_name}-${count.index +1}" 
    }

    root_block_device {
      volume_size = var.volume_size
        volume_type = var.volume_type
    }
}


# Define names with respect to the environment
locals {
    vpc_name  = "${terraform.workspace}-VPC"
    subnet_name = "${terraform.workspace}-Subnet"
    sg_name = "${terraform.workspace}-SG"
    instance_name = "${terraform.workspace}-Instance"
}
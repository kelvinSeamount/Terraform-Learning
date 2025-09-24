# This is basically my learning journey on how best to use Infrastructure as code tool with terraform 
# Here i will also be adding basic command lines which are in line with industry standard 


 #                                           Basic commands

 # terraform import aws_instance.imported_instance [ instance id created outside of terraform ]
                                  



#                                               Terraform Modules 

# This project demonstrates how to build and use Terraform modules to deploy AWS infrastructure for multiple environments (dev and prod) using reusable, modular code
# tf-modules/
# ├── main.tf                 # Root config calling modules  
# ├── variables.tf            # Variables for dev/prod
# ├── output.tf              # Outputs from both environments
# ├── terraform-qa.tfvars    # Variable values
# └── modules/
#   ├── vpc/               # VPC, subnet, security group
#   └── instance/          # EC2 instances


#                               Terraform Workspace

# Terraform workspaces allow you to manage multiple environments (dev, staging, prod) using the same Terraform configuration.

# Each workspace maintains its own state file, enabling you to deploy identical infrastructure to different environments without conflicts.

# .
# ├── dev.tfvars
# ├── locals.tf
# ├── main.tf
# ├── output.tf
# ├── prod.tfvars
# └── variables.tf



#       Create a new workspace
#  terraform workspace new dev
# terraform workspace new prod

#       Switch between workspaces 
# terraform workspace select dev
# terraform workspace select prod
aws_region = "us-east-1"
vpc_cidr   = "10.1.0.0/16"
# public_subnet1_cidr = "10.1.1.0/24"
# public_subnet2_cidr = "10.1.2.0/24"
# public_subnet3_cidr = "10.1.3.0/24"
vpc_name             = "terraform-aws-testing"
key_name             = "aws_login"
environment          = "dev"
tf_state_bucket_name = "devsecopsb989tfstate"
owner                = "DevOpsTeam"
instance_type        = "t2.micro"
imagename            = {
  us-east-1 = "ami-0c55b159cbfafe1f0"
}
#IGW_name             = "terraform-aws-igw"
azs                  = ["us-east-1a", "us-east-1b", "us-east-1c"]       # Availability Zones
public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]    # Public Subnet CIDR Blocks
private_subnet_cidrs = ["10.1.10.0/24", "10.1.20.0/24", "10.1.30.0/24"] # Private Subnet CIDR Blocks


inbound_ports  = ["3306", "22", "80", "443", "3389", "22", "80", "443", "3389", "22", "80", "443", "3389"]
outbound_ports = ["3306", "80", "443", "80", "443", "80", "443", "80", "443"]
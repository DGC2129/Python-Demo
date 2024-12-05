locals {
  public_subnet_cidrs  = distinct(var.public_subnet_cidrs)
  private_subnet_cidrs = distinct(var.private_subnet_cidrs)
  azs                  = distinct(var.azs)
}

resource "aws_subnet" "public-subnets" {
  #count             = 4 # 0 1 2 3
  count             = length(local.public_subnet_cidrs)
  vpc_id            = aws_vpc.default.id
  cidr_block        = element(local.public_subnet_cidrs, count.index)
  availability_zone = element(local.azs, count.index)
  tags = {
    Name = "${var.vpc_name}-public-${count.index + 1}"
  }
}

resource "aws_subnet" "private-subnets" {
  #count             = 4 # 0 1 2 3
  count             = length(local.private_subnet_cidrs)
  vpc_id            = aws_vpc.default.id
  cidr_block        = element(local.private_subnet_cidrs, count.index)
  availability_zone = element(local.azs, count.index)
  tags = {
    Name = "${var.vpc_name}-private-${count.index + 1}"
  }
}

#resource "aws_subnet" "subnet2-public" {
#   vpc_id            = aws_vpc.default.id
#   cidr_block        = var.public_subnet2_cidr
#   availability_zone = "us-east-1b"
#   tags = {
#     Name = "${var.vpc_name}-public-subnet-2"
#   }
# }

# resource "aws_subnet" "subnet3-public" {
#   vpc_id            = aws_vpc.default.id
#   cidr_block        = var.public_subnet3_cidr
#   availability_zone = "us-east-1c"
#   tags = {
#     Name = "${var.vpc_name}-public-subnet-3"
#   }

# }
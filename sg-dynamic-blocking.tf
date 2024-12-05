data "http" "myip2" {
  url = "https://ipv4.icanhazip.com"
}

locals {
  inbound_ports  = toset(var.inbound_ports)
  outbound_ports = toset(var.outbound_ports)
}

#Pass a list value to toset to convert it to a set, which will remove any duplicate elements and discard the ordering of the elements.

resource "aws_security_group" "allow_all_dynamic" {
  name        = "${var.vpc_name}-Allow-All-Dynamic"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.default.id

  dynamic "ingress" {
    for_each = local.inbound_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
    }
  }


  dynamic "egress" {
    for_each = local.outbound_ports
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
    }
  }

}









































#Commented out as bucket remove from tfstate.
# resource "aws_s3_bucket" "terraforms3bucket" {
#   bucket = var.tf_state_bucket_name

#   tags = {
#     Name        = var.tf_state_bucket_name
#     Environment = "Dev"
#   }

#   depends_on = [
#     aws_vpc.default
#   ]
# }

#DynamoDB table for state locking
# resource "aws_dynamodb_table" "terraform_locks" {
#   name         = "devsecopsb41-terraform-state-lock"
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key     = "LockID"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }
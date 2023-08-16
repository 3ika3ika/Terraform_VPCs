locals {
  pub_sub_count = length(var.cidrsubpub)
  pri_sub_count = length(var.cidrsubpri)

  ###########################################################
  len_public_subnets      = max(length(var.cidrsubpub))
  len_private_subnets     = max(length(var.cidrsubpri))
  create_private_subnets =  local.len_private_subnets > 0
  create_public_subnets =  local.len_public_subnets > 0
 
}

# VPC resource
resource "aws_vpc" "vpc" {
  
  cidr_block              = var.cidrvpc
  enable_dns_hostnames    = var.dnshostname
  enable_dns_support      = var.dnsres
}

resource "aws_subnet" "pub_sub" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.cidrsubpub[count.index]
  count                   = local.pub_sub_count
  # availability_zone       = data.aws_availability_zones.available.names[count.index]
}

# Private subnets
resource "aws_subnet" "pri_sub" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.cidrsubpri[count.index]
  count                   = local.pri_sub_count

  # availability_zone       = data.aws_availability_zones.available.names[count.index]
}

#Public Route tables 
resource "aws_route_table" "public" {
  count                 = local.pub_sub_count > 0 ? 1 : 0
  vpc_id                = aws_vpc.vpc.id
} 

#Private Route tables 
resource "aws_route_table" "private" {
  count                 = local.pri_sub_count > 0 ? 1 : 0
  vpc_id                = aws_vpc.vpc.id
} 

# Route table assosiation with public subnets 
resource "aws_route_table_association" "public_assosiaciton" {
 count = local.create_public_subnets ? local.len_public_subnets : 0
  subnet_id            = element(aws_subnet.pub_sub[*].id, count.index)
  route_table_id       = aws_route_table.public[0].id 
  }  

# Route table assosiation with private subnets 
resource "aws_route_table_association" "private_assosiaciton" {
 count = local.create_private_subnets ? local.len_private_subnets : 0
  subnet_id            = element(aws_subnet.pri_sub[*].id, count.index)
  route_table_id       = aws_route_table.private[0].id 
  }



###################
# This VPC Routes #  Routes from THIS route table to PEER CIDR
###################
resource "aws_route" "this_routes" {
 
  # Only create routes for this route table if input dictates it, and in that case, for all combinations
  
  route_table_id            = aws_route_table.private[0].id 
  destination_cidr_block    = var.peer_blocks
  vpc_peering_connection_id = var.vpc_peering_id
}












# ###################
# # This VPC Associated Routes #  Routes from THIS route table to associated PEER CIDR
# ###################
# resource "aws_route" "this_associated_routes" {
#   provider = aws.this
#   # Only create routes for this route table if input dictates it, and in that case, for all combinations
#   count                     = local.create_associated_routes_this ? length(local.this_associated_routes) : 0
#   route_table_id            = local.this_associated_routes[count.index].rts_id
#   destination_cidr_block    = local.this_associated_routes[count.index].dest_cidr
#   vpc_peering_connection_id = aws_vpc_peering_connection.this.id
# }

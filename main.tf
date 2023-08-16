

#VPC configuration for VPC B
module "vpc_b" {
  source = "./modules/vpc"
  

providers   = {
   aws     = aws.peer
  }
 
  cidrvpc   = "10.1.0.0/16"
  cidrsubpub = ["10.1.0.0/20", "10.1.16.0/20"]
  cidrsubpri = ["10.1.32.0/20", "10.1.48.0/20"]
  peer_blocks = "10.2.32.0/20"
  vpc_peering_id = module.single_account_multi_region.vpc_peering_id
  
}

#VPC configuration for VPC C
module "vpc_c" {
  
 source = "./modules/vpc"

providers   = {
    aws    = aws.this
  }

  cidrvpc   = "10.2.0.0/16"
  cidrsubpri = ["10.2.32.0/20", "10.2.48.0/20"]
  peer_blocks = "10.1.32.0/20"
   vpc_peering_id = module.single_account_multi_region.vpc_peering_id
}


module "single_account_multi_region" {
   source = "./modules/peering"

  this_vpc_id = module.vpc_c.vpc_id
  peer_vpc_id = module.vpc_b.vpc_id
  peer_region = "eu-west-1"
  
  
}


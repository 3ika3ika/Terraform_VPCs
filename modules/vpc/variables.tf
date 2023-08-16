#fill below info #####################################

variable "access_key"{
    default = ""
} 

variable "secret_key" {
    default = ""
} 

#fill above info #####################################





#VPC variables 

variable "cidrvpc" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "cidrsubpub" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
  default     = []
}

variable "cidrsubpri" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
  default     = []
}

variable "dnshostname" {
    description = "True or False"
    type        = bool
    default     = true    
}
variable "dnsres" {
    description = "True or False"
    type        = bool    
    default     = true
}


variable "peer_vpc_id" {
  description = "Peer VPC ID: string"
  type        = string
  default     = ""
}

variable "this_vpc_id" {
  description = "This VPC ID: string"
  type        = string
  default     = ""
}

variable "auto_accept_peering" {
  description = "Auto accept peering connection: bool"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags: map"
  type        = map(string)
  default     = {}
}

variable "peer_dns_resolution" {
  description = "Indicates whether a local VPC can resolve public DNS hostnames to private IP addresses when queried from instances in a peer VPC"
  type        = bool
  default     = false
}

variable "this_dns_resolution" {
  description = "Indicates whether a local VPC can resolve public DNS hostnames to private IP addresses when queried from instances in a this VPC"
  type        = bool
  default     = false
}

variable "from_this" {
  description = "If traffic TO peer vpc (from this) should be allowed"
  type        = bool
  default     = true
}

variable "from_this_associated" {
  description = "If traffic for associated CIDRs TO peer VPC (from this) should be allowed"
  type        = bool
  default     = false
}

variable "from_peer" {
  description = "If traffic FROM the peer VPC (to this) should be allowed"
  type        = bool
  default     = true
}

variable "from_peer_associated" {
  description = "If traffic FROM associated CIDRs of the peer VPC (to this) should be allowed"
  type        = bool
  default     = false
}

variable "peer_subnets_ids" {
  description = "If communication can only go to some specific subnets of peer vpc. If empty whole vpc cidr is allowed"
  type        = list(string)
  default     = []
}

variable "this_subnets_ids" {
  description = "If communication can only go to some specific subnets of this vpc. If empty whole vpc cidr is allowed"
  type        = list(string)
  default     = []
}

variable "this_rts_ids" {
  description = "Allows to explicitly specify route tables for this VPC"
  type        = list(string)
  default     = []
}

variable "peer_rts_ids" {
  description = "Allows to explicitly specify route tables for peer VPC"
  type        = list(string)
  default     = []

}

variable "vpc_peering_id" {
  type        = string
  default     = ""
}

variable "peer_blocks" {
 type        = string
  default     = "10.1.32.0/20"
}
variable "cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "cidr block for vpc"
}

variable "tags" {
  type = map(string)
  default = {
    name = "anz_demo"
  }
  description = "tag for the resources"
}

variable "pub_cidr_block" {
  type        = string
  description = "public subnet cidr block"
}


variable "pub_subnet_az" {
  type        = string
  description = "availability zone for public subnet"
}

variable "pri_cidr_block" {
  type        = string
  description = "private subnet cidr block"
}

variable "pri_subnet_az" {
  type        = string
  description = "availability zone for private subnet"
}


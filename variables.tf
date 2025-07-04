variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type        = list(string)
  description = "Public subnets CIDRs"
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "private_subnet_cidr" {
  type        = list(string)
  description = "Private subnets CIDRs"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}


variable "public_subnets" {
  type        = map(string)
  description = "Public subnets used in VPC mapped to AZ letter" # VER
  default = {
    a = "10.0.0.0/24"
    b = "10.0.1.0/24"
  }
}

variable "private_subnets" {
  type        = map(string)
  description = "Public subnets used in VPC mapped to AZ letter" # VER
  default = {
    a = "10.0.3.0/24"
    b = "10.0.4.0/24"
  }
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "white_listed_ips" {
  type    = list(string)
  default = ["0.0.0.0/0"] #que IP VA AHI o poner libre....o solo quien tenga permiso/ acceso permitido.
}


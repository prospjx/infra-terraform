variable "cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_1_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "subnet_2_cidr" {
  type    = string
  default = "10.0.2.0/24"
}

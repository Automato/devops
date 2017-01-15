# The name of the organization to create the tier for
variable "org_name" {
  type = "string"
}

# The name of the tier ex. "development"
variable "tier_name" {
  type = "string"
}

variable "vpc_cidr_block" {
  type = "string"
}

variable "vpc_instance_tenancy" {
  type = "string"
  default = "default"
}

variable "vpc_enable_dns_support" {
  type = "string" # It's a boolean, but terraform doesn't support that
  default = "true"
}

variable "vpc_enable_dns_hostnames" {
  type = "string" # It's a boolean, but terraform doesn't support that
  default = "true"
}

# The aws zones in which to create subnets
variable "vpc_zones" {
  type = "list"
}

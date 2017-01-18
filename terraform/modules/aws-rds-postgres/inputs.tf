# The name of the organization to create the tier for
variable "org_name" {
  type = "string"
}

# The name of the tier ex. "development"
variable "tier_name" {
  type = "string"
}

variable "db_name" {
  type = "string"
}

variable "vpc_id" {
  type = "string"
}

variable "security_group_id" {
  type = "string"
  default = ""
}

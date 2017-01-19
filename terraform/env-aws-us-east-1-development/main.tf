module "aws-development-tier" {
  source = "../modules/aws-tier"
  org_name = "${var.org_name}" 
  tier_name = "development"
  vpc_cidr_block = "10.0.0.0/16"
  vpc_zones = ["us-east-1a", "us-east-1b", "us-east-1d", "us-east-1e"]
}

module "aws-api-ec2-tier" {
  source = "../modules/aws-ec2-tier"
  org_name = "${var.org_name}"
  env_tier_name = "development"
  app_tier_name = "api"
  vpc_id = "${module.aws-development-tier.vpc_id}"
}

module "aws-api-postgres-db" {
  source = "../modules/aws-rds-postgres"
  org_name = "${var.org_name}"
  tier_name = "development"
  vpc_id = "${module.aws-development-tier.vpc_id}"
  db_name = "api"
}

# Add an inbound security rule for app to be allowed to access the database
resource "aws_security_group_rule" "ingress_from_api_app_to_postgres" {
  type = "ingress"
  from_port = 5432
  to_port = 5432
  protocol = "tcp"

  # Apply rules to the given security group if it is provided, otherwise apply them the the created group
  security_group_id = "${module.aws-api-postgres-db.security_group_id}"
  source_security_group_id = "${module.aws-api-ec2-tier.security_group_id}"
}

# Add an outbound security rule for app to be allowed to access the database
resource "aws_security_group_rule" "egress_from_api_app_to_postgres" {
  type = "egress"
  from_port = 5432
  to_port = 5432
  protocol = "tcp"

  # Apply rules to the given security group if it is provided, otherwise apply them the the created group
  security_group_id = "${module.aws-api-ec2-tier.security_group_id}"
  source_security_group_id = "${module.aws-api-postgres-db.security_group_id}"
}

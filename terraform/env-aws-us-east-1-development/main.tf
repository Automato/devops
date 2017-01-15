module "env-tier" {
  source = "../modules/env-tier"
  org_name = "${var.org_name}" 
  tier_name = "development"
  vpc_cidr_block = "10.0.0.0/16"
  vpc_zones = ["us-east-1a", "us-east-1b", "us-east-1d", "us-east-1e"]
}

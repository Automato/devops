# AWS Provider
# This providers is used by terraform to connect to and provision AWS
# By default it will go looking for a ~/.aws/credentials file for keys
# I'm using a profile I call "s3-admin" which must have the ability to create s3 buckets and write to them
provider "aws" {
  region = "us-east-1" # This really doesn't matter
  profile = "s3-admin"
}

# Organization name
variable "org_name" {}

# Administrative Log Bucket
# This global s3 bucket is designed to hold logs for the admin bucket actions
variable "s3_admin_log_bucket" {}
resource "aws_s3_bucket" "s3_admin_log_bucket" {
  bucket = "${vars.s3_admin_log_bucket}"
  acl = "log-delivery-write"

  tags {
    Name = "${vars.org_name} Administrative Log Bucket"
    Environment = "Internal"
  }
}


# Administrative Bucket
# This global s3 bucket is designed to hold administrative shared files for the organization
# This is part of bootstrap because the bucket will be used to hold environment tfstate files,
# results of packer builds, and other shared resources used in provisioning
variable "s3_admin_bucket" {}
resource "aws_s3_bucket" "s3_admin_bucket" {
  bucket = "${vars.s3_admin_bucket}"
  acl = "private"
  logging {
    target_bucket = "${aws_s3_bucket.s3_admin_log_bucket.id}"
    target_prefix = "log/"
  }
  versioning {
    enabled = true
  }

  tags {
    Name = "${vars.org_name} Administrative Bucket"
    Environment = "Internal"
  }
}

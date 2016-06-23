# AWS Provider
# This providers is used by terraform to connect to and provision AWS
# By default it will go looking for a ~/.aws/credentials file for keys
# I'm using a profile I call "s3-admin" which must have the ability to create s3 buckets and write to them
provider "aws" {
  region = "us-east-1" # This really doesn't matter
  profile = "s3-admin"
}

# Automato Administrative Log Bucket
# This global s3 bucket is designed to hold logs for the Automato admin bucket actions
resource "aws_s3_bucket" "automato_admin_log_bucket" {
  bucket = "automato-admin-log"
  acl = "log-delivery-write"

  tags {
    Name = "Automato administrative log bucket"
    Environment = "Internal"
  }
}


# Automato Administrative Bucket
# This global s3 bucket is designed to hold administrative shared files for the Automato organization
# This is part of bootstrap because the bucket will be used to hold environment tfstate files,
# results of packer builds, and other shared resources used in provisioning
resource "aws_s3_bucket" "automato_admin_bucket" {
  bucket = "automato-admin"
  acl = "private"
  logging {
    target_bucket = "${aws_s3_bucket.automato_admin_log_bucket.id}"
    target_prefix = "log/"
  }
  versioning {
    enabled = true
  }

  tags {
    Name = "Automato administrative bucket"
    Environment = "Internal"
  }
}

#!/bin/bash

# PREREQUISITES: AWS keys need to be setup.
# I use a secrets.tf file to setup AWS along with a ~/.aws/credentials file

# Run terraform apply to setup the bucket
terraform apply

# Move the tfstate for that bucket into itself
terraform remote config -backend=s3 \
  -backend-config="bucket=automato-admin" \
  -backend-config="key=terraform/bootstrap.tfstate" \
  -backend-config="region=us-east-1"


#!/bin/bash

# Error on exit, error on undefined variables, print each command, print each expanded command and fail in pipes
set -euvxo pipefail

# PREREQUISITES: AWS keys need to be setup.
# I use a secrets.tf file to setup AWS along with a ~/.aws/credentials file

# Check for .env to preseed variables if they exist
set +e
source .env
set -e

# Run terraform apply to setup the bucket
terraform apply \
  -var org_name=${ORG_NAME} \
  -var s3_admin_log_bucket=${S3_ADMIN_LOG_BUCKET} \
  -var s3_admin_bucket=${S3_ADMIN_BUCKET}

# Move the tfstate for that bucket into itself
terraform remote config -backend=s3 \
  -backend-config="bucket=${S3_ADMIN_BUCKET}" \
  -backend-config="key=terraform/bootstrap.tfstate" \
  -backend-config="region=us-east-1"

# Push the state up to the remote bucket
terraform remote push


#!/bin/bash


# Error on exit, error on undefined variables, print each command, print each expanded command and fail in pipes
set -euvxo pipefail

# PREREQUISITES: AWS keys need to be setup.
# I use a secrets.tf file to setup AWS along with a ~/.aws/credentials file

# Check for .env to preseed variables if they exist
set +e
source ../../.env
set -e

# Sync the tfstate from the remote
terraform remote config -backend=s3 \
                        -backend-config="bucket=${S3_ADMIN_BUCKET}" \
                        -backend-config="key=terraform/env-aws-us-east-1-development.tfstate" \
                        -backend-config="region=us-east-1"

# "Get" any modules used by this
terraform get

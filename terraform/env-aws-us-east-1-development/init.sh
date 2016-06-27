#!/bin/bash

terraform remote config -backend=s3 \
                        -backend-config="bucket=automato-admin" \
                        -backend-config="key=terraform/aws-us-east-1-development.tfstate" \
                        -backend-config="region=us-east-1"

terraform get

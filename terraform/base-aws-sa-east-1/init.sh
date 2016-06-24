#!/bin/bash

terraform remote config -backend=s3 \
                        -backend-config="bucket=automato-admin" \
                        -backend-config="key=terraform/global-aws.tfstate" \
                        -backend-config="region=us-east-1"

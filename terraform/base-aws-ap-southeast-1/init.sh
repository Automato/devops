#!/bin/bash

terraform remote config -backend=s3 \
                        -backend-config="bucket=automato-admin" \
                        -backend-config="key=terraform/base-aws-ap-southeast-1.tfstate" \
                        -backend-config="region=ap-southeast-1"

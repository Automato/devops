#!/bin/bash

terraform remote config -backend=s3 \
                        -backend-config="bucket=automato-admin" \
                        -backend-config="key=terraform/base-aws-us-west-1.tfstate" \
                        -backend-config="region=us-west-1"

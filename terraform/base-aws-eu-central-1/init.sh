#!/bin/bash

terraform remote config -backend=s3 \
                        -backend-config="bucket=automato-admin" \
                        -backend-config="key=terraform/base-aws-eu-central-1.tfstate" \
                        -backend-config="region=eu-central-1"

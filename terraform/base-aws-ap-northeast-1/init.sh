#!/bin/bash

terraform remote config -backend=s3 \
                        -backend-config="bucket=automato-admin" \
                        -backend-config="key=terraform/base-aws-ap-northeast-1.tfstate" \
                        -backend-config="region=ap-northeast-1"

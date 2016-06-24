#!/bin/bash

terraform remote config -backend=s3 \
                        -backend-config="bucket=automato-admin" \
                        -backend-config="key=terraform/base-aws-ap-northeast-2.tfstate" \
                        -backend-config="region=ap-northeast-2"

#! /bin/bash

for f in include/*;do source $f; done

STACKNAME=$S3STACK
TEMPLATE=../templates/s3.yaml
stack_action $1
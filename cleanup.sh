#!/bin/bash

MAIN_DIR=$PWD

# part-1
cd part-1-terraform-deployment
docker run -v $PWD:/workspace -w /workspace hashicorp/terraform:1.1.3 destroy -auto-approve
rm -f ipaddress-unrefined.txt
rm -f ipaddress-with-quotes.txt
rm -f ipaddress.txt

cd ${MAIN_DIR}

# part-2
cd part-2-ansible-deployment
rm -f aws_key.pem
rm -f Dockerfile

cd ${MAIN_DIR}
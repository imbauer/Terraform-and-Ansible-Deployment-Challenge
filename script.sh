#!/bin/bash

MAIN_DIR=$PWD

# part-1
cd part-1-terraform-deployment
docker run -v $PWD:/workspace -w /workspace hashicorp/terraform:1.1.3 init
docker run -v $PWD:/workspace -w /workspace hashicorp/terraform:1.1.3 apply -auto-approve

# Send elastic ip address of ec2 instance to a file where it can be parsed and be sent to the ansible section for ssh use
echo $(docker run -v $PWD:/workspace -w /workspace hashicorp/terraform:1.1.3 output) > ipaddress-unrefined.txt
awk '{print $3}' ipaddress-unrefined.txt > ipaddress-with-quotes.txt
sed 's/\"//g' ipaddress-with-quotes.txt > ipaddress.txt
sed "s/REPLACEME/$(cat ipaddress.txt)/g" ../part-2-ansible-deployment/Dockerfile.tpl > ../part-2-ansible-deployment/Dockerfile

# Move the ssh key for the ec2 instance to the ansible section
mv aws_key.pem ../part-2-ansible-deployment/aws_key.pem

cd ${MAIN_DIR}

# part-2
cd part-2-ansible-deployment
chmod 0644 aws_key.pem
docker build . -t local-ansible:1.0.5
docker run -v $PWD:/workspace -w /workspace local-ansible:1.0.5 chmod 400 aws_key.pem
docker run -v $PWD:/workspace -w /workspace local-ansible:1.0.5 ansible-playbook -i /etc/ansible/hosts playbook.yml

cd ${MAIN_DIR}

echo ""
echo "Enter the IP Address below into your web browser"
echo "==============="
cat part-1-terraform-deployment/ipaddress.txt
echo "==============="
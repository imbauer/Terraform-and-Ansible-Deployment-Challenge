# Terraform and Ansible Deployment Challenge

TODO

## Description

TODO

## Getting Started

### Dependencies

* 
* 

### Installing

* 
* 

### Instructions

* 1. Clone the GitHub repository
```
git clone https://github.com/imbauer/Terraform-and-Ansible-Deployment-Challenge.git
```
* 2. cd into the directory
```
cd Terraform-and-Ansible-Deployment-Challenge
```
* 3. Create a file called `terraform.tfvars` inside of the directory `part-1-terraform-deployment`. Make sure that your IAM user has the following policies attached: `AmazonEC2FullAccess` and `AmazonVPCFullAccess`. Now generate an access-key and secret-key and add the following code snippet to the `terraform.tfvars` file in the `part-1-terraform-deployment` directory.
```
aws_access_key = "<enter-your-aws-access-key-here>"
aws_secret_key = "<enter-your-aws-secret-key-here>"
```
* 4. Go back to the main directory and execute the `script.sh` file like so
```
sudo ./script.sh
```
* 5. Copy the url displayed at the end of the script and go to that webpage
* 6. Execute the `cleanup.sh` file to remove all AWS resources that you created, and other temporary files, and puts the repository back into a state where you can do the process of provisioning the Terraform/Ansible Infrastructure again by starting at step 4 again.

## Help

Any advise for common problems or issues.
```
command to run if program contains helper info
```

## Authors

Ivan Bauer

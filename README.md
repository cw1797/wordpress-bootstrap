# otraw-wordpress-bootstrap

This repo is used to bootstrap a secure wordpress installation for the otraw-weapp.

- Infrastructure is provisioned on AWS using terraform creating a VPC, Subnet, Security Group and EC2 instance.
- Docker is deployed with tls enabled using Ansible to the remote EC2 instance
- LEMP stack with nginx, mysql and wordpress docker containers deployed using docker compose via Ansible

### Pre-requisites
tfwitch - Allows you to easily switch and install terrform versions `brew install tfswitch`

secrets.tfvars - Create in the root of the terraform dir. This is required to authenticate to AWS and set the region. Ensure this file is included in .gitignore.
```
aws_region     = "aws_region"
aws_access_key = "aws_access_key"
aws_secret_key = "aws_secret_key"
```

ansible - Needed to excute the playbooks on the remote host. This playbook is working with `ansible [core 2.14.3]`

## Step 1 - Provisiong Infrastructure

### Run Terraform to provision the Infrastructue

Switch to the terraform dir `cd terraform`

Install the required terraform version (auto picks up required-version from provider.tf) `tfswitch`

Initialise terraform `terraform init`

Run a plan to view desired changes 'terraform plan -var-file=secrets.tfvars'

Run terraform apply to provision the infra `terraform apply -var-file=secrets.tfvars`

## Step 2 - Install Docker and configure with TLS

Run `ansible-playbook site.yml -i inventories/inventory.yml --ask-become-pass --tags "deploy_docker"`


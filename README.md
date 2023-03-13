# otraw-wordpress-bootstrap

This repo is used to bootstrap a secure wordpress installation for the otraw-webapp.

- Infrastructure is provisioned on AWS using terraform creating a VPC, Subnet, Security Group and EC2 instance.
- Docker is deployed onn ec2 instance enabled with tls using Ansible.
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

.env - This file need to be located here `docker/otraw-app/.env`. It contains the sensitive environment variables used by docker compose so ensure it is included in both .gitignore and .dockerignore
```
MYSQL_ROOT_PASSWORD="rootpassword"
MYSQL_USER="msqluser"
MYSQL_PASSWORD="mysqlpassword123"
```

## Step 1 - Provision AWS Resources

Switch to the terraform dir `cd terraform`

Install the required terraform version (auto picks up required-version from provider.tf) `tfswitch`

Initialise terraform `terraform init`

Run a plan to view desired changes `terraform plan -var-file=secrets.tfvars`

Run terraform apply to provision the infra `terraform apply -var-file=secrets.tfvars`


## Step 2 - Deploy Docker with TLS

Run the following command to configure docker with tls on the ec2 instance. `ansible-playbook site.yml -i inventories/inventory.yml --ask-become-pass --tags "deploy_docker"` 
Once run you will have the necessary certs on your local machine used to authenticate with docker in the following directory `~/.docker`


## Step 3 - Deploy Wordpress with LEMP stack

Enure the following config files have your domain specified in them `docker/otraw-app/webserver/nginx-conf/nginx.conf` `docker/otraw-app/webserver/nginx-conf/nginx-https.conf.new`

Run the`ansible-playbook site.yml -i inventories/inventory.yml --ask-become-pass --tags "deploy_lemp" -e local_user=john.doe -e certbot_email=john.doe@example.com -e domain_name=domain.co.uk`


## To be done

- Use s3 as backend for terraform state

- Enable elasic IP for ec2 instance

- Use github actions for a better gitops workflow

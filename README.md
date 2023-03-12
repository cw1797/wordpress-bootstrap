# otraw-wordpress-bootstrap

This repo is used to bootstrap a secure wordpress installation for the otraw-weapp.

- Infrastructure is provisioned on AWS using terraform creating a VPC, Subnet, Security Group and EC2 instance.
- Docker is deployed with tls enabled using Ansible to the remote EC2 instance
- LEMP stack with nginx, msql and wordpress docker containers deployed using docker compose via Ansible

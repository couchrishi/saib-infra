#!/bin/bash -e

echo "1.Spinning up a new Kubernetes pod to create a Jenkins slave instance
2. Initializing Terraform to provision infrastructure for running a 3-Tier application
3. Invoking Chef for configuring Tomcat apache and MySQL"
terraform -init
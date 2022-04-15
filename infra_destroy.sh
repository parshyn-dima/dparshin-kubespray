#!/bin/bash

set -e

rm -rf kubespray/inventory/mycluster/hosts.ini

cd terraform
TF_IN_AUTOMATION=1 terraform destroy -auto-approve

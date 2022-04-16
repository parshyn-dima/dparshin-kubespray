#!/bin/bash

set -e
cd terraform
bash generate_inventory.sh > ../inventory/prod/test-k8s-calico/hosts.ini

cd ../kubespray
ansible-playbook -i ../inventory/prod/test-k8s-calico/hosts.ini --become-user=root upgrade-cluster.yml
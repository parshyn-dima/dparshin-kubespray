#!/bin/bash

set -e

printf "[all]\n"

for num in 1 2
do
printf "node$num   ansible_host="
terraform output -json internal_ip_address_nodes | jq -j ".[$num-1]"
printf "\n"
done

for num in 1
do
printf "master$num  ansible_host="
terraform output -json internal_ip_address_master | jq -j ".[$num-1]"
printf "\n"
done

for num in 1
do
printf "ingress$num  ansible_host="
terraform output -json internal_ip_address_ingress | jq -j ".[$num-1]"
printf "\n"
done
printf "\n"

printf "[bastion]\n"
printf "bastion ansible_host="
terraform output -json external_ip_address_bastion | jq -j ".[]"
printf "   ansible_user=ubuntu"
printf "\n"
printf "\n"

cat << EOF
[kube_control_plane]
master1

[etcd]
master1

[kube_node]
node1
node2
ingress1

[kube_worker]
node1
node2

[kube_ingress]
ingress1

[calico_rr]

[k8s_cluster:children]
kube_control_plane
kube_node
calico_rr
EOF

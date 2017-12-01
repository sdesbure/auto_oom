#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

export ANSIBLE_STDOUT_CALLBACK=debug
# Shouldn't be done <wut I'm too bad to figure out how to do it
export openstack_creds=/etc/bolla/openstack_openrc

#-------------------------------------------------------------------------------
# Check run as root
#-------------------------------------------------------------------------------
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" 1>&2
    exit -1
fi

cd ${target_folder}

echo "
#-------------------------------------------------------------------------------
# Prepare nodes, oom and run oom
#-------------------------------------------------------------------------------
"

source ${openstack_creds}
ansible-playbook -i /etc/r8s/inventory.yaml onap-oom.yaml

echo "
#-------------------------------------------------------------------------------
# End
#-------------------------------------------------------------------------------
"
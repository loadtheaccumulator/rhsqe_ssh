#!/bin/bash

: <<'_comment_'

    Author: Jonathan Holloway
    Email: holloway@redhat.com
    
    Purpose:    SSH Helper Functions
                Functions to assist in running simple scripts, functions, and individual commands via ssh

    NOTE:   Source this file prior to use.
            This script assumes ssh keys have already been setup on local/remote systems.
_comment_

# Change default user, key path, and options from examples below
DEFAULT_USER=root
DEFAULT_KEYPATH=~/.ssh/id_rsa_rhsqe
DEFAULT_OPTIONS="-oPasswordAuthentication=no -oStrictHostKeyChecking=no"


RHSQE_SSH_USER=${RHSQE_SSH_USER:=$DEFAULT_USER}
RHSQE_SSH_KEYPATH=${RHSQE_SSH_KEYPATH:=$DEFAULT_KEYPATH}
RHSQE_SSH_OPTIONS=${RHSQE_SSH_OPTIONS:=$DEFAULT_OPTIONS}


function rhsqe_sshf()
{
    local function_name=$1
    local server_list=$2

    for the_server in $server_list
    do
        (declare -f ${function_name}; echo ${function_name}) | ssh -i ${RHSQE_SSH_KEYPATH} ${RHSQE_SSH_OPTIONS} ${RHSQE_SSH_USER}@${the_server} 'bash -s'
    done 
}


function rhsqe_sshs()
{
    local script_name=$1
    local server_list=$2

    for the_server in $server_list
    do
        cat $script_name | ssh -i ${RHSQE_SSH_KEYPATH} ${RHSQE_SSH_OPTIONS} ${RHSQE_SSH_USER}@${the_server} 'bash -s'
    done 
}


function rhsqe_sshc()
{
    local command=$1
    local server_list=$2

    for the_server in $server_list
    do
        ssh -i ${RHSQE_SSH_KEYPATH} ${RHSQE_SSH_OPTIONS} ${RHSQE_SSH_USER}@${the_server} ${command}
    done
}


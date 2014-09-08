#!/bin/bash

: <<'_comment_'

    Author: Jonathan Holloway
    Email: holloway@redhat.com
    
    Purpose:    SSH Helper Functions
                Functions to assist in running functions, scripts, and individual commands via ssh

    NOTE:   Source this file prior to use.
            This script assumes ssh keys have already been setup on local/remote systems.
_comment_

# Change keypath from example below
KEYPATH=~/.ssh/id_rsa_rhsqe


function rhsqe_sshf()
{
    THEFUNCNAME=$1
    THESERVERLIST=$2

    #echo;echo ">>>>> RHSQE_SSHF: Running ${THEFUNCNAME} on ${THESERVERLIST}"

    for the_server in $THESERVERLIST
    do
        (declare -f ${THEFUNCNAME}; echo ${THEFUNCNAME}) | ssh -i ${KEYPATH} -oPasswordAuthentication=no -oStrictHostKeyChecking=no root@${the_server} 'bash -s'
    done 
}


function rhsqe_sshs()
{
    THESCRIPTNAME=$1
    THESERVERLIST=$2

    #echo;echo ">>>>> RHSQE_SSHS: Running ${THESCRIPTNAME} on ${THESERVERLIST}"

    for the_server in $THESERVERLIST
    do
         cat $THESCRIPTNAME | ssh -i ${KEYPATH} -oPasswordAuthentication=no -oStrictHostKeyChecking=no root@${the_server} 'bash -s'
    done 
}


function rhsqe_sshc()
{
    THECOMMAND=$1
    THESERVERLIST=$2

    #echo;echo ">>>>> RHSQE_SSHC: Running ${THECOMMAND} on ${THESERVERLIST}"

    for the_server in $THESERVERLIST
    do
        ssh -i ${KEYPATH} -oPasswordAuthentication=no -oStrictHostKeyChecking=no root@${the_server} ${THECOMMAND}
    done
}


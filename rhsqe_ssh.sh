#!/bin/bash

: <<'_comment_'

    Author: Jonathan Holloway
    Email: holloway@redhat.com
    
    Purpose:    SSH Helper Functions
                Functions to assist in running functions, scripts, and individual commands via ssh

    Note: Source this file prior to use.
_comment_

: <<'_comment_'

   rhsqe_sshf - Executes a locally declared shell function on one or more remote systems

    Usage: rhsqe_sshf "<function_name> [params]" "<list_of_hostnames>"
    e.g., 
        function getDirectoryList()
        {
            thedir=$1
            ls $thedir
        }

        rhsqe_sshf "getDirectoryList /etc" "host1.example.com host2.example.com host3.example.com"

_comment_

function rhsqe_sshf()
{
    THEFUNCNAME=$1
    THESERVERLIST=$2

    #echo;echo ">>>>> RHSQE_SSHF: Running ${THEFUNCNAME} on ${THESERVERLIST}"

    for the_server in $THESERVERLIST
    do
        (declare -f ${THEFUNCNAME}; echo ${THEFUNCNAME}) | ssh -i ~/.ssh/id_rsa_rhsqe -oPasswordAuthentication=no -oStrictHostKeyChecking=no root@${the_server} 'bash -s'
    done 
}

: <<'_comment_'

    rhsqe_sshs - Executes a local shell script on one or more remote systems

    Usage: rhsqe_sshs <script_name> "<list_of_hostnames>"
    e.g., 
        rhsqe_sshs getUname.sh "host1.example.com host2.example.com host3.example.com"

_comment_

rhsqe_sshs()
{
    THESCRIPTNAME=$1
    THESERVERLIST=$2

    #echo;echo ">>>>> RHSQE_SSHS: Running ${THESCRIPTNAME} on ${THESERVERLIST}"

    for the_server in $THESERVERLIST
    do
         cat $THESCRIPTNAME | ssh -i ~/.ssh/id_rsa_rhsqe -oPasswordAuthentication=no -oStrictHostKeyChecking=no root@${the_server} 'bash -s'
    done 
}

: <<'_comment_'

    rhsqe_sshc - Executes a command on one or more remote systems

    Usage: rhsqe_sshc "<command>" "<list_of_hostnames>"
    e.g., 
        rhsqe_sshc "uname -a" "host1.example.com host2.example.com host3.example.com"

_comment_

rhsqe_sshc()
{
    THECOMMAND=$1
    THESERVERLIST=$2

    #echo;echo ">>>>> RHSQE_SSHC: Running ${THECOMMAND} on ${THESERVERLIST}"

    for the_server in $THESERVERLIST
    do
        ssh -i ~/.ssh/id_rsa_rhsqe -oPasswordAuthentication=no -oStrictHostKeyChecking=no root@${the_server} ${THECOMMAND}
    done
}

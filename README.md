rhsqe_ssh
=========

Author: Jonathan Holloway
Email: holloway@redhat.com

Purpose:    SSH Helper Functions
            Functions to assist in running functions, scripts, and individual commands via ssh


USING THE SCRIPT:

Source rhsqe_ssh.sh prior to use.
The rhsqe_ssh.sh script assumes ssh keys have already been setup on local/remote systems.

rhsqe_sshf - Executes a locally declared shell function on one or more remote systems

    Usage: rhsqe_sshf "<function_name> [params]" "<list_of_hostnames>"
    e.g., 
        function getDirectoryList()
        {
            thedir=$1
            ls $thedir
        }

        rhsqe_sshf "getDirectoryList /etc" "host1.example.com host2.example.com host3.example.com"


rhsqe_sshs - Executes a local shell script on one or more remote systems

    Usage: rhsqe_sshs <script_name> "<list_of_hostnames>"
    e.g., 
        rhsqe_sshs getUname.sh "host1.example.com host2.example.com host3.example.com"


rhsqe_sshc - Executes a command on one or more remote systems

    Usage: rhsqe_sshc "<command>" "<list_of_hostnames>"
    e.g., 
        rhsqe_sshc "uname -a" "host1.example.com host2.example.com host3.example.com"


KNOWN ISSUES:

When running rhsqe_sshs, might have issues with the following BASH_SOURCE method.
$0 is "bash" and ${BASH_SOURCE[0]} is empty on the remote system

    function somefunction {
        do_something
    }

    source=${BASH_SOURCE[0]}
    if [ $source == $0 ]; then
        somefunction $@
    fi



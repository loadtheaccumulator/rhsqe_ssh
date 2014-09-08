rhsqe_ssh
=========

Author: Jonathan Holloway
Email: holloway@redhat.com

Purpose:    SSH Helper Functions
            Functions to assist in running functions, scripts, and individual commands via ssh



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




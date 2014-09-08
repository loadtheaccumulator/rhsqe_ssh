#!/bin/bash

# source this to test rhsqe_sshf
# rhsqe_sshf testls "<HOSTNAME>"

# test rhsqe_sshs
# rhsqe_sshs testls.sh "<HOSTNAME>"

function testls {
    hostname
    ls -ail
    echo
}

# this will run locally when sourcing. ignore it.
testls


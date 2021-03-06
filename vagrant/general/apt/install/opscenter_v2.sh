#!/usr/bin/env bash
set -x # echo on

FILENAME=opscenter_v2.sh

PACKAGES='opscenter'
CACHE=/cache/apt/$FILENAME

if [ ! -d ${CACHE} ]; then
    echo "deb http://debian.datastax.com/community stable main" | \
        sudo tee -a /etc/apt/sources.list.d/datastax.sources.list
    curl -L https://debian.datastax.com/debian/repo_key | sudo apt-key add -
    sudo apt-get update

    mkdir -p ${CACHE}
    apt-get --print-uris --yes install $PACKAGES | grep ^\' | cut -d\' -f2 > ${CACHE}.list
    wget -c -i ${CACHE}.list -P ${CACHE}
fi
sudo dpkg -i ${CACHE}/*

#!/bin/bash

# configure the repo at runtime with passed in credentials 
helm repo add internal ${HELM_INTERNAL_REPO}

# run the slave
jenkins-slave

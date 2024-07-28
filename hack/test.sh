#!/bin/bash

#TODO cleanup zot
export OCI_REG_PLAIN_HTTP=on
export ZOT_VERSION=${ZOT_VERSION:-"2.1.0"}
docker run -d -p 5000:5000 --name zot ghcr.io/project-zot/zot:v${ZOT_VERSION}
sleep 1
kcl  mod push oci://localhost:5000/kind-kcl
kcl run oci://localhost:5000/kind-kcl

#!/bin/sh
cd certs
./generate-cert.sh
cd ..
npm install
node server.js `hostname`

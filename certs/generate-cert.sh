#!/bin/sh

set -x
set -e

# create CA
# step 1 private key
openssl genrsa -out rootCA.key 2048
# step 2 certificate
openssl req -x509 -new -key rootCA.key -out rootCA.cer -days 730 -subj /CN="Example Custom CA"

# create certificate (authorised by CA)
# step 1 private key
openssl genrsa -out server.key 2048
subj=/CN=`hostname`
# step 2 CSR  (Client Signing Request)
openssl req -new -out server.req -key server.key -subj $subj
# step 3 certificate
openssl x509 -req -in server.req -out server.cer -CAkey rootCA.key -CA rootCA.cer -days 365 -CAcreateserial -CAserial serial

# adaptions for node.js
# convert crt and key to pem
openssl x509 -in server.cer -out server.crt.pem -outform PEM
openssl rsa -in server.key -out server.key.pem -outform PEM



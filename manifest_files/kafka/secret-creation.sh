#!/bin/bash

openssl genrsa -out ca-key.pem 2048

openssl req -new -key ca-key.pem -x509 \
  -days 1000 \
  -out ca.pem \
  -subj "/C=US/ST=CA/L=Confluent/O=Confluent/OU=Operator/CN=KafkaCA"

#Create kubernetes secret
kubectl create secret tls ca-pair-sslcerts --cert=ca.pem --key=ca-key.pem -n kafka
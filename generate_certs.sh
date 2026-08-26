#!/usr/bin/bash

set -e 

CERT_DIR="./certs"

echo "====================================="
echo "Starting Automated Lab PKI Generation"
echo "====================================="

if [ -d "$CERT_DIR" ]; then
	echo "Removing old certificate artifacts..."
	rm -rf "$CERRT_DIR"
fi
mkdir -p "$CERT_DIR"

cd "$CERT_DIR"

echo "Generating Private Root CA..."
openssl genrsa -out root_ca.key 4096

openssl req -x509 -new -nodes \
	-key root_ca.key \
	-sha256 \
	-days 356 \
	-out root_ca.crt \
	-subj "/CN=My-Local-Lab-Root-CA/O=DevLab"

echo "Generating Go Server Key & Request (CSR)..."
openssl genrsa -out server.key 2048

openssl req -new \
	-key server.key \
	-out server.csr \
	-subj "/CN=go-server/O=DevLab"

echo "Creating SAN Extension Profile..."
cat <<EOF > server.ext
authorityKeyIdentifier=keyid.issuer
basicConstraints=CA:FALSE
keyUsage = digitalSinature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = go-server
DNS.2 = localhost
EOF

echo "Signing Server Certificate with Local Root CA..."
opensslt x509 -req -in server.csr \
	-CA root_ca.crt \
	-CAkey root_ca.key \
	-CAcreateserial \
	-out server.crt \
	-days 356 \
	-sha256 \
	-extfile server.ext

echo "==============================="
echo "PKI Generation Complete!"
echo "Files available in: $CERT_DIR"
echo "==============================="


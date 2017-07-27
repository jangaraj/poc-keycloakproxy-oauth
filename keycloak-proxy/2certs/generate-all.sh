ISSUER="/DC=com/DC=Monitoring Artist/O=Monitoring Artist/OU=Operations group/CN=Test Signing CA"
SUBJECT="/DC=com/DC=Monitoring Artist/O=Monitoring Artist/OU=Operations group/CN=localhost"

CA_KEY="cakey.pem"
CA_CERT="cacert.pem"
CSR="request.csr"
KP_KEY="keycloak-proxy-key.pem"
KP_CERT="keycloak-proxy-cert.pem"
BE_KEY="backend-key.pem"
BE_CERT="backend-cert.pem"

# CA
openssl genrsa -out $CA_KEY 2048
openssl req -x509 -new -nodes -key $CA_KEY -days 10000 -out cacert.pem -subj "$ISSUER"

# keycloak-proxy
echo "subjectAltName = IP:192.168.32.133,IP:127.0.0.1,DNS:fakedomain.com,DNS:fakelocalhost.com,DNS:localhost" > extfile.cnf
openssl genrsa -out $KP_KEY 2048
openssl req -new -key $KP_KEY -out $CSR -subj "$SUBJECT"
openssl x509 -req -in $CSR -CA $CA_CERT -CAkey $CA_KEY -CAcreateserial -out $KP_CERT -days 365 -extfile extfile.cnf

# app
echo "extendedKeyUsage = clientAuth,serverAuth" > extfile.cnf
openssl genrsa -out $BE_KEY 2048
openssl req -new -key $BE_KEY -out $CSR -subj "$SUBJECT"
openssl x509 -req -in $CSR -CA $CA_CERT -CAkey $CA_KEY -CAcreateserial -out $BE_CERT -days 365 -extfile extfile.cnf
rm -rf $CSR extfile.cnf
chmod -v 0444 *.pem

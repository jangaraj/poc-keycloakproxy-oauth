openssl req -config openssl-server.cnf -newkey rsa:2048 -sha256 -nodes -out servercert.csr -outform PEM
touch index.txt
openssl ca -config openssl-ca.cnf -policy signing_policy -extensions signing_req -out servercert.pem -infiles servercert.csr

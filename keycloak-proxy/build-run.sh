docker build -t keycloak-proxy .
echo 'y' | sudo dmsetup udevcomplete_all
docker rm -f keycloak-proxy | true
docker run -d \
  --name keycloak-proxy \
  --net=host \
  --volume $PWD/keycloak-proxy-config.yaml:/keycloak-proxy-config.yaml \
  --volume $PWD/certs/cacert.pem:/cacert.pem \
  --volume $PWD/certs/cakey.pem:/cakey.pem \
  --volume $PWD/certs/servercert.pem:/servercert.pem \
  --volume $PWD/certs/serverkey.pem:/serverkey.pem \
  --volume $PWD/mutual-certs/mutual-cert.pem:/mutual-cert.pem \
  --volume $PWD/mutual-certs/mutual-key.pem:/mutual-key.pem \
  --volume $PWD/2mutual-certs/ca.crt:/ca.crt \
  --volume $PWD/lecache/:/lecache/ \
  keycloak-proxy
docker logs -f keycloak-proxy

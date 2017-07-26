docker build -t keycloak-proxy .
docker rm -f keycloak-proxy | true
docker run -d \
  --name keycloak-proxy \
  --net=host \
  --volume $PWD/keycloak-proxy-config.yaml:/keycloak-proxy-config.yaml \
  --volume $PWD/certs/cacert.pem:/cacert.pem \
  --volume $PWD/certs/cakey.pem:/cakey.pem \
  --volume $PWD/lecache/:/lecache/ \
  keycloak-proxy

docker rm -f keycloak-proxy | true
docker run -d \
  --name keycloak-proxy \
  --net=host \
  --volume $PWD/keycloak-proxy-config.yaml:/keycloak-proxy-config.yaml \
  --volume $PWD/certs/cacert.pem:/cacert.pem \
  --volume $PWD/certs/cakey.pem:/cakey.pem \
  --volume $PWD/certs/servercert.pem:/servercert.pem \
  --volume $PWD/certs/serverkey.pem:/serverkey.pem \
  --volume $PWD/lecache/:/lecache/ \
  --entrypoint /opt/keycloak-proxy \
  quay.io/gambol99/keycloak-proxy \
  --config /keycloak-proxy-config.yaml
docker logs -f keycloak-proxy


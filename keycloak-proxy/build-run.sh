docker build -t keycloak-proxy .
echo 'y' | sudo dmsetup udevcomplete_all
docker rm -f keycloak-proxy | true
docker run -d \
  --name keycloak-proxy \
  --net=host \
  --volume $PWD/3certs/ca.pem:/etc/ssl/certs/cacert.pem \
  --volume $PWD/keycloak-proxy-config.yaml:/keycloak-proxy-config.yaml \
  --volume $PWD/3certs/ca.pem:/cacert.pem \
  --volume $PWD/3certs/ca-key.pem:/cakey.pem \
  --volume $PWD/3certs/proxy.pem:/keycloak-proxy-cert.pem \
  --volume $PWD/3certs/proxy-key.pem:/keycloak-proxy-key.pem \
  --volume $PWD/lecache/:/lecache/ \
  keycloak-proxy
docker logs -f keycloak-proxy

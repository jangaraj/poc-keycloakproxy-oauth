docker build -t keycloak-proxy .
docker rm -f keycloak-proxy | true
docker run -d \
  --name keycloak-proxy \
  --net=host \
  keycloak-proxy

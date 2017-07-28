FROM golang:1.8 as build
RUN go get -d github.com/gambol99/keycloak-proxy \
  && cd /go/src/github.com/gambol99/keycloak-proxy \
  && make static
 
FROM ubuntu as cert
COPY certs/cacert.pem /custom-ca.pem
RUN apt-get update && apt-get install ca-certificates -y \
  && mkdir -p /usr/local/share/ca-certificates/ \
  && openssl x509 -in /custom-ca.pem -inform PEM -out /usr/local/share/ca-certificates/custom-ca.crt \
  && update-ca-certificates
 
FROM scratch
WORKDIR /
COPY --from=build /go/src/github.com/gambol99/keycloak-proxy/bin/keycloak-proxy /
COPY --from=cert /etc/ssl/certs /etc/ssl/certs
#COPY certs/cacert.pem /
#COPY certs/cakey.pem /
#COPY keycloak-proxy-config.yaml /
 
CMD ["/keycloak-proxy", "--config", "/keycloak-proxy-config.yaml"]


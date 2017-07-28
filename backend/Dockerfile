# docker 17.05+ is required for multistage build

FROM golang:1.8 as build
COPY main.go /

RUN cd / && CGO_ENABLED=0 GOOS=linux go build -a -tags "netgo static_build" -installsuffix netgo -ldflags "-w -s" -o backend main.go

FROM scratch
WORKDIR /
COPY --from=build /backend /
#COPY certs/servercert.pem /
#COPY certs/serverkey.pem /
#COPY certs/backend-cert.pem /servercert.pem 
#COPY certs/backend-key.pem /serverkey.pem
COPY cert.pem /servercert.pem
COPY key.pem /serverkey.pem

CMD ["/backend"]


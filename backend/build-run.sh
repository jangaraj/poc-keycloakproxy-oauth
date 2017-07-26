docker build -t backend .
docker rm -f backend | true
docker run -d \
  --name backend \
  --net=host \
  backend

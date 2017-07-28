docker build -t backend .
echo 'y' | sudo dmsetup udevcomplete_all
docker rm -f backend | true
docker run -d \
  --name backend \
  --net=host \
  backend

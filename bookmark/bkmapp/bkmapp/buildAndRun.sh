#!/bin/sh
mvn clean package && docker build -t bkmapp/bkmapp .
docker rm -f bkmapp || true && docker run -d -p 8080:8080 -p 4848:4848 --name bkmapp bkmapp/bkmapp 

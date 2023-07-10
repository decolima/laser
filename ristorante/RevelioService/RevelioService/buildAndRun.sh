#!/bin/sh
mvn clean package && docker build -t revelio/RevelioService .
docker rm -f RevelioService || true && docker run -d -p 8080:8080 -p 4848:4848 --name RevelioService revelio/RevelioService 

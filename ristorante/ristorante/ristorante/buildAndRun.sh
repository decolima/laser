#!/bin/sh
mvn clean package && docker build -t ris/ristorante .
docker rm -f ristorante || true && docker run -d -p 8080:8080 -p 4848:4848 --name ristorante ris/ristorante 

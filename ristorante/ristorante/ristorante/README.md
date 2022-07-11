# Build
mvn clean package && docker build -t ris/ristorante .

# RUN

docker rm -f ristorante || true && docker run -d -p 8080:8080 -p 4848:4848 --name ristorante ris/ristorante 

# System Test

Switch to the "-st" module and perform:

mvn compile failsafe:integration-test
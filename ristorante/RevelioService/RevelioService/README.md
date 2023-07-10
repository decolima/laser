# Build
mvn clean package && docker build -t revelio/RevelioService .

# RUN

docker rm -f RevelioService || true && docker run -d -p 8080:8080 -p 4848:4848 --name RevelioService revelio/RevelioService 

# System Test

Switch to the "-st" module and perform:

mvn compile failsafe:integration-test
# Build
mvn clean package && docker build -t amz/amazon .

# RUN

docker rm -f amazon || true && docker run -d -p 8080:8080 -p 4848:4848 --name amazon amz/amazon 

# System Test

Switch to the "-st" module and perform:

mvn compile failsafe:integration-test
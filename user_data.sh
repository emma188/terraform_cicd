#!/bin/bash
yum install -y docker || amazon-linux-extras install docker -y || true
systemctl start docker || service docker start || true
usermod -aG docker ec2-user || true
sleep 10
docker run -d -p 8080:8080 emma188/hello_springboot

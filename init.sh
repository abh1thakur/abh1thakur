#!/bin/bash
yum install docker git -y && \
sudo systemctl start docker && \
sudo systemctl enable docker && \
cd /root/ && git clone https://github.com/abh1thakur/abh1thakur.git && \
cd /root/abh1thakur/db && docker build -t db:latest . && docker run -itd -e POSTGRES_PASSWORD=mysecretpassword db:latest && sleep 10 && \
cd /root/abh1thakur/rates && docker build -t app:latest . && docker run -itd -p 3000:3000 app:latest
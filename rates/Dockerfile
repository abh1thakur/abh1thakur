FROM ubuntu:18.04
COPY . /root/rates/
WORKDIR /root/rates
RUN apt-get update && apt-get install -y python3-pip libpq-dev && pip3 install -U gunicorn && pip3 install -Ur requirements.txt

CMD ["gunicorn", "-b", "0.0.0.0:3000", "wsgi"]

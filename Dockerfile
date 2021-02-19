FROM python:3.8-slim-buster
#FROM python:3.8
#FROM python:alpine

# Install dependencies
ENV DEBIAN_FRONTEND=noninteractive

# Final setup & execution
#VOLUME /app
COPY speedtestlat.py /app/speedtestlat.py
WORKDIR /app

COPY requirements.txt /

RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get -q -y install --no-install-recommends apt-utils gnupg1 apt-transport-https dirmngr && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 379CE192D401AB61 && \
    echo "deb https://ookla.bintray.com/debian buster main" | tee  /etc/apt/sources.list.d/speedtest.list && \
    apt-get update && apt-get -q -y install speedtest && \
    apt-get -q -y autoremove && \
    apt-get -q -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    pip3 install -r /requirements.txt 
    
#RUN pip install -r requirements.txt

# Add hello scripts
#ADD sayhello /sayhello
#RUN chmod +x /sayhello

# Add docker-compose-wait tool -------------------
#ENV WAIT_VERSION 2.7.2
#ADD https://github.com/ufoscout/docker-compose-wait/releases/download/$WAIT_VERSION/wait /wait
#RUN chmod +x /wait

#CMD ["/sayhello"]

CMD ["python", "-u", "speedtestlat.py"]
#CMD ["/bin/bash"]

# Version: 0.0.1
FROM alpine:latest
LABEL org.thenuclei.creator="Brian Provenzano" \
      org.thenuclei.email="brian@thenuclei.org"
USER root
RUN apk add --no-cache python3 wget git jq && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install awscli  && \ 
    pip3 install requests
#RUN usermod -s /bin/bash root && bash
RUN echo $PATH
RUN wget https://raw.githubusercontent.com/brian-provenzano/hashicorp-get/master/hashicorp-get.py -O /bin/hashicorp-get.py && chmod +x /bin/hashicorp-get.py
RUN ls -al /bin | grep hashicorp
RUN hashicorp-get.py packer latest /bin/ -y -q 
ADD get-ami.sh /bin/get-ami.sh
RUN chmod +x /bin/get-ami.sh
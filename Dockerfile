FROM debian:latest

MAINTAINER admin@softvisio.net

USER root

ADD https://www.dropbox.com/download?plat=lnx.x86_64 /root/dropbox.tgz

ADD https://www.dropbox.com/download?dl=packages/dropbox.py /usr/local/bin/dropbox

ADD update-dropbox.sh /root/

WORKDIR /root/

RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install python ca-certificates wget \
    && apt-get clean \
    && tar -xzf dropbox.tgz \
    && rm -f dropbox.tgz \
    && chmod +x /usr/local/bin/dropbox \
    && chmod +x update-dropbox.sh

VOLUME ["/root/Dropbox/"]

ENTRYPOINT ["/usr/local/bin/dropbox"]

CMD ["status"]

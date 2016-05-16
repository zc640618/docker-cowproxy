FROM debian:jessie
MAINTAINER Stone <Stone@onlyos.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
		ssh \
        wget \
	&& rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/cyfdecyf/cow/releases/download/0.9.7/cow-linux64-0.9.7.gz -O /cow.gz
RUN gunzip /cow.gz && chmod a+x /cow

ADD docker-initscript.sh /sbin/docker-initscript.sh
RUN chmod 755 /sbin/docker-initscript.sh
EXPOSE 7777/tcp
RUN mkdir /data
VOLUME /data
ENTRYPOINT ["/sbin/docker-initscript.sh"]
CMD ["cow"]

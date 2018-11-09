FROM debian:stretch-slim
RUN apt-get update \
	&& apt-get install -y hitch openssl ca-certificates \
 	&& rm -rf /var/lib/apt/lists/*

EXPOSE 443/tcp

RUN mkdir -p /etc/hitch/certs

RUN mkdir -p /var/lib/hitch/

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

COPY hitch.conf /etc/hitch/hitch.conf

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]

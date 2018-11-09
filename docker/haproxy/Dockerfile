FROM debian:stretch-slim
RUN apt-get update \
	&& apt-get install -y haproxy rsyslog openssl ca-certificates \
 	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/haproxy/certs \
	&& mkdir -p /run/haproxy/ \
	&& touch /var/log/haproxy.log \
	&& ln -sf /dev/stdout /var/log/haproxy.log

COPY haproxy.cfg /etc/haproxy/haproxy.cfg

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 80/tcp
EXPOSE 443/tcp

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
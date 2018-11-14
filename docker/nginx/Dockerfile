FROM debian:stretch-slim
RUN apt-get update \
	&& apt-get install -y nginx openssl ca-certificates \
 	&& rm -rf /var/lib/apt/lists/*

EXPOSE 443/tcp

RUN mkdir -p /etc/nginx/certs

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
&& ln -sf /dev/stderr /var/log/nginx/error.log

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]

COPY default /etc/nginx/sites-enabled/default
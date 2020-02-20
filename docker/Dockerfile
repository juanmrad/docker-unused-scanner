ARG PHP_IMAGE
FROM ${PHP_IMAGE}

COPY . /project
WORKDIR /app

COPY ./docker/entrypoint.sh /usr/local/bin/entrypoint-unused.sh

ENTRYPOINT ["/usr/local/bin/entrypoint-unused.sh"]

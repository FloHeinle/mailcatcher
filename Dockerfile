FROM alpine:latest

ENV SMTP_PORT=1025 HTTP_PORT=1080

ARG MAILCATCHER_VERSION=0.7.1

RUN apk update && apk add --no-cache \
    ca-certificates \
    openssl \
    ruby \
    ruby-bigdecimal \
    ruby-etc \
    ruby-json \
    libstdc++ \
    sqlite-libs

RUN apk add --no-cache --virtual .build-deps \
    ruby-dev \
    make g++ \
    sqlite-dev \
    && gem install mailcatcher --version $MAILCATCHER_VERSION --no-document \
    && apk del .build-deps \
    && rm -rf /var/cache/apk/*

EXPOSE $SMTP_PORT $HTTP_PORT

CMD mailcatcher --foreground --ip=0.0.0.0 --smtp-port=$SMTP_PORT --http-port=$HTTP_PORT

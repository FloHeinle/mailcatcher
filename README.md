# Mailcatcher dockerized

This is an unofficial Dockerfile image for [mailcatcher gem][mailcatcher], based on [Alpine Linux][alpinehubpage].
[Docker Hub][dockerhubpage]

## Usage

### Docker

Get it:

```sh
docker pull floheinle/mailcatcher
```

Run it:

```sh
docker run -d -p 1080:1080 --name mailcatcher floheinle/mailcatcher
```

Link it:

```sh
docker run -d --link mailcatcher -e SMTP_HOST=mailcatcher --name app your/app:latest
```

Then you can send emails from your app and check out the web interface: `http://<your docker host\>:1080/`.

If you want to send emails from your host you can map the 1025 port:

```sh
docker run -d -p 1080:1080 -p 1025:1025 --name mail floheinle/mailcatcher
```

### Docker Compose

```yaml
version: "3.7"

services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
    depends_on:
      - mailcatcher
    environment:
      - SMTP_HOST=mailcatcher
      - SMTP_PORT=1025
    ...

  mailcatcher:
    image: floheinle/mailcatcher
    ports:
      - "1080:1080"
      - "1025:1025"
    environment:
      - HTTP_PORT=1080
      - SMTP_PORT=1025
```

## Build

Just clone this repo and run:

```sh
docker build -t floheinle/mailcatcher .
```

### Inspired by

- https://hub.docker.com/r/thedartsco/mailcatcher

[mailcatcher]: http://mailcatcher.me/ "MailCatcher fake SMTP server with web interface"
[dockerhubpage]: https://hub.docker.com/r/floheinle/mailcatcher/ "Mailcatcher docker hub page"
[alpinehubpage]: https://hub.docker.com/_/alpine/ "A minimal Docker image based on Alpine Linux with a complete package index and only 5 MB in size!"

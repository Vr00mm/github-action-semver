FROM alpine:3.14

RUN apk update && apk add git

COPY LICENSE README.md /
COPY git-semv /usr/local/bin
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

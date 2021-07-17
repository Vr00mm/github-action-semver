FROM alpine:3.14

RUN apk update && apk add git tree && mkdir --parent /github/workspace

COPY LICENSE README.md /
COPY git-semv /usr/local/bin
COPY entrypoint.sh /entrypoint.sh

WORKDIR /github/workspace
ENTRYPOINT ["/entrypoint.sh"]

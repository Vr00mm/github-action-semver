FROM alpine:3.14

RUN apk update && apk add git tree curl && mkdir /github

COPY LICENSE README.md /
COPY entrypoint.sh /entrypoint.sh

RUN curl -sSL --output git-semv.tgz https://github.com/Vr00mm/git-semv/releases/download/v1.1.3/git-semv_linux_x86_64.tar.gz && tar xzvf git-semv.tgz && rm git-semv.tgz && chmod +x git-semv && mv git-semv /usr/local/bin
WORKDIR /github/workspace
ENTRYPOINT ["/entrypoint.sh"]

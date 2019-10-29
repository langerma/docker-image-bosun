FROM alpine

RUN apk --update add rsyslog bash wget
RUN apk --update add --virtual builddeps build-base git go

ENV GOPATH /tmp/bosun
ENV GO111MODULE off

RUN mkdir -p /opt/bosun/bin ${GOPATH}/src/
WORKDIR /tmp/bosun/src
RUN git clone --depth 1 https://github.com/langerma/bosun.git bosun.org
WORKDIR /tmp/bosun/src/bosun.org/cmd/bosun
RUN go get
RUN go build
RUN cp /tmp/bosun/src/bosun.org/cmd/bosun/bosun /opt/bosun/bin/

RUN rm -rf ${GOPATH}
RUN apk del builddeps
RUN apk del build-base
RUN apk del go
RUN rm -rf /var/cache/apk/*

RUN mkdir -p /opt/bin/ /etc/bosun
ADD docker/start_bosun.sh /opt/bin/
ADD docker/bosun.conf /etc/bosun/bosun.conf
ADD docker/bosun.rules /etc/bosun/bosun.rules

ENTRYPOINT ["/opt/bin/start_bosun.sh"]

EXPOSE 8070

VOLUME ["/etc/bosun", "/var/run/bosun"]

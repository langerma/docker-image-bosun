# build bosun binary
FROM golang AS builder

RUN git clone --depth 1 https://github.com/bosun-monitor/bosun.git /bosun

WORKDIR /bosun/cmd/bosun
RUN CGO_ENABLED=0 GOOS=linux go build .
#copy over
FROM alpine:latest

RUN apk --no-cache add ca-certificates
RUN mkdir -p /opt/bosun/bin /opt/bin /etc/bosun
COPY --from=builder /bosun/cmd/bosun/bosun /opt/bosun/bin/
ADD docker/start_bosun.sh /opt/bin/
RUN chmod +x /opt/bin/start_bosun.sh
ADD docker/bosun.conf /etc/bosun/bosun.conf
ADD docker/bosun.rules /etc/bosun/bosun.rules

ENTRYPOINT ["/opt/bin/start_bosun.sh"]

EXPOSE 8070

VOLUME ["/etc/bosun", "/var/run/bosun"]

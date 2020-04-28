# build bosun binary
FROM golang AS builder

RUN git clone --depth 1 https://github.com/langerma/bosun.git /bosun

WORKDIR /bosun/cmd/bosun
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o bosun .
#copy over
FROM alpine:latest

RUN apk --no-cache add ca-certificates
RUN mkdir -p /opt/bosun/bin /opt/bin /etc/bosun
COPY --from=builder /bosun/cmd/bosun/bosun /opt/bosun/bin/
ADD docker/start_bosun.sh /opt/bin/
ADD docker/bosun.conf /etc/bosun/bosun.conf
ADD docker/bosun.rules /etc/bosun/bosun.rules

ENTRYPOINT ["/opt/bin/start_bosun.sh"]

EXPOSE 8070

VOLUME ["/etc/bosun", "/var/run/bosun"]

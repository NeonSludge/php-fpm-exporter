FROM       golang:1-buster as builder

WORKDIR /usr/src/php-fpm-exporter

COPY / /usr/src/php-fpm-exporter/

ENV CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

RUN go build -o php-fpm-exporter -ldflags="-s -w" ./cmd/php-fpm-exporter

FROM scratch
COPY --from=builder /usr/src/php-fpm-exporter/php-fpm-exporter /php-fpm-exporter

ENTRYPOINT [ "/php-fpm-exporter" ]

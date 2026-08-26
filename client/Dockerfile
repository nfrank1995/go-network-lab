From golang:1.26-alpine AS builder
WORKDIR /app

RUN apk add --no-cache ca-certificates && \
	addgroup -g 10001 -S appgroup && \
	adduser -u 10001 -S -G appgroup -H -s /sbin/nologin appuser

COPY certs/root_ca.crt /usr/local/share/ca-certificates/root_ca.crt

RUN update-ca-certificates 

COPY client/main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -o app main.go

FROM scratch
WORKDIR /

COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

COPY --from=builder /app/app /app

USER appuser:appgroup

CMD ["/app"]

From golang:1.26-alpine AS builder
WORKDIR /app

RUN addgroup -g 10001 -S appgroup && \
	adduser -u 10001 -S -G appgroup -H -s /sbin/nologin appuser

COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -o app main.go

FROM scratch
WORKDIR /

COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group


COPY --from=builder /app/app /app

USER appuser:appgroup

CMD ["/app"]

FROM alpine:3.20
RUN apk add --no-cache pgbouncer postgresql16-client
USER postgres
CMD ["pgbouncer", "/etc/pgbouncer/pgbouncer.ini"]

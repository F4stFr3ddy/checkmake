FROM golang:1.13 as builder

WORKDIR /checkmake

COPY . .

RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 make binaries
RUN make test

FROM alpine:3.9
RUN apk add --no-cache make=4.2.1-r2
USER nobody

COPY --from=builder /checkmake /
CMD ["./checkmake", "/Makefile"]

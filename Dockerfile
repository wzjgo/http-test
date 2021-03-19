FROM golang:1.15-alpine AS builder
# RUN apk add --no-cache ca-certificates git

WORKDIR /
COPY go.mod ./
# RUN go mod download
COPY . .
RUN go build -o /server .

FROM alpine AS release
# RUN apk add --no-cache ca-certificates
WORKDIR /app
COPY --from=builder /server ./server
ENTRYPOINT ["/app/server"]


FROM golang:latest
WORKDIR /go/src/github.com/google/huproxy
COPY . .
RUN mkdir /app
# RUN go get -d -v .
ENV CGO_ENABLED=0
ENV GOOS=linux
RUN go build -a -o /app ./cmd/huproxy
RUN go build -a -o /app ./cmd/huproxyclient

FROM alpine:latest
WORKDIR /
COPY --from=0 /app/ .
CMD ["/huproxy"]

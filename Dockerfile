FROM golang:1.11-alpine AS builder
WORKDIR /src/
COPY . .
ENV CGO_ENABLED=0
RUN apk --no-cache add git
RUN go test ./...
RUN go build -o /terraform-docs

FROM alpine/git
COPY --from=builder /terraform-docs /bin/terraform-docs
ENTRYPOINT ["/bin/sh"]

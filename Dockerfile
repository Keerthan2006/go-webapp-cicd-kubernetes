# STAGE 1: BUILD TIME

FROM golang:1.26 AS base

WORKDIR /app

COPY go.mod .

RUN go mod download

COPY . .

RUN go build -o main

# STAGE 2: RUNTIME

FROM gcr.io/distroless/base

WORKDIR /app

COPY --from=base /app/main ./

COPY --from=base /app/static ./static

EXPOSE 8080

CMD ["./main"]
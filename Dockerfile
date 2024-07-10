FROM golang:1.22.4-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download && go mod verify

COPY . .

RUN go build -o /bin/journey ./cmd/journey/journey.go

FROM scratch AS runner

WORKDIR /app

    COPY --from=builder /bin/journey .

EXPOSE 8080

ENTRYPOINT [ "./journey" ]
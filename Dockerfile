# Alpine é um linux enxuto, com poucos recursos, ideal para rodar aplicações em containers.
FROM golang:1.16-alpine AS builder
# Definimos o diretório e copiamos o arquivo main.go para dentro desse diretório.
WORKDIR /go/src/app
COPY main.go .

RUN go mod init fullcycl
# Compilamos o arquivo main.go e geramos um binário chamado main.
RUN go build -o main

# Agora vamos criar uma imagem a partir do zero, ou seja, sem nada.
FROM scratch

# Copiamos o binário main para dentro da imagem.
COPY --from=builder /go/src/app/main /

# Definimos o comando que será executado quando o container for iniciado.
CMD ["/main"]
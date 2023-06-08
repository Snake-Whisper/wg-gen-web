ARG COMMIT="N/A"

FROM golang:alpine AS build-back
WORKDIR /app
ARG COMMIT
COPY . .
RUN go build -o wg-gen-web-linux -ldflags="-X 'github.com/vx3r/wg-gen-web/version.Version=${COMMIT}'" github.com/vx3r/wg-gen-web/cmd/wg-gen-web

FROM node:18.13.0-alpine AS build-front
WORKDIR /app
COPY ui/ ./
RUN npm install
RUN npm run-script build
RUN ls -al /app

FROM alpine
WORKDIR /app
RUN adduser -S wgui
RUN chown -R wgui /app
COPY --from=build-back /app/wg-gen-web-linux .
COPY --from=build-front /app/dist ./ui/dist
COPY .env .
RUN chmod +x ./wg-gen-web-linux
RUN apk add --no-cache ca-certificates
USER wgui
EXPOSE 8080

CMD ["/app/wg-gen-web-linux"]

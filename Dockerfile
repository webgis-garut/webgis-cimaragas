FROM alpine:latest AS builder

WORKDIR /app
COPY . .

RUN rm -f *.py README.md .gitignore || true
RUN rm -rf .git .vscode scratch || true

FROM nginx:alpine AS production

RUN rm -rf /usr/share/nginx/html/*

COPY --from=builder /app /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

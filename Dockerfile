# Use Bun as the build environment
FROM oven/bun:1 as builder

WORKDIR /usr/src/app

COPY package.json bun.lockb* ./

RUN bun install
COPY . .
RUN bun run build

FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=builder /usr/src/app/dist /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]

# Build commands:
# docker buildx build -t ylgdevelop/client.ylg-tradingview:0.7 --platform=linux/amd64,linux/arm64 . --push

# Run command:
# docker run -d -p 8119:8119 --name ylg-tradingview-app ylgdevelop/client.ylg-tradingview:0.7
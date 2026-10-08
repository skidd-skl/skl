# Use an official lightweight Node image
FROM node:18-alpine

# Install standard curl tools
RUN apk add --no-cache curl

# Securely install global pnpm inside the container where permissions are allowed
RUN corepack enable && corepack prepare pnpm@latest --activate

WORKDIR /app

# Copy configuration files and install modules smoothly
COPY package.json pnpm-lock.yaml* ./
RUN pnpm install

# Copy your actual proxy design and code files
COPY . .

# Run the production build command specified by Scramjet
RUN pnpm run build

EXPOSE 4141

CMD ["pnpm", "start"]

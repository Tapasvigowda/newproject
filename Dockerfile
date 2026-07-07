# Stage 1 - Build
FROM node:20-alpine AS builder

WORKDIR /app

# Copy only package files first (for caching)
COPY package*.json ./

RUN npm install

# Copy source code only once
COPY . .

# Stage 2 - Production
FROM node:20-alpine

WORKDIR /app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy only required files (not everything)
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app ./

RUN npm prune --omit=dev

USER appuser

EXPOSE 3000

CMD ["npm", "start"]

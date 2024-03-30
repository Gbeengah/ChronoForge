# Stage 1: Copy frontend assets (no build process)
FROM node:alpine AS frontend-builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . ./

# Stage 2: Build backend
FROM node:alpine AS backend-builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY app.js ./  

# Stage 3: Final image
FROM nginx:alpine
COPY nginx.conf /etc/nginx/nginx.conf

# Copy frontend assets from stage 1
COPY --from=frontend-builder /app/* /usr/share/nginx/html

# Copy backend app from stage 2
COPY --from=backend-builder /app/app.js /app

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]



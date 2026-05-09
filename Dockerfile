# Etapa 1: Build (Construcción)
FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Etapa 2: Producción (Servidor Web)
FROM nginx:alpine
# Copiamos el build a la carpeta que sirve Nginx
COPY --from=build /app/dist /usr/share/nginx/html
# Exponemos el puerto 80 (estándar web)
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
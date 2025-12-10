# Imagen base
FROM node:18

# Directorio de trabajo
WORKDIR /app

# Copiar SOLO package.json
COPY package.json package-lock.json* ./

# Instalar dependencias dentro del contenedor
RUN npm install

# Copiar el resto del proyecto (sin node_modules)
COPY . .

# Exponer puerto
EXPOSE 8080

# Iniciar la aplicación
CMD ["npm", "start"]

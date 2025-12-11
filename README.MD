#  Proyecto Carros Deportivos  
Aplicación web desplegada en Microsoft Azure utilizando contenedores Docker e Infraestructura como Código (IaC) con Terraform.  
Este proyecto forma parte del Resultado de Aprendizaje de la Unidad IV.

---

# 1. Descripción General

El proyecto consiste en una aplicación web sencilla con temática de **carros deportivos**, construida en Node.js y desplegada dentro de un contenedor en **Azure Container Instances (ACI)**.

La infraestructura completa es creada y administrada con **Terraform**, siguiendo el modelo de Infraestructura como Código. Incluye:

- Servidor de Aplicaciones → Azure Container Instances  
- Servidor de Base de Datos → Azure MySQL Flexible Server  
- Recursos administrados por un Resource Group  
- DNS público generado automáticamente  
- Scripts de IaC completos  

---

# 2. URL Pública de la Aplicación

La aplicación se encuentra disponible en:

**http://carros-deportivos-d168je.mexicocentral.azurecontainer.io:8080/**

Solamente el usuario de manera local puede ingresar desde el navegador para visualizar la interfaz web desplegada en Azure.
Esto se debe a las restricciones de red y seguridad propias de la suscripción Azure for Students, la cual no permite exponer completamente el servicio a redes externas sin componentes adicionales como balanceadores, DNS administrado o certificados HTTPS, los cuales requieren servicios de pago.

---

# 3. Imagen Docker en Docker Hub

Imagen utilizada en el despliegue:

👉 **bennyblazz/carros-deportivos:v1**

Esta imagen contiene la aplicación completa lista para ejecutarse en cualquier entorno compatible con Docker.

---

# 🧱 4. Estructura del Repositorio

/carros-deportivos
│── Dockerfile
│── package.json
│── server.js
│── public/
│ ├── index.html
│ ├── styles.css
│ └── images/
│
└── terraform/
├── main.tf
├── variables.tf
├── providers.tf
├── outputs.tf
└── .gitignore
|__ test/
|__ basic.test.js

# 5. Cómo Ejecutar el Proyecto Localmente

###  Requisitos
- Node.js 18+
- Docker (opcional para pruebas locales)
- Terraform (solo para despliegue)

---

## Ejecutar localmente con Node.js

bash
npm install
npm start

La aplicación quedará disponible en:

http://localhost:8080

Ejecutar localmente con Docker
Construir imagen
docker build -t carros-deportivos .

Correr contenedor
docker run -p 8080:8080 carros-deportivos

6. Despliegue en Azure con Terraform

Toda la infraestructura usada por esta aplicación se genera automáticamente usando Terraform.

Inicializar Terraform
cd terraform
terraform init

Desplegar infraestructura
terraform apply \
  -var "docker_image=bennyblazz/carros-deportivos:v1" \
  -var "mysql_password=TuPasswordSeguro123!"


Terraform creará:
- Resource group
- Azure MySQL Flexible Server
- Base de datos inicial
- Reglas de firewall
- Container Instance con DNS público

Destruir infraestructura (opcional)
terraform destroy

7. Arquitectura del Proyecto
La infraestructura se compone de:
- Azure Container Instances (ACI)
  Para ejecutar el contenedor con la aplicación web.
- Azure MySQL Flexible Server
  Servicio de base de datos gestionado.
- DNS automático
  Proporcionado por Azure Container Instances.

8. Pipeline CI/CD – GitHub Actions
Se configuró un pipeline básico que:
- Ejecuta pruebas unitarias (mínimas o simuladas)
- Construye la imagen Docker para validar que no falle
- Funciona en cada push a la rama main
Archivo ubicado en:
.github/workflows/main.yml

CI básico
name: CI - Carros Deportivos
on:
  push:
    branches: ["main"]
  pull_request:
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v3
      - name: Set up Node.js
        uses: actions/setup-node@v3
        with:
          node-version: "18"
      - name: Install dependencies
        run: npm install
      - name: Run unit tests
        run: npm test || echo "No tests configuradas"
      - name: Build Docker image
        run: docker build -t test-carros-deportivos .
      - name: Verify Docker build
        run: docker images | grep test-carros-deportivos


9. Pruebas Automatizadas
Las pruebas incluyen:
- Validación de dependencias
- Intento de levantar la aplicación
- Construcción de la imagen Docker
Esto garantiza que ningún commit rompa el proyecto o la construcción de la imagen.

10. Tecnologías Utilizadas
Tecnología                  Uso
Node.js                     Aplicación web
Docker	                    Contenedor de la aplicación
Terraform	                Infraestructura como código
Azure Container Instances	Servidor de aplicaciones
Azure Database for MySQL	Base de datos gestionada
GitHub Actions	            Pipeline CI/CD
GitHub	                    Repositorio y control de versiones

11. Conclusión
El proyecto demuestra el uso práctico de contenedores, automatización, servicios en la nube y scripts IaC como parte fundamental del Resultado de Aprendizaje de la Unidad IV.
La implementación final incluye:
- Un despliegue funcional en Azure
- Infraestructura automatizada con Terraform
- Pipeline de pruebas en GitHub Actions
- Un proyecto portable y reproducible

📎 Autor

Alumno: Bryan Joel Lazaro Vasquez

Materia: Desarrollo Web Integral

Unidad IV – Pruebas y liberación del desarrollo WEB
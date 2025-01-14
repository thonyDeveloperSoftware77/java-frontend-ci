# Etapa 1: Construcción del JAR usando Maven
FROM maven:3.9.5-eclipse-temurin-17 as builder
WORKDIR /app

# Copia los archivos del proyecto
COPY pom.xml .
COPY src ./src

# Ejecuta Maven para compilar y empaquetar el proyecto (sin pruebas)
RUN mvn clean package -DskipTests

# Etapa 2: Imagen final para ejecutar la app
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Copia el JAR generado en la etapa anterior
COPY --from=builder /app/target/*.jar app.jar

# Expone el puerto 8080 para acceder a la aplicación
EXPOSE 8080

# Comando para ejecutar la aplicación
ENTRYPOINT ["java", "-jar", "app.jar"]

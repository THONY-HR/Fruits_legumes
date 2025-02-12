# Étape 1 : Utiliser une image Java pour compiler avec Ant
FROM openjdk:11 AS build

# Installer Ant
RUN apt-get update && apt-get install -y ant

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers du projet dans l'image
COPY . /app

# Compiler le projet avec Ant
RUN ant clean && ant build

# Étape 2 : Utiliser une image WildFly pour l'exécution
FROM jboss/wildfly:latest

# Copier le fichier WAR compilé depuis l'étape précédente
COPY --from=build /app/dist/mon-projet.war /opt/jboss/wildfly/standalone/deployments/

# Exposer le port WildFly
EXPOSE 8080

# Lancer WildFly avec configuration du port dynamique pour Railway
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0", "-Djboss.http.port=${PORT}"]

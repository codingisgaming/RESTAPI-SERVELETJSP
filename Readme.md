# TPEXAMEN - Gestion des Personnes

## Description du Projet

Une application web Java EE complète pour la gestion des personnes (CRUD). Le projet implémente une architecture MVC avec une API REST JAX-RS et une interface web utilisant des Servlets et JSP. L'application permet de créer, lire, mettre à jour , effectuer des rechercher et supprimer des enregistrements de personnes dans une base de données MySQL.

### Fonctionnalités Principales

-  **CRUD complet** : Création, lecture, mise à jour et suppression de personnes
-  **API REST** : Endpoints RESTful pour toutes les opérations
-  **Interface Web** : Pages JSP pour l'interaction utilisateur
-  **Persistance des données** : Utilisation de JPA/Hibernate avec MySQL
-  **Architecture en couches** : Séparation claire entre API, Services, Modèles et Vues

---

##  Technologies Utilisées

### Backend & Framework
- **Java 8** - Langage de programmation principal
- **Maven** - Gestion des dépendances et build
- **Apache Tomcat** - Serveur d'applications Java EE
- **JAX-RS (Jersey 2.35)** - Framework pour API REST
- **Servlets (javax.servlet-api 4.0.1)** - Gestion des requêtes HTTP

### Persistance des Données
- **JPA (Java Persistence API 2.2)** - Spécification de persistance
- **Hibernate 5.2.6** - Implémentation JPA et ORM
- **MySQL Connector 8.0.33** - Driver JDBC pour MySQL

### Vue & Présentation
- **JSP (JavaServer Pages)** - Pages web dynamiques

---



##  Instructions pour Exécuter le Projet sur Tomcat

1.1. **Démarrer MySQL** sur le port **4500** (ou modifier le port dans `persistence.xml`)

1.2. **Créer la base de données** :
   ```sql
   CREATE DATABASE TPEXAMEN;
   ```

1.3. **Vérifier les identifiants** dans `src/main/java/META-INF/persistence.xml` :
   ```xml
   <property name="javax.persistence.jdbc.url" 
             value="jdbc:mysql://localhost:4500/TPEXAMEN?serverTimezone=UTC" />
   <property name="javax.persistence.jdbc.user" value="root" />
   <property name="javax.persistence.jdbc.password" value="root" />
   ```
2.1. **Importer le projet Maven** dans votre IDE
2.2. **Configurer le serveur Tomcat** dans l'IDE
2.3. **Déployer le projet** sur Tomcat via l'IDE
2.4. **Démarrer le serveur**

### Accès à l'Application

Une fois Tomcat démarré, l'application est accessible aux URLs suivantes :

#### Interface Web (Servlets + JSP)
- **Page d'accueil** : http://localhost:8081/TPEXAMEN/
- **Liste des personnes** : http://localhost:8081/TPEXAMEN/persons

#### API REST (JAX-RS)
- **GET tous les personnes** : http://localhost:8081/TPEXAMEN/api/persons
- **GET personne par ID** : http://localhost:8081/TPEXAMEN/api/persons/{id}
- **POST créer personne** : http://localhost:8081/TPEXAMEN/api/persons
- **PUT modifier personne** : http://localhost:8081/TPEXAMEN/api/persons/{id}
- **DELETE supprimer personne** : http://localhost:8081/TPEXAMEN/api/persons/{id}
--

##  Vidéo de Démonstration

>  **Lien vers la vidéo** : *Bientôt disponible*
> **Lien vers GITHUb  repo** : https://github.com/codingisgaming/RESTAPI-SERVELETJSP

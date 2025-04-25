🚀 Lancement des services

1. **Télécharger le projet et se placer dans le dossier**
2. **Créer le fichier .env à partir de l'exemple fourni :**
cp .env.example .env

3. **Démarrer les services avec Docker Compose**
docker compose up --build -d

4. **Vérifier que les conteneurs sont bien lancés**
docker ps


🧪 Tests de l’API

✔️ Accès au point d’entrée de l’API :
GET http://localhost:8000/users

✔️ Tester dans un navigateur :
http://localhost:8000/users

✔️ Tester avec curl :
curl http://localhost:8000/users

✔️ Tester l’accès à la base via Adminer :
http://localhost:8080


⚠️ Difficultés rencontrées

❌ Accès refusé à MySQL (erreur 1045)
Problème : mot de passe ou utilisateur incorrect, ou variables non injectées.
Solution :
Vérifier les variables dans .env
Vérifier que docker-compose.yml les transmet bien à l’API
Rebuild complet :
docker compose down -v
docker compose up --build -d

❌ using password: NO
Cause : MYSQL_PASSWORD manquant ou mal transmis.
Solution : bien passer toutes les variables d'environnement dans le service api.

❌ Fichier .env mal formaté
Cause : espaces autour du =
Solution : format correct :

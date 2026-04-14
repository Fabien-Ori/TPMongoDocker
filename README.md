# TP MongoDB Docker

## Prerequis
- Docker Desktop installe et demarre

## Build de l'image
Depuis le dossier `TPMongoDocker` :

```powershell
docker build -t faori/mongo-blog:1.0.0 .
```

## Lancer le conteneur

```powershell
docker run -d --name mon-blog-mongo -e MONGO_INITDB_ROOT_USERNAME=admin -e MONGO_INITDB_ROOT_PASSWORD=password123 faori/mongo-blog:1.0.0
```

## Lancer le script de verification

### Depuis Git Bash
```bash
./check-status.sh

ou

./check-status.sh --show-table
pour afficher le contenu de la db.
```

## Commandes utiles

```powershell
docker ps
docker logs mon-blog-mongo
docker exec mon-blog-mongo mongosh --authenticationDatabase admin -u admin -p password123 blog_db --eval "db.posts.find()"
docker rm -f mon-blog-mongo

```

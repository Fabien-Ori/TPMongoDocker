#!/bin/bash
CONTAINER_NAME="mon-blog-mongo"
SHOW_TABLE="$1"
USER_NAME=$(docker exec $CONTAINER_NAME whoami)
if [ "$USER_NAME" != "root" ]; then
    echo "OK l'utilisateur : $USER_NAME (Non-privilégié)"
else
    echo "Erreur, Le processus tourne en ROOT !"
    exit 1
fi

MONGO_USER=$(docker exec "$CONTAINER_NAME" printenv MONGO_INITDB_ROOT_USERNAME)
MONGO_PASSWORD=$(docker exec "$CONTAINER_NAME" printenv MONGO_INITDB_ROOT_PASSWORD)

DB_CHECK=$(docker exec "$CONTAINER_NAME" mongosh --quiet --authenticationDatabase admin -u "$MONGO_USER" -p "$MONGO_PASSWORD" --eval "db.getSiblingDB('blog_db').posts.countDocuments()")

if [[ "$DB_CHECK" =~ ^[0-9]+$ ]] && [ "$DB_CHECK" -ge 5 ]; then
    echo "OK la base de données blog_db est accessible. Articles trouvés : $DB_CHECK"
else
    echo "Erreur, impossible d'accéder aux données ou collection vide."
    exit 1
fi

if [ "$SHOW_TABLE" = "--show-table" ]; then
    echo "Contenu de blog_db.posts :"
    docker exec "$CONTAINER_NAME" mongosh --quiet --authenticationDatabase admin -u "$MONGO_USER" -p "$MONGO_PASSWORD" --eval "const docs = db.getSiblingDB('blog_db').posts.find({}, {_id:0}).toArray(); console.table(docs);"
fi

echo "TEST Complet"

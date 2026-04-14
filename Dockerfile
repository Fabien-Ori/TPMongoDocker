FROM mongodb/mongodb-community-server:7.0-ubi8

LABEL maintainer="YNOV B2 INFO CYBER"

ENV MONGO_INITDB_DATABASE=blog_db

COPY init-db.js /docker-entrypoint-initdb.d/

USER mongod

EXPOSE 27017
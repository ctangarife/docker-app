#!/bin/sh
echo "====================================="
echo "Hola, bienvenido a Brief"
echo "=====================================" pwd
set -ea

_stopStrapi() {
  echo "Stopping strapi"
  kill -SIGINT "$strapiPID"
  wait "$strapiPID"
}

trap _stopStrapi SIGTERM SIGINT

cd /usr/src/api

npm install -g strapi@beta


APP_NAME=${APP_NAME:brief-app}
DATABASE_CLIENT=${DATABASE_CLIENT:postgres}
DATABASE_USERNAME='postgres'
DATABASE_HOST=${DATABASE_HOST:localhost}
DATABASE_PORT="5432"
DATABASE_NAME=${DATABASE_NAME:brief_db}
DATABASE_PASSWORD="1nt3r4ct1v3"

if [ ! -f "$APP_NAME/package.json" ]
then
    strapi new ${APP_NAME} --dbclient=$DATABASE_CLIENT --dbhost=$DATABASE_HOST --dbport=$DATABASE_PORT --dbname=$DATABASE_NAME --dbusername=$DATABASE_USERNAME --dbpassword=$DATABASE_PASSWORD
elif [ ! -d "$APP_NAME/node_modules" ]
then
    echo "====================================="
    echo "Hola, Llego aca"
    echo "====================================="
    npm install --prefix $APP_NAME
fi

cd $APP_NAME 

strapi develop &

strapiPID=$!
wait "$strapiPID"
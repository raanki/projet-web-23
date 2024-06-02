# Vue 🖥️

Tutoriel pour run le projet.

## Configuration du projet 🛠️

Vous devez cloner l'API et la lancer sur un serveur :
```sh
git clone git@github.com:raanki/api-projet-web.git
```


Lancez l'API en créant un fichier env.local avec les informations suivantes :


```sh
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=projet_web
DB_USERNAME=root
DB_PASSWORD=user
```

Ensuite, dans Vue, allez dans le fichier src/env.js et configurez le chemin jusqu'au projet :

```sh
const API_URL = 'http://localhost/api-projet-web/';
```

## Installer les dépendances 📦

```
yarn install
```


## Compiler et recharger à chaud pour le développement 🔄

```sh
yarn
```

```sh
yarn dev
```

## Vérification de type, compilation et minification pour la production 🏗️

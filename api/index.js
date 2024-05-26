const express = require("express");
const MongoClient = require("mongodb").MongoClient;
const cors = require("cors");
const multer = require("multer");

const app = express();
app.use(cors());
app.use(express.json());

const CONNECTION_STRING = "mongodb+srv://yessicerlyn:yWzjvBu8fflBHgsC@projetweb.xgwxztb.mongodb.net/?retryWrites=true&w=majority&appName=projetweb";
const DATABASENAME = "projetWeb";
let database;

app.listen(5038, () => {
    console.log("Serveur démarré sur le port 5038");
    MongoClient.connect(CONNECTION_STRING, { useNewUrlParser: true, useUnifiedTopology: true })
        .then(client => {
            database = client.db(DATABASENAME);
            console.log("Connexion à ta grand mère mongo réussi !");
        })
        .catch(error => {
            console.error("Erreur de connexion à MongoDB :", error);
        });
});

app.

db = db.getSiblingDB('blog_db');

db.createCollection("posts", {
   validator: {
      $jsonSchema: {
         bsonType: "object",
         required: [ "titre", "auteur", "vues" ],
         properties: {
            titre: {
               bsonType: "string",
               description: "doit être une chaîne de caractères"
            },
            auteur: {
               bsonType: "string",
               description: "doit être une chaîne de caractères"
            },
            vues: {
               bsonType: "int",
               description: "doit être un entier"
            }
         }
      }
   }
});

db.posts.insertMany([
    { titre: "Livre1", auteur: "Auteur1", vues: NumberInt(120) },
    { titre: "Livre2", auteur: "Auteur2", vues: NumberInt(450) },
    { titre: "Livre3", auteur: "Auteur3", vues: NumberInt(85) },
    { titre: "Livre4", auteur: "Auteur4", vues: NumberInt(300) },
    { titre: "Livre5", auteur: "Auteur5", vues: NumberInt(15) }
]);
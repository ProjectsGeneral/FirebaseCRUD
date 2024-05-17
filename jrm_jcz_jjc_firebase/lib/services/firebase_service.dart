import 'package:cloud_firestore/cloud_firestore.dart';
/* import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart'; */

// instancia de bd
FirebaseFirestore db = FirebaseFirestore.instance;

// ========================================================== METODOS PARA USUARIOS =======
// FUNCION PARA OBTENER DATOS DE NUESTRA FIREBASE FIRESTORE
// Future es una promesa practicamente
// Future<TipoDatoDevolver> nombreMetodo() async{....}
Future<List> getPeople() async {
  List people = [];
  // el db.collection('nombre de coleccion en tu bd');
  /* CollectionReference collectionReferencePeople = db.collection('usuarios'); */

  // retorna toda la lista de la coleccion
  QuerySnapshot queryPeople = await db.collection('usuarios').get();
  // iteramos los documentos, cada vez que se haga una iteracion sera un documento diferente
  /* queryPeople.docs.forEach((documento) {
    // añadimos con people.add la informacion que contiene el documento
    people.add(documento.data());
  }); */
  for (var doc in queryPeople.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String,
        dynamic>; // la informacion de doc en query devuelve ahora un mapa
    final person = {
      "name": data['name'],
      "uid": doc.id,
    };
    people.add(person);
  }

  await Future.delayed(const Duration(seconds: 1));

  return people;
}

// Metodo para crear usuarios
Future<void> addPeople(String name) async {
  await db.collection("usuarios").add({"name": name});
}
// Metodo actualizar usuarios

Future<void> updatePeople(String uid, String newname) async {
  try {
    await db.collection("usuarios").doc(uid).set({"name": newname});
  } catch (e) {
    throw Exception(e);
  }
}

// Metodo para eliminar usuarios
Future<void> deletePeople(String uid) async {
  try {
    await db.collection("usuarios").doc(uid).delete();
  } catch (e) {
    throw Exception(e);
  }
}


/// METODO PARA CATEGORIAS



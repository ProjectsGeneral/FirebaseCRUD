import 'package:cloud_firestore/cloud_firestore.dart';
/* import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart'; */

// instancia de bd
FirebaseFirestore db = FirebaseFirestore.instance;

///***************************************************************** METODOS PARA USUARIOS */
// FUNCION PARA OBTENER DATOS DE NUESTRA FIREBASE FIRESTORE
// Future es una promesa practicamente
// Future<TipoDatoDevolver>
Future<List> getPeople() async {
  List people = [];
  // el db.collection('nombre de coleccion en tu bd');
  CollectionReference collectionReferencePeople = db.collection('usuarios');

  // retorna toda la lista de la coleccion
  QuerySnapshot queryPeople = await collectionReferencePeople.get();
  // iteramos los documentos, cada vez que se haga una iteracion sera un documento diferente
  queryPeople.docs.forEach((documento) {
    // añadimos con people.add la informacion que contiene el documento
    people.add(documento.data());
  });

  await Future.delayed(const Duration(seconds: 5));

  return people;
}

/// METODO PARA CATEGORIAS



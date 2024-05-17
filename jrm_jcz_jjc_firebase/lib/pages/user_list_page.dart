// Importaciones firebase
import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// material APP
import 'package:flutter/material.dart';
// Servicios
import 'package:jrm_jcz_jjc_firebase/services/firebase_service.dart';

class UserListPage extends StatefulWidget {
  /* const UserListPage({Key? key}) : super(key: key); */
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de usuarios'),
      ),
      body: FutureBuilder(
          future: getPeople(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data
                    ?.length, // contamos elementos, condicionando con la existencia de data
                itemBuilder: (context, index) {
                  return Text(snapshot.data?[index][
                      'name']); // de snapshot recorremos.data con el index actual del 0 a n, se recupera el dato
                },
              );
            } else {
              // envia un circulo de carga
              return const Center(
                child: /* CircularProgressIndicator(), */ Text(
                  "Cargando...",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            /* return const Text(""); */
          })),
    );
  }
}

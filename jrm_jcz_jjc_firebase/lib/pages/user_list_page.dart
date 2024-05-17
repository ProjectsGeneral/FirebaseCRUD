// Importaciones firebase
/* import 'dart:ffi'; */

/* import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; */
// material APP

import 'package:flutter/material.dart';
import 'package:jrm_jcz_jjc_firebase/pages/user_edit_page.dart';
// Servicios
import 'package:jrm_jcz_jjc_firebase/services/firebase_service.dart';

import 'user_create_page.dart';

class UserListPage extends StatefulWidget {
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
                  return Dismissible(
                    onDismissed: (direction) async {
                      await deletePeople(snapshot.data?[index]['uid']);
                      snapshot.data?.removeAt(index);
                    },

                    confirmDismiss: (direction) async {
                      bool result = false;
                      // Almacenamos un resultado en una variable BOOL result, llamamos un showDialog y damos a elegir
                      result = await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                  "¿Estas seguro de querer eliminar a ${snapshot.data?[index]['name']} ?"),
                              actions: [
                                TextButton(
                                    // Caso  de cancelar
                                    onPressed: () {
                                      return Navigator.pop(
                                        context,
                                        false,
                                      );
                                    },
                                    child: const Text(
                                      "Cancelar",
                                      style: TextStyle(color: Colors.red),
                                    )),
                                TextButton(
                                    // caso de aceptar
                                    onPressed: () {
                                      return Navigator.pop(
                                        context,
                                        true,
                                      );
                                    },
                                    child: const Text("Si, estoy seguro"))
                              ],
                            );
                          });
                      return result;
                    },
                    background: Container(
                      color: Colors.red,
                      child: const Icon(Icons.delete),
                    ),
                    //Dismissible  Eliminar al mover con el dedo, no borra en la bd, solo borra en ejecucion.
                    direction: DismissDirection
                        .endToStart, // DIRECTION permite solo darle una direccion al deslizar el dedo
                    key: Key(snapshot.data?[index]['uid']),
                    child: ListTile(
                      // USAMOS LISTTILE para separar el listado y añadirle funcionalidad a cada ROW | title:OnTap
                      // Se le añade funcionalidad al darle click, esto se maneja en onTap
                      /* onLongPress: () => print("borrar"), */ // Imprime al mantener presionado

                      title: Text(snapshot.data?[index]['name']),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditAddName(),
                              settings: RouteSettings(
                                arguments: {
                                  "name": snapshot.data?[index]['name'],
                                  "uid": snapshot.data?[index]['uid'],
                                },
                              )),
                        );
                        setState(() {});
                      },
                    ),
                  ); // de snapshot recorremos.data con el index actual del 0 a n, se recupera el dato
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
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // Usando los asyncs hacemos esperar a que el proceso de guardado termine
            /* Navigator.pushNamed(context, '/add'); */
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddName()),
            );
            setState(() {});
            print(
                "Estoy en la vista lista"); // ACA recien imprime cuando se guarda y vuelve a la vista LISTAR
          },
          child: const Icon(Icons.add)),
    );
  }
}

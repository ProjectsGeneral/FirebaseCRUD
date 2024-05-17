import 'package:flutter/material.dart';
import 'package:jrm_jcz_jjc_firebase/pages/proveedor_edit_page.dart';

import '../services/firebase_service.dart';
import 'proveedor_create_page.dart';
import 'proveedor_edit_page.dart';

class Proveedor extends StatefulWidget {
  const Proveedor({super.key});

  @override
  State<Proveedor> createState() => _ProveedorState();
}

class _ProveedorState extends State<Proveedor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proveedor'),
      ),
      body: FutureBuilder(
        future: getProveedor(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  onDismissed: (direction) async {
                    await deleteProveedor(snapshot.data?[index]['uid']);
                    snapshot.data?.removeAt(index);
                  },
                  confirmDismiss: (direction) async {
                    bool result = false;

                    result = await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                                "Estas seguro de eliminar la Proveedor ${snapshot.data?[index]['nombre']}"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    return Navigator.pop(context, false);
                                  },
                                  child: const Text("Cancelar")
                              ),
                              TextButton(
                                  onPressed: () {
                                    return Navigator.pop(context, true);
                                  },
                                  child: const Text("Si")
                              )
                            ],
                          );
                        });

                    return result;
                  },
                  background: Container(
                    color: Colors.red,
                    child: const Icon(Icons.delete),
                  ),
                  direction: DismissDirection.endToStart,
                  key: Key(snapshot.data?[index]['uid']),
                  child: ListTile(
                    title: Text(snapshot.data?[index]['nombre']),
                    onTap: (() async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProveedor(
                            arguments: ArgumentEdit(
                                nombre: snapshot.data?[index]['nombre'],
                                uid: snapshot.data?[index]['uid'] ?? ''),
                          ),
                        ),
                      );
                      setState(() {});
                    }),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text("Cargando..."),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProveedor()),
          );
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

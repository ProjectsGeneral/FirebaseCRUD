import 'package:flutter/material.dart';

import '../services/firebase_service.dart';
import 'product_create_page.dart';
import 'product_edit_page.dart';

class Categorias extends StatefulWidget {
  const Categorias({super.key});

  @override
  State<Categorias> createState() => _CategoriasState();
}

class _CategoriasState extends State<Categorias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorías'),
      ),
      body: FutureBuilder(
        future: getcategorias(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  onDismissed: (direction) async {
                    await deleteCategorias(snapshot.data?[index]['uid']);
                    snapshot.data?.removeAt(index);
                  },
                  confirmDismiss: (direction) async {
                    bool result = false;

                    result = await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                                "Estas seguro de eliminar la Categoria ${snapshot.data?[index]['nombre']}"),
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
                          builder: (context) => EditCategorias(
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
            MaterialPageRoute(builder: (context) => AddCategorias()),
          );
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

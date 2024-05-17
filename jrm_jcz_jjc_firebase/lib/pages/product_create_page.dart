import 'package:flutter/material.dart';

import '../services/firebase_service.dart';

class AddCategorias extends StatefulWidget {
  const AddCategorias({super.key});

  @override
  State<AddCategorias> createState() => _AddCategoriasState();
}

class _AddCategoriasState extends State<AddCategorias> {

  TextEditingController nameController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Categorías'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Ingrese el nombre',
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  await addCategorias(nameController.text).then((_) {
                    Navigator.pop(context);
                  });
                },
                child: const Text("Guardar"))
          ],
        ),
      ),
    );
  }
}

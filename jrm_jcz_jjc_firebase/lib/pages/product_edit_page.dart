import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

class ArgumentEdit {
  final String nombre;
  final String uid; // Agregamos el UID aquí

  ArgumentEdit(
      {required this.nombre,
      required this.uid}); // Asegúrate de incluir el UID aquí
}

class EditCategorias extends StatefulWidget {
  final ArgumentEdit arguments;

  const EditCategorias({Key? key, required this.arguments}) : super(key: key);

  @override
  State<EditCategorias> createState() => _EditCategoriasState();
}

class _EditCategoriasState extends State<EditCategorias> {
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text: widget.arguments.nombre,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Categorías'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Ingrese el nuevo nombre',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await updateCategorias(
                        widget.arguments.uid, nameController.text)
                    .then((_) {
                  Navigator.pop(context);
                });
              },
              child: const Text("Actualizar"),
            )
          ],
        ),
      ),
    );
  }
}

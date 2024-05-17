import 'package:flutter/material.dart';

import '../services/firebase_service.dart';

class AddProveedor extends StatefulWidget {
  const AddProveedor({super.key});

  @override
  State<AddProveedor> createState() => _AddProveedorState();
}

class _AddProveedorState extends State<AddProveedor> {

  TextEditingController nameController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Proveedor'),
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
                  await addProveedor(nameController.text).then((_) {
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

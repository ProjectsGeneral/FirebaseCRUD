import 'package:flutter/material.dart';
import 'package:jrm_jcz_jjc_firebase/services/firebase_service.dart';

class AddName extends StatefulWidget {
  const AddName({super.key});

  @override
  State<AddName> createState() => _AddNameState();
}

class _AddNameState extends State<AddName> {
  TextEditingController nameController = TextEditingController(
      text: ""); // Creamos un controlador de editor de texto
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Name'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller:
                  nameController, // Asignamos el controlador creado para que nuestro "Controller" almacene ese valor
              decoration: const InputDecoration(
                hintText: 'Ingrese el nuevo nombre',
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  await addPeople(nameController.text).then((_) {
                    // Podemos añadir ".then((_){ funcion a ejecutar}) si usas await"
                    Navigator.pop(
                        context); // Cierra la pantalla actual, nos regresa a la anterior
                  });
                  /* print(nameController
                      .text); */ // probamos que se guarde el contenido con un print en consola.
                },
                child: const Text('Guardar'))
          ],
        ),
      ),
    );
  }
}

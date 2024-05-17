import 'package:flutter/material.dart';
import 'package:jrm_jcz_jjc_firebase/services/firebase_service.dart';

class EditAddName extends StatefulWidget {
  const EditAddName({super.key});

  @override
  State<EditAddName> createState() => _EditAddNameState();
}

class _EditAddNameState extends State<EditAddName> {
  TextEditingController nameController = TextEditingController(
      text: ""); // Creamos un controlador de editor de texto
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String,
        dynamic>?; // al usarse MaterialPageRoute se usa esta forma para recuperar el agumento mediante settings
    final uid = arguments?['uid'];
    // Caso contrario seria asi: final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    //
    nameController.text = arguments?['name'];
    // en el caso que sea usando rutas y lueg oarguments es asi:: nameController.text = arguments['name'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Name'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller:
                  nameController, // Asignamos el controlador creado para que nuestro "Controller" almacene ese valor
              decoration: const InputDecoration(
                hintText: 'Ingrese modificacion',
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (uid != null) {
                    await updatePeople(uid, nameController.text).then((_) {
                      // Podemos añadir ".then((_){ funcion a ejecutar}) si usas await"
                      Navigator.pop(
                          context); // Cierra la pantalla actual, nos regresa a la anterior
                    });
                    ;
                    // Aquí puedes realizar cualquier operación con el UID
                  }
                },
                child: const Text('Actualizar'))
          ],
        ),
      ),
    );
  }
}

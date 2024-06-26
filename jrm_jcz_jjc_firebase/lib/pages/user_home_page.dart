/* import 'package:firebase_core/firebase_core.dart'; */
import 'package:flutter/material.dart';
/* import 'package:firebase_auth/firebase_auth.dart'; */
import 'package:jrm_jcz_jjc_firebase/pages/user_create_page.dart';

import 'user_list_page.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu de usuario'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserListPage()),
                );
              },
              child: const Text('Ver usuarios'),
            ),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddName()),
                );
              },
              child: const Text('Crear usuario'),
            ),
          ],
        ),
      ),
    );
  }
}

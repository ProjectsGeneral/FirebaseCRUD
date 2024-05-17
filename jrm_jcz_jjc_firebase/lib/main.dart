import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'pages/product_list_page.dart';
import 'pages/user_home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Authentication Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  Future<bool> _signInWithEmailAndPassword() async {
    try {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      // Autenticar con correo electrónico y contraseña utilizando Firebase Auth
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Devolver true para indicar que el inicio de sesión fue exitoso
      return true;
    } catch (e) {
      // Si hay un error durante la autenticación, mostrar un mensaje de error
      setState(() {
        _errorMessage =
            'Error al iniciar sesión. Por favor, verifica tus credenciales.';
      });

      // Devolver false para indicar que el inicio de sesión falló
      return false;
    }
  }

  void _handleLogin() async {
    bool success = await _signInWithEmailAndPassword();
    if (success) {
      // Obtener el correo electrónico del usuario autenticado
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final String email = user.email ?? '';

        // Verificar el correo electrónico e implementar la lógica de redirección
        if (email == 'jhonnycrud@gmail.com') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserHomePage()),
          );
        } else if (email == 'josue@gmail.com') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Categorias()),
          );
        } else if (email == 'jose@gmail.com') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Placeholder()),
          );
        } else {
          // Manejar otros casos o redirigir a una página predeterminada
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Placeholder()),
          );
        }
      }
    } else {
      print('Fallo en el inicio de sesión');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _handleLogin,
              child: const Text('Iniciar Sesión'),
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

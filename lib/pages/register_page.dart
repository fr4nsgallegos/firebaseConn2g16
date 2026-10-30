import 'package:firebaseconn2g16/services/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registro")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              TextField(
                controller: _email,
                decoration: InputDecoration(labelText: "Correo"),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _password,
                decoration: InputDecoration(labelText: "Contraseña"),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () async {
                  await AuthService.registerWithEmailPassword(
                    _email.text,
                    _password.text,
                  );
                },
                child: Text("Registrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

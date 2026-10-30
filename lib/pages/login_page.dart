import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
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
            ],
          ),
        ),
      ),
    );
  }
}

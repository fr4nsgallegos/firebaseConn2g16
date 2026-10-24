import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StreamPage extends StatelessWidget {
  const StreamPage({super.key});

  Stream<int> generarNumeros() async* {
    for (int i = 0; i < 5; i++) {
      await Future.delayed(Duration(seconds: 2));
      yield i;
    }
  }

  Stream<String> generarMensajes() async* {
    yield "Hola";
    await Future.delayed(Duration(seconds: 2));

    yield "Binvenidos";
    await Future.delayed(Duration(seconds: 2));

    yield "Estamos aprendiendo streams";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stream Page")),
      body: Center(
        child: Column(
          mainAxisSize: .min,
          children: [
            ElevatedButton(
              onPressed: () async {
                print("Iiniciando Steam....");
                await for (final numero in generarNumeros()) {
                  print("Número recibido: $numero");
                }
                print("Stream finalizado");
              },
              child: Text("Iniciar stream generarNumeros"),
            ),
            ElevatedButton(
              onPressed: () async {
                generarMensajes().listen(
                  (mensaje) {
                    print("recibido: $mensaje");
                  },
                  onError: (error) {
                    print("Huibo un error: $error");
                  },
                  onDone: () {
                    print("No llegarán más mensajes");
                  },
                );
              },
              child: Text("Iniciar stream generarMensajes"),
            ),
          ],
        ),
      ),
    );
  }
}

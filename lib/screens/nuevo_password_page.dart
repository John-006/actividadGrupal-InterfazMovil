import 'package:flutter/material.dart';

class NuevoPasswordPage extends StatelessWidget {
  const NuevoPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo Password')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(decoration: const InputDecoration(labelText: 'Nueva contraseña'), obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: const Text('Actualizar')),
          ],
        ),
      ),
    );
  }
}

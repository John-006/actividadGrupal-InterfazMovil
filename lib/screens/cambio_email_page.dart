import 'package:flutter/material.dart';

class CambioEmailPage extends StatelessWidget {
  const CambioEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cambiar Email')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(decoration: const InputDecoration(labelText: 'Nuevo email')),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: const Text('Actualizar')),
          ],
        ),
      ),
    );
  }
}

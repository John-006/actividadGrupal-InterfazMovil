import 'package:flutter/material.dart';

class MedioPagoPage extends StatelessWidget {
  const MedioPagoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Medio de Pago')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(decoration: const InputDecoration(labelText: 'Número de tarjeta')),
            TextField(decoration: const InputDecoration(labelText: 'MM/YY')),
            TextField(decoration: const InputDecoration(labelText: 'CVV')),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: const Text('Guardar')),
          ],
        ),
      ),
    );
  }
}

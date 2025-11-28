import 'package:flutter/material.dart';

class DetallePagoPage extends StatelessWidget {
  const DetallePagoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de Pago')),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Text('Información detallada del pago...'),
      ),
    );
  }
}

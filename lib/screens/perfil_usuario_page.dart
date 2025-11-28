import 'package:flutter/material.dart';

class PerfilUsuarioPage extends StatelessWidget {
  const PerfilUsuarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil de Usuario')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Nombre: Esteban', style: TextStyle(fontSize: 18)),
            Text('Email: ejemplo@correo.com', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

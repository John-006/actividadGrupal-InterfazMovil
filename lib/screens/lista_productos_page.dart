import 'package:flutter/material.dart';

class ListaProductosPage extends StatelessWidget {
  const ListaProductosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Libros disponibles')),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (_, i) => ListTile(
          title: Text('Libro ${i + 1}'),
          subtitle: const Text('Descripción del libro...'),
        ),
      ),
    );
  }
}

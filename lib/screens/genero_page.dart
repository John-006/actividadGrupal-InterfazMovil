import 'package:flutter/material.dart';

class GeneroPage extends StatelessWidget {
  const GeneroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Género de libros')),
      body: ListView(
        children: const [
          ListTile(title: Text('Aventura')),
          ListTile(title: Text('Ficción')),
          ListTile(title: Text('Romance')),
          ListTile(title: Text('Terror')),
        ],
      ),
    );
  }
}

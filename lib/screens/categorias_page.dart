import 'package:flutter/material.dart';

class CategoriasPage extends StatelessWidget {
  const CategoriasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categorías')),
      body: GridView.count(
        crossAxisCount: 2,
        children: const [
          Card(child: Center(child: Text('Drama'))),
          Card(child: Center(child: Text('Infantil'))),
          Card(child: Center(child: Text('Ciencia'))),
          Card(child: Center(child: Text('Tecnología'))),
        ],
      ),
    );
  }
}

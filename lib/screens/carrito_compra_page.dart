import 'package:flutter/material.dart';

class CarritoCompraPage extends StatelessWidget {
  const CarritoCompraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Carrito de compra')),
      body: ListView(
        children: const [
          ListTile(title: Text('Libro A'), trailing: Text('x1')),
          ListTile(title: Text('Libro B'), trailing: Text('x2')),
        ],
      ),
    );
  }
}

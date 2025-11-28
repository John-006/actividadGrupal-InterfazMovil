import 'package:flutter/material.dart';

class OrdenCompraPage extends StatelessWidget {
  const OrdenCompraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Orden de Compra')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          ListTile(title: Text('Libro A'), trailing: Text('\$25.000')),
          ListTile(title: Text('Libro B'), trailing: Text('\$40.000')),
          Divider(),
          Text('Total: \$65.000', style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}

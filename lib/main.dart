import 'package:flutter/material.dart';
import 'package:app/screens/screens.dart';

void main() {
  runApp(const BibliotecaApp());
}

class BibliotecaApp extends StatelessWidget {
  const BibliotecaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Biblioteca App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      {'nombre': 'Registro de Usuario', 'page': const RegistroUsuarioPage()},
      {'nombre': 'Inicio de Sesión', 'page': const LoginPage()},
      {'nombre': 'Perfil de Usuario', 'page': const PerfilUsuarioPage()},
      {'nombre': 'Medio de Pago', 'page': const MedioPagoPage()},
      {'nombre': 'Orden de Compra', 'page': const OrdenCompraPage()},
      {'nombre': 'Géneros', 'page': const GeneroPage()},
      {'nombre': 'Lista de Productos', 'page': const ListaProductosPage()},
      {'nombre': 'Categorías', 'page': const CategoriasPage()},
      {'nombre': 'Cambio de Email', 'page': const CambioEmailPage()},
      {'nombre': 'Confirmación', 'page': const ConfirmacionPage()},
      {'nombre': 'Nuevo Password', 'page': const NuevoPasswordPage()},
      {'nombre': 'Carrito de Compra', 'page': const CarritoCompraPage()},
      {'nombre': 'Detalle de Pago', 'page': const DetallePagoPage()},
      {'nombre': 'Detalle de Producto', 'page': const DetalleProductoPage()},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Biblioteca - Menú Principal'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: pages.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.arrow_forward_ios),
            title: Text(pages[index]['nombre'] as String),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => pages[index]['page'] as Widget,
                ),
              );
            },
          );
        },
),
);
}
}
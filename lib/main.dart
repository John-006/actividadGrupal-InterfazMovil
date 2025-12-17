import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:app/screens/screens.dart';
// EDITADO FELIPE
// Getter para acceder al cliente de Supabase fácilmente
final supabase = Supabase.instance.client;

Future<void> main() async {
  // Asegura que los bindings de Flutter estén inicializados
  WidgetsFlutterBinding.ensureInitialized();
  
  // 1. Carga el archivo .env
  await dotenv.load(fileName: ".env");

  // 2. Inicializa Supabase usando las variables cargadas
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

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
      {'nombre': 'Detalle de Producto', 'page': const DetalleProductoPage(libro: {
        'id': 1,
        'titulo': 'Libro de prueba',
        'precio': 20000,
        'autor': 'Autor prueba'
      })},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Biblioteca - Menú Principal'),
        backgroundColor: const Color.fromARGB(255, 144, 65, 255),
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
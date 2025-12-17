import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app_theme.dart';
import 'agregar_libro_screen.dart';
import 'editar_libro_screen.dart';
import 'detalle_producto_screen.dart'; // 👈 IMPORTANTE para la compra

final supabase = Supabase.instance.client;

class ListaProductosPage extends StatefulWidget {
  const ListaProductosPage({super.key});

  @override
  State<ListaProductosPage> createState() => _ListaProductosPageState();
}

class _ListaProductosPageState extends State<ListaProductosPage> {
  Key _listKey = UniqueKey();

  Future<List<Map<String, dynamic>>> _getLibros() async {
    final response = await supabase
        .from('libros')
        .select()
        .order('created_at');
    return List<Map<String, dynamic>>.from(response);
  }

  void _refrescarLista() {
    setState(() {
      _listKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Libros disponibles', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AgregarLibroScreen()),
              );
              if (result == true) _refrescarLista();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Buscador (UI)
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar libros...',
                prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                filled: true,
                fillColor: AppColors.background,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              ),
            ),
          ),
          // Lista de Libros
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              key: _listKey,
              future: _getLibros(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No hay libros disponibles'));
                }

                final libros = snapshot.data!;

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: libros.length,
                  itemBuilder: (context, index) {
                    final libro = libros[index];

                    return GestureDetector(
                      // 🛒 AL TOCAR EL LIBRO VA AL DETALLE PARA COMPRAR
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetalleProductoPage(libro: libro),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  libro['imagen_url'] ?? '',
                                  width: 80, height: 110, fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => const Icon(Icons.book, size: 40),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(libro['titulo'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                    Text(libro['autor'], style: const TextStyle(color: Colors.grey)),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('\$${libro['precio']}', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 18)),
                                        Row(
                                          children: [
                                            // ✏️ EDITAR
                                            IconButton(
                                              icon: const Icon(Icons.edit, color: AppColors.primary),
                                              onPressed: () async {
                                                final res = await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (_) => EditarLibroScreen(libro: libro)),
                                                );
                                                if (res == true) _refrescarLista();
                                              },
                                            ),
                                            // 🗑️ ELIMINAR
                                            IconButton(
                                              icon: const Icon(Icons.delete, color: Colors.red),
                                              onPressed: () async {
                                                await supabase.from('libros').delete().eq('id', libro['id']);
                                                _refrescarLista();
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
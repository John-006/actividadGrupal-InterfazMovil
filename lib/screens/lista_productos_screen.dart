// screens/lista_productos_screen.dart (CORREGIDO Y CON NAVEGACIÓN A EDITAR)

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app_theme.dart';
import 'agregar_libro_screen.dart';
import 'editar_libro_screen.dart'; // 👈 ¡NUEVA IMPORTACIÓN!

final supabase = Supabase.instance.client;

class ListaProductosPage extends StatefulWidget {
  const ListaProductosPage({super.key});

  @override
  State<ListaProductosPage> createState() => _ListaProductosPageState();
}

class _ListaProductosPageState extends State<ListaProductosPage> {
  // Usamos una clave para forzar la actualización si es necesario
  Key _listKey = UniqueKey();

  Future<List<Map<String, dynamic>>> _getLibros() async {
    final response = await supabase
        .from('libros')
        .select()
        .order('created_at');

    return List<Map<String, dynamic>>.from(response);
  }

  // Función para refrescar la lista después de agregar/editar/eliminar
  void _refrescarLista() {
    setState(() {
      _listKey = UniqueKey(); // Cambia la clave para forzar el redibujado
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: const Text(
          'Libros disponibles',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          // ➕ AGREGAR LIBRO
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AgregarLibroScreen(),
                ),
              );

              if (result == true) {
                _refrescarLista(); // Refrescar lista si se agregó un libro
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Barra de búsqueda (UI - sin funcionalidad aún)
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.white,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar libros...',
                prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                filled: true,
                fillColor: AppColors.background,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 📚 LISTA DESDE SUPABASE
          Expanded(
            // Usamos la clave para forzar la actualización
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

                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            // Imagen
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                libro['imagen_url'] ?? '',
                                width: 80,
                                height: 120,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  width: 80,
                                  height: 120,
                                  color: const Color(0xFFE0E0E0), // Gris claro
                                  child: const Icon(
                                    Icons.book,
                                    size: 40,
                                    color: Color(0xFF9E9E9E),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),

                            // Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    libro['titulo'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    libro['autor'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF666666),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '\$${libro['precio']}',
                                        style: const TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      
                                      // Botones de ACCIÓN (Editar y Eliminar)
                                      Row(
                                        children: [
                                          // ✏️ BOTÓN DE EDITAR
                                          IconButton(
                                            icon: const Icon(Icons.edit, color: AppColors.primary),
                                            onPressed: () async {
                                              final result = await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  // 👈 Pasamos el libro a la pantalla de edición
                                                  builder: (_) => EditarLibroScreen(libro: libro), 
                                                ),
                                              );
                                              if (result == true) {
                                                _refrescarLista(); // Refrescar lista si se editó
                                              }
                                            },
                                          ),
                                          
                                          // 🗑️ BOTÓN DE ELIMINAR
                                          IconButton(
                                            icon: const Icon(Icons.delete, color: Colors.red),
                                            onPressed: () async {
                                              await supabase
                                                  .from('libros')
                                                  .delete()
                                                  .eq('id', libro['id']);

                                              _refrescarLista(); // Refrescar lista después de eliminar
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
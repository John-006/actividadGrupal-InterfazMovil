import 'package:flutter/material.dart';

class CategoriasPage extends StatelessWidget {
  const CategoriasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categorias = [
      {'nombre': 'Ficción', 'icono': Icons.auto_stories, 'color': const Color(0xFF6A4C93)},
      {'nombre': 'Ciencia', 'icono': Icons.science, 'color': const Color(0xFF3A86FF)},
      {'nombre': 'Historia', 'icono': Icons.history_edu, 'color': const Color(0xFFFF006E)},
      {'nombre': 'Biografías', 'icono': Icons.person, 'color': const Color(0xFFFFCA3A)},
      {'nombre': 'Tecnología', 'icono': Icons.computer, 'color': const Color(0xFF8B5FBF)},
      {'nombre': 'Arte', 'icono': Icons.palette, 'color': const Color(0xFFFF006E)},
      {'nombre': 'Cocina', 'icono': Icons.restaurant, 'color': const Color(0xFFFFCA3A)},
      {'nombre': 'Viajes', 'icono': Icons.flight, 'color': const Color(0xFF3A86FF)},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6A4C93),
        elevation: 0,
        title: const Text(
          'Categorías',
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
      ),
      body: Column(
        children: [
          // Barra de búsqueda
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar categoría...',
                prefixIcon: const Icon(Icons.search, color: Color(0xFF6A4C93)),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          // Grid de categorías
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemCount: categorias.length,
              itemBuilder: (context, index) {
                final categoria = categorias[index];
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: (categoria['color'] as Color).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            categoria['icono'] as IconData,
                            size: 40,
                            color: categoria['color'] as Color,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          categoria['nombre'] as String,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF333333),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
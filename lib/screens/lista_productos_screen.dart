import 'package:flutter/material.dart';

class ListaProductosPage extends StatelessWidget {
  const ListaProductosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final libros = [
      {'titulo': 'Cien años de soledad', 'autor': 'Gabriel García Márquez', 'precio': '\$45.000'},
      {'titulo': 'Don Quijote de la Mancha', 'autor': 'Miguel de Cervantes', 'precio': '\$38.000'},
      {'titulo': '1984', 'autor': 'George Orwell', 'precio': '\$32.000'},
      {'titulo': 'El principito', 'autor': 'Antoine de Saint-Exupéry', 'precio': '\$25.000'},
      {'titulo': 'Orgullo y prejuicio', 'autor': 'Jane Austen', 'precio': '\$35.000'},
      {'titulo': 'Crónica de una muerte anunciada', 'autor': 'Gabriel García Márquez', 'precio': '\$30.000'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6A4C93),
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
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Barra de búsqueda y filtros
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Buscar libros...',
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF6A4C93)),
                    filled: true,
                    fillColor: const Color(0xFFF5F5F5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.filter_list, size: 18),
                        label: const Text('Filtrar'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF6A4C93),
                          side: const BorderSide(color: Color(0xFF6A4C93)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.sort, size: 18),
                        label: const Text('Ordenar'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF6A4C93),
                          side: const BorderSide(color: Color(0xFF6A4C93)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Lista de libros
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: libros.length,
              itemBuilder: (context, index) {
                final libro = libros[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          // Imagen del libro
                          Container(
                            width: 80,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.book,
                              size: 40,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Información del libro
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  libro['titulo'] as String,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF333333),
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  libro['autor'] as String,
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
                                      libro['precio'] as String,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF6A4C93),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.add_shopping_cart,
                                        color: Color(0xFF6A4C93),
                                      ),
                                      style: IconButton.styleFrom(
                                        backgroundColor: const Color(0xFF6A4C93).withOpacity(0.1),
                                      ),
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
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'app_theme.dart';

class ListaProductosPage extends StatelessWidget {
  const ListaProductosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final libros = [
      {
        'titulo': 'Cien años de soledad',
        'autor': 'Gabriel García Márquez',
        'precio': '\$45.000',
        'imagen': 'https://www.rae.es/sites/default/files/styles/obra_portada_ficha/public/portada_cien_anos_de_soledad_0.jpg?itok=DDV1xNqg'
      },
      {
        'titulo': 'Don Quijote de la Mancha',
        'autor': 'Miguel de Cervantes',
        'precio': '\$38.000',
        'imagen': 'https://www.elejandria.com/covers/Don_Quijote_de_la_Mancha-Cervantes_Miguel-md.png'
      },
      {
        'titulo': '1984',
        'autor': 'George Orwell',
        'precio': '\$32.000',
        'imagen': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ84nUqbpAYPEo7Dw9iCDYBwOlUX5bn6dr6ig&s'
      },
      {
        'titulo': 'El principito',
        'autor': 'Antoine de Saint-Exupéry',
        'precio': '\$25.000',
        'imagen': 'https://www.tornamesa.co/imagenes/9789584/978958420138.GIF'
      },
      {
        'titulo': 'Orgullo y prejuicio',
        'autor': 'Jane Austen',
        'precio': '\$35.000',
        'imagen': 'https://img.perlego.com/book-covers/4294081/9788467071139_300_450.webp'
      },
      {
        'titulo': 'Crónica de una muerte anunciada',
        'autor': 'Gabriel García Márquez',
        'precio': '\$30.000',
        'imagen': 'https://covers.odilo.io/public/OdiloPlace_PRH_SPA_LICENCIAS/9788439729952_ORIGINAL.jpg'
      },
    ];

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
            color: AppColors.white,
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Buscar libros...',
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF6A4C93)),
                    filled: true,
                    fillColor: AppColors.background,
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
                            foregroundColor: AppColors.primary,
                            side: BorderSide(color: AppColors.primary),
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
                          foregroundColor: AppColors.primary,
                          side: BorderSide(color: AppColors.primary),
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
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          // Imagen del libro
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              libro['imagen'] as String,
                              width: 80,
                              height: 120,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  width: 80,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: AppColors.grey300,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes!
                                          : null,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 80,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: AppColors.grey300,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.book,
                                    size: 40,
                                    color: AppColors.grey500,
                                  ),
                                );
                              },
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
                                      style: AppTextStyles.subtitle.copyWith(color: AppColors.primary, fontSize: 18),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.add_shopping_cart,
                                              color: Color(0xFF6A4C93),
                                      ),
                                            style: IconButton.styleFrom(
                                              backgroundColor: AppColors.primary.withOpacity(0.1),
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
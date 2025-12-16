import 'package:flutter/material.dart';
import 'app_theme.dart';

class GeneroPage extends StatelessWidget {
  const GeneroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: const Text(
          'Género: Ficción',
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
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Tabs de subgéneros
          Container(
            height: 50,
            color: AppColors.white,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildChip('Todo'),
                _buildChip('Clásicos'),
                _buildChip('Contemporánea'),
                _buildChip('Fantasía'),
                _buildChip('Ciencia Ficción'),
                _buildChip('Romance'),
              ],
            ),
          ),
          // Grid de libros
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.65,
              ),
              itemCount: 8,
              itemBuilder: (context, index) {
                final libros = [
                  {'titulo': 'Cien años de soledad', 'autor': 'Gabriel García Márquez', 'precio': '\$45.000'},
                  {'titulo': 'Don Quijote', 'autor': 'Miguel de Cervantes', 'precio': '\$38.000'},
                  {'titulo': '1984', 'autor': 'George Orwell', 'precio': '\$32.000'},
                  {'titulo': 'El principito', 'autor': 'Antoine de Saint-Exupéry', 'precio': '\$25.000'},
                  {'titulo': 'Orgullo y prejuicio', 'autor': 'Jane Austen', 'precio': '\$35.000'},
                  {'titulo': 'Crimen y castigo', 'autor': 'Fiódor Dostoyevski', 'precio': '\$40.000'},
                  {'titulo': 'El gran Gatsby', 'autor': 'F. Scott Fitzgerald', 'precio': '\$30.000'},
                  {'titulo': 'Matar un ruiseñor', 'autor': 'Harper Lee', 'precio': '\$33.000'},
                ];
                
                final libro = libros[index];
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12),
                                  ),
                                ),
                                child: Icon(
                            ),
                                  size: 60,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.favorite_border,
                                    size: 18,
                                    color: Color(0xFF6A4C93),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Información del libro
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  libro['titulo']!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF333333),
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  libro['autor']!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      libro['precio']!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF6A4C93),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF6A4C93).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: const Icon(
                                        Icons.add_shopping_cart,
                                        size: 18,
                                        color: Color(0xFF6A4C93),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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

  Widget _buildChip(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: label == 'Todo',
        onSelected: (selected) {},
        selectedColor: const Color(0xFF6A4C93),
        backgroundColor: Colors.grey.shade200,
        labelStyle: TextStyle(
          color: label == 'Todo' ? Colors.white : const Color(0xFF666666),
          fontWeight: label == 'Todo' ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }
}
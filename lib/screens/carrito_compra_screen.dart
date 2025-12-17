import 'package:flutter/material.dart';
// 1. CORRECCIÓN: Importación de las clases de utilidad
import 'app_theme.dart'; 

class CarritoCompraPage extends StatefulWidget {
  const CarritoCompraPage({super.key});

  @override
  State<CarritoCompraPage> createState() => _CarritoCompraPageState();
}

class _CarritoCompraPageState extends State<CarritoCompraPage> {
  // Lista de ejemplo: precios como double para evitar errores de tipo en el cálculo
  final List<Map<String, dynamic>> itemsCarrito = [
    {'titulo': 'Cien años de soledad', 'autor': 'Gabriel García Márquez', 'precio': 45000.0, 'cantidad': 1},
    {'titulo': 'Don Quijote de la Mancha', 'autor': 'Miguel de Cervantes', 'precio': 38000.0, 'cantidad': 2},
    {'titulo': 'El principito', 'autor': 'Antoine de Saint-Exupéry', 'precio': 25000.0, 'cantidad': 1},
  ];

  double get subtotal {
    // 4. CORRECCIÓN: Usar 0.0 como valor inicial para asegurar que el resultado sea double.
    return itemsCarrito.fold(0.0, (sum, item) => sum + (item['precio'] * item['cantidad']));
  }

  double get envio => 5000.0;
  double get total => subtotal + envio;

  // ----------------------------------------------------------------------
  // BUILDER METHODS
  // ----------------------------------------------------------------------

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 100,
            color: AppColors.grey400,
          ),
          const SizedBox(height: 16),
          Text(
            'Tu carrito está vacío',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.grey600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Agrega algunos libros para comenzar',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF999999),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(Map<String, dynamic> item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Imagen
          Container(
            width: 60,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.grey300,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.book,
              size: 30,
              color: AppColors.grey500,
            ),
          ),
          const SizedBox(width: 12),
          // Información
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['titulo'],
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
                  item['autor'],
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF666666),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 3. CORRECCIÓN: Muestra el precio total del ítem (precio * cantidad)
                    Text(
                      '\$${(item['precio'] * item['cantidad']).toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (item['cantidad'] > 1) {
                                item['cantidad']--;
                              } else {
                                // Opción adicional: eliminar si llega a 0
                                itemsCarrito.removeAt(index);
                              }
                            });
                          },
                          icon: const Icon(Icons.remove_circle_outline),
                          color: AppColors.primary,
                          constraints: const BoxConstraints(),
                          padding: EdgeInsets.zero,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            '${item['cantidad']}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              item['cantidad']++;
                            });
                          },
                          icon: const Icon(Icons.add_circle_outline),
                          color: AppColors.primary,
                          constraints: const BoxConstraints(),
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                itemsCarrito.removeAt(index);
              });
            },
            icon: const Icon(Icons.delete_outline),
            color: AppColors.red400,
          ),
        ],
      ),
    );
  }

  Widget _buildSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          // 2. CORRECCIÓN: Eliminación del bloque de BoxShadow duplicado
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSummaryRow('Subtotal', '\$${subtotal.toStringAsFixed(0)}'),
          const SizedBox(height: 8),
          _buildSummaryRow('Envío', '\$${envio.toStringAsFixed(0)}'),
          const Divider(height: 24),
          _buildSummaryRow('Total', '\$${total.toStringAsFixed(0)}', isTotal: true),
          const SizedBox(height: 16),
          AppButton(
            text: 'Proceder al pago',
            onPressed: () {
              // Lógica de pago
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? const Color(0xFF333333) : const Color(0xFF666666),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: FontWeight.bold,
            // Usar AppColors.primary para el total (definido en app_theme)
            color: isTotal ? AppColors.primary : const Color(0xFF333333), 
          ),
        ),
      ],
    );
  }
  
  // ----------------------------------------------------------------------
  // WIDGET PRINCIPAL
  // ----------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: const Text(
          'Carrito de Compra',
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
      body: itemsCarrito.isEmpty
          ? _buildEmptyCart()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: itemsCarrito.length,
                    itemBuilder: (context, index) {
                      final item = itemsCarrito[index];
                      return _buildCartItem(item, index);
                    },
                  ),
                ),
                _buildSummary(),
              ],
            ),
    );
  }
}
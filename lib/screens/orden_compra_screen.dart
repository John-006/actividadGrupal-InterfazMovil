import 'package:flutter/material.dart';
import 'app_theme.dart';

class OrdenCompraPage extends StatelessWidget {
  const OrdenCompraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: const Text(
          'Resumen del Pedido',
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
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Información de entrega
                  Text('Información de Entrega', style: AppTextStyles.subtitle),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6A4C93).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                                child: const Icon(
                                Icons.person,
                                color: Color(0xFF6A4C93),
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                'Juan Pérez',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF333333),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text('Editar'),
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Color(0xFF6A4C93),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Dirección de entrega',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF666666),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Calle 123 #45-67\nBogotá, Colombia',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF333333),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: const [
                            Icon(
                              Icons.phone,
                              color: Color(0xFF6A4C93),
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              '+57 300 123 4567',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Productos
                  Text('Productos', style: AppTextStyles.subtitle),
                  const SizedBox(height: 12),
                  _buildProductItem('Cien años de soledad', 'Gabriel García Márquez', 45000, 1),
                  const SizedBox(height: 8),
                  _buildProductItem('Don Quijote de la Mancha', 'Miguel de Cervantes', 38000, 2),
                  const SizedBox(height: 8),
                  _buildProductItem('El principito', 'Antoine de Saint-Exupéry', 25000, 1),
                  const SizedBox(height: 24),
                  // Método de pago
                  Text('Método de Pago', style: AppTextStyles.subtitle),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
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
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6A4C93).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.credit_card,
                            color: Color(0xFF6A4C93),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Tarjeta •••• 3456',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Cambiar'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
                // Resumen y botón
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildSummaryRow('Subtotal', '\$146.000'),
                const SizedBox(height: 8),
                _buildSummaryRow('Envío', '\$5.000'),
                const SizedBox(height: 8),
                _buildSummaryRow('IVA', '\$28.690'),
                const Divider(height: 24),
                _buildSummaryRow('Total', '\$179.690', isTotal: true),
                const SizedBox(height: 16),
                AppButton(text: 'Confirmar Pedido', onPressed: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem(String titulo, String autor, int precio, int cantidad) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.book,
              size: 25,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  autor,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF666666),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Cantidad: $cantidad',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ),
          Text(
            '\$${precio * cantidad}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6A4C93),
            ),
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
            color: isTotal ? const Color(0xFF6A4C93) : const Color(0xFF333333),
          ),
        ),
      ],
    );
  }
}
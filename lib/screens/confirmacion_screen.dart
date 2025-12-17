import 'package:flutter/material.dart';
import 'app_theme.dart'; // Importación simple de AppColors y AppTextStyles (asumiendo que está en /screens)

class ConfirmacionPage extends StatelessWidget {
  const ConfirmacionPage({super.key});

  // Helper para construir las filas de información, eliminando la necesidad de constantes complejas
  Widget _buildSummaryRow(String label, String value, {Color? color, bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF666666),
          ),
        ),
        Text(
          value,
          style: isTotal 
              ? AppTextStyles.subtitle.copyWith(color: AppColors.primary, fontSize: 18)
              : TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: color ?? const Color(0xFF333333),
                ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icono de éxito
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF4CAF50).withOpacity(0.28),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 70,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      '¡Pedido Confirmado!',
                      // Usa AppTextStyles, que debe estar definida en app_theme.dart
                      style: AppTextStyles.title.copyWith(fontSize: 28), 
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Tu pedido ha sido procesado exitosamente',
                      style: AppTextStyles.bodyLight,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    // Información del pedido (Resumen)
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // 2. CORRECCIÓN: Uso del _buildSummaryRow helper
                          _buildSummaryRow(
                            'Número de orden',
                            '#ORD-2024-001234',
                            color: AppColors.primary,
                          ),
                          const Divider(height: 24),
                          _buildSummaryRow('Fecha de pedido', '28 Nov, 2024'),
                          const Divider(height: 24),
                          _buildSummaryRow('Total', '\$179.690', isTotal: true),
                          const Divider(height: 24),
                          _buildSummaryRow('Tiempo estimado', '3-5 días hábiles'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Información adicional
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: AppColors.primary,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Hemos enviado un correo de confirmación con los detalles de tu pedido',
                              style: AppTextStyles.body.copyWith(color: AppColors.primary),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Botones
              Column(
                children: [
                  AppButton(text: 'Seguir Pedido', onPressed: () {}),
                  const SizedBox(height: 12),
                  AppButton(
                    text: 'Volver al Inicio', 
                    onPressed: () { 
                      Navigator.of(context).popUntil((route) => route.isFirst); 
                    }, 
                    isOutline: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
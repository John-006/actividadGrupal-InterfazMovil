import 'package:flutter/material.dart';
import 'app_theme.dart';

class MedioPagoPage extends StatefulWidget {
  const MedioPagoPage({super.key});

  @override
  State<MedioPagoPage> createState() => _MedioPagoPageState();
}

class _MedioPagoPageState extends State<MedioPagoPage> {
  String metodoPagoSeleccionado = 'tarjeta';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: const Text(
          'Método de Pago',
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
                  Text(
                    'Selecciona un método de pago',
                    style: AppTextStyles.subtitle,
                  ),
                  const SizedBox(height: 20),
                  // Tarjeta de crédito/débito
                  _buildPaymentOption(
                    id: 'tarjeta',
                    icon: Icons.credit_card,
                    title: 'Tarjeta de Crédito/Débito',
                    subtitle: 'Visa, Mastercard, American Express',
                  ),
                  const SizedBox(height: 12),
                  // PSE
                  _buildPaymentOption(
                    id: 'pse',
                    icon: Icons.account_balance,
                    title: 'PSE',
                    subtitle: 'Pago mediante transferencia bancaria',
                  ),
                  const SizedBox(height: 12),
                  // Efectivo
                  _buildPaymentOption(
                    id: 'efectivo',
                    icon: Icons.money,
                    title: 'Efectivo',
                    subtitle: 'Paga al recibir tu pedido',
                  ),
                  const SizedBox(height: 12),
                  // Nequi
                  _buildPaymentOption(
                    id: 'nequi',
                    icon: Icons.phone_android,
                    title: 'Nequi',
                    subtitle: 'Pago mediante billetera digital',
                  ),
                  const SizedBox(height: 24),
                  // Formulario según método seleccionado
                  if (metodoPagoSeleccionado == 'tarjeta') _buildCardForm(),
                  if (metodoPagoSeleccionado == 'pse') _buildPSEInfo(),
                  if (metodoPagoSeleccionado == 'efectivo') _buildCashInfo(),
                  if (metodoPagoSeleccionado == 'nequi') _buildNequiInfo(),
                ],
              ),
            ),
          ),
          // Footer con botón de continuar
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
            child: AppButton(text: 'Continuar', onPressed: () {}),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption({
    required String id,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final isSelected = metodoPagoSeleccionado == id;
    return GestureDetector(
      onTap: () {
        setState(() {
          metodoPagoSeleccionado = id;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
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
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodyLight,
                  ),
                ],
              ),
            ),
            Radio<String>(
              value: id,
              groupValue: metodoPagoSeleccionado,
              onChanged: (value) {
                setState(() {
                  metodoPagoSeleccionado = value!;
                });
              },
              activeColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardForm() {
    return Container(
      padding: const EdgeInsets.all(20),
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
          Text(
            'Información de la tarjeta',
            style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Número de tarjeta',
              hintText: '1234 5678 9012 3456',
              prefixIcon: Icon(Icons.credit_card, color: AppColors.primary),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Nombre del titular',
              hintText: 'Juan Pérez',
              prefixIcon: Icon(Icons.person, color: AppColors.primary),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Fecha vencimiento',
                    hintText: 'MM/AA',
                    prefixIcon: Icon(Icons.calendar_today, color: AppColors.primary),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'CVV',
                    hintText: '123',
                    prefixIcon: Icon(Icons.lock, color: AppColors.primary),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPSEInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.account_balance,
            size: 60,
            color: Color(0xFF6A4C93),
          ),
          const SizedBox(height: 16),
          Text(
            'Serás redirigido a tu banco',
            style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            'Al continuar, te llevaremos a la página de tu banco para completar el pago de forma segura.',
            style: AppTextStyles.bodyLight,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCashInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.money,
            size: 60,
            color: Color(0xFF6A4C93),
          ),
          const SizedBox(height: 16),
          const Text(
            'Paga al recibir',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Pagarás en efectivo cuando recibas tu pedido. Asegúrate de tener el monto exacto.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF666666),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNequiInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.phone_android,
            size: 60,
            color: Color(0xFF6A4C93),
          ),
          const SizedBox(height: 16),
          const Text(
            'Paga con Nequi',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Recibirás una notificación en tu app de Nequi para aprobar el pago.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF666666),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
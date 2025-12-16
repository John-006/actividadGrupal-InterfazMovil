import 'package:flutter/material.dart';
import 'app_theme.dart';

class NuevoPasswordPage extends StatefulWidget {
  const NuevoPasswordPage({super.key});

  @override
  State<NuevoPasswordPage> createState() => _NuevoPasswordPageState();
}

class _NuevoPasswordPageState extends State<NuevoPasswordPage> {
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: const Text(
          'Nueva Contraseña',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icono
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lock_reset,
                  size: 50,
                  color: Color(0xFF6A4C93),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Título y descripción
            Text(
              'Crea una nueva contraseña',
              style: AppTextStyles.title.copyWith(fontSize: 22),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Tu nueva contraseña debe ser diferente a las contraseñas anteriores y cumplir con los requisitos de seguridad.',
              style: AppTextStyles.bodyLight.copyWith(height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            // Nueva contraseña
            const Text(
              'Nueva contraseña',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              obscureText: obscurePassword,
              decoration: InputDecoration(
                hintText: '••••••••',
                prefixIcon: Icon(Icons.lock, color: AppColors.primary),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.primary,
                  ),
                  onPressed: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                ),
                filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.grey300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.primary, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Confirmar contraseña
            const Text(
              'Confirmar nueva contraseña',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              obscureText: obscureConfirmPassword,
              decoration: InputDecoration(
                hintText: '••••••••',
                prefixIcon: Icon(Icons.lock_outline, color: AppColors.primary),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.primary,
                  ),
                  onPressed: () {
                    setState(() {
                      obscureConfirmPassword = !obscureConfirmPassword;
                    });
                  },
                ),
                filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.grey300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.primary, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Requisitos de contraseña
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
                  const Text(
                    'Tu contraseña debe contener:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildRequirement('Al menos 8 caracteres', true),
                  const SizedBox(height: 8),
                  _buildRequirement('Una letra mayúscula', false),
                  const SizedBox(height: 8),
                  _buildRequirement('Una letra minúscula', false),
                  const SizedBox(height: 8),
                  _buildRequirement('Un número', false),
                  const SizedBox(height: 8),
                  _buildRequirement('Un carácter especial (@, #, \$, etc.)', false),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Botón
            AppButton(text: 'Cambiar Contraseña', onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildRequirement(String text, bool isMet) {
    return Row(
      children: [
        Icon(
          isMet ? Icons.check_circle : Icons.cancel,
          size: 18,
          color: isMet ? const Color(0xFF4CAF50) : AppColors.grey400,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: isMet ? const Color(0xFF4CAF50) : const Color(0xFF666666),
          ),
        ),
      ],
    );
  }
}
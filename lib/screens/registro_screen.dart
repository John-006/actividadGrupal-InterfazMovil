import 'package:flutter/material.dart';
import 'app_theme.dart';

class RegistroUsuarioPage extends StatelessWidget {
  const RegistroUsuarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Crear Cuenta', style: AppTextStyles.title),
              const SizedBox(height: 8),
              Text('Completa los datos para registrarte', style: AppTextStyles.bodyLight),
              const SizedBox(height: 32),

              AppTextField(
                label: 'Nombre completo',
                hint: 'Juan Pérez',
                prefixIcon: Icons.person,
              ),
              const SizedBox(height: 20),

              AppTextField(
                label: 'Correo electrónico',
                hint: 'ejemplo@correo.com',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.email,
              ),
              const SizedBox(height: 20),

              AppTextField(
                label: 'Teléfono',
                hint: '+57 300 123 4567',
                keyboardType: TextInputType.phone,
                prefixIcon: Icons.phone,
              ),
              const SizedBox(height: 20),

              AppTextField(
                label: 'Contraseña',
                hint: '••••••••',
                obscureText: true,
                prefixIcon: Icons.lock,
              ),
              const SizedBox(height: 20),

              AppTextField(
                label: 'Confirmar contraseña',
                hint: '••••••••',
                obscureText: true,
                prefixIcon: Icons.lock_outline,
              ),
              const SizedBox(height: 32),

              AppButton(
                text: 'Registrarse',
                onPressed: () {},
              ),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('¿Ya tienes cuenta? ', style: AppTextStyles.bodyLight),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                    ),
                    child: Text('Inicia Sesión', style: AppTextStyles.subtitle.copyWith(color: AppColors.primary)),
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
import 'package:flutter/material.dart';
import 'app_theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              // Logo o icono
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 6)),
                  ],
                ),
                child: const Icon(
                  Icons.local_library,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              // Título
              Text(
                'Bienvenido a la biblioteca',
                style: AppTextStyles.title.copyWith(fontSize: 28),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Inicia sesión en tu biblioteca',
                style: AppTextStyles.bodyLight,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              // Campo de correo
              const Text(
                'Correo electrónico',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'ejemplo@correo.com',
                  prefixIcon: Icon(Icons.email, color: AppColors.primary),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Campo de contraseña
              const Text(
                'Contraseña',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: '••••••••',
                  prefixIcon: Icon(Icons.lock, color: AppColors.primary),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // ¿Olvidaste tu contraseña?
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                      '¿Olvidaste tu contraseña?',
                      style: AppTextStyles.body.copyWith(color: AppColors.primary),
                    ),
                ),
              ),
              const SizedBox(height: 24),
              // Botón de iniciar sesión
              AppButton(
                text: 'Iniciar Sesión',
                onPressed: () {},
              ),
              const SizedBox(height: 24),
              // Registro
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '¿No tienes cuenta? ',
                    style: TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 14,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                    ),
                      child: Text(
                      'Regístrate',
                      style: AppTextStyles.button.copyWith(color: AppColors.primary, fontSize: 14),
                    ),
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
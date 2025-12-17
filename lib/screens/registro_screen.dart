import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'package:app/screens/app_text_field.dart';
import '../services/auth_service.dart';

class RegistroUsuarioPage extends StatefulWidget {
  const RegistroUsuarioPage({super.key});

  @override
  State<RegistroUsuarioPage> createState() => _RegistroUsuarioPageState();
}

class _RegistroUsuarioPageState extends State<RegistroUsuarioPage> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();

  final _nombreController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _nombreController.dispose();
    _telefonoController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final error = await _authService.signUp(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      nombre: _nombreController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro exitoso. Revisa tu correo')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
    }
  }

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
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Crear Cuenta', style: AppTextStyles.title),
                const SizedBox(height: 8),
                Text(
                  'Completa los datos para registrarte',
                  style: AppTextStyles.bodyLight,
                ),
                const SizedBox(height: 32),

                AppTextField(
                  label: 'Nombre completo',
                  hint: 'Juan Pérez',
                  prefixIcon: Icons.person,
                  controller: _nombreController,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Campo requerido' : null,
                ),
                const SizedBox(height: 20),

                AppTextField(
                  label: 'Correo electrónico',
                  hint: 'ejemplo@correo.com',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email,
                  controller: _emailController,
                  validator: (v) =>
                      v == null || !v.contains('@') ? 'Correo inválido' : null,
                ),
                const SizedBox(height: 20),

                AppTextField(
                  label: 'Teléfono',
                  hint: '+57 300 123 4567',
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icons.phone,
                  controller: _telefonoController,
                ),
                const SizedBox(height: 20),

                AppTextField(
                  label: 'Contraseña',
                  hint: '••••••••',
                  obscureText: true,
                  prefixIcon: Icons.lock,
                  controller: _passwordController,
                  validator: (v) =>
                      v == null || v.length < 6 ? 'Mínimo 6 caracteres' : null,
                ),
                const SizedBox(height: 20),

                AppTextField(
                  label: 'Confirmar contraseña',
                  hint: '••••••••',
                  obscureText: true,
                  prefixIcon: Icons.lock_outline,
                  controller: _confirmPasswordController,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Confirma la contraseña';
                    if (v != _passwordController.text) {
                      return 'Las contraseñas no coinciden';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleSignUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Registrarse',
                            style: AppTextStyles.subtitle.copyWith(
                              color: AppColors.white,
                              fontSize: 18,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

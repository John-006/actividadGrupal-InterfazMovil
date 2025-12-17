import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'app_text_field.dart';
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
  final _generoController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _nombreController.dispose();
    _telefonoController.dispose();
    _emailController.dispose();
    _generoController.dispose();
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
      telefono: _telefonoController.text.trim(),
      genero: _generoController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro exitoso')),
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
                const SizedBox(height: 32),
                AppTextField(
                  label: 'Nombre completo',
                  prefixIcon: Icons.person,
                  controller: _nombreController,
                  validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
                ),
                const SizedBox(height: 20),
                AppTextField(
                  label: 'Correo electrónico',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email,
                  controller: _emailController,
                  validator: (v) => v == null || !v.contains('@') ? 'Email inválido' : null,
                ),
                const SizedBox(height: 20),
                AppTextField(
                  label: 'Teléfono',
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icons.phone,
                  controller: _telefonoController,
                  validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
                ),
                const SizedBox(height: 20),
                AppTextField(
                  label: 'Género preferido',
                  hint: 'Ej: Novela, Terror',
                  prefixIcon: Icons.auto_awesome,
                  controller: _generoController,
                  validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
                ),
                const SizedBox(height: 20),
                AppTextField(
                  label: 'Contraseña',
                  obscureText: true,
                  prefixIcon: Icons.lock,
                  controller: _passwordController,
                  validator: (v) => v == null || v.length < 6 ? 'Mínimo 6 caracteres' : null,
                ),
                const SizedBox(height: 20),
                AppTextField(
                  label: 'Confirmar contraseña',
                  obscureText: true,
                  prefixIcon: Icons.lock_outline,
                  controller: _confirmPasswordController,
                  validator: (v) => v != _passwordController.text ? 'No coinciden' : null,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleSignUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Registrarse', style: TextStyle(color: Colors.white, fontSize: 18)),
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
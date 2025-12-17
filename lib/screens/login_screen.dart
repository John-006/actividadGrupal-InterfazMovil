// screens/login_screen.dart
import 'package:flutter/material.dart';
import 'app_theme.dart';
import '../services/auth_service.dart'; // Importación de Supabase Auth Service

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();

  // Controladores de formulario
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final error = await _authService.signIn(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    setState(() {
      _isLoading = false;
    });

    if (error == null) {
      // Inicio de sesión exitoso. Navegar a la pantalla principal (Home)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡Inicio de sesión exitoso!')),
      );
      // Vuelve a la primera ruta, que se asume es el menú principal
      Navigator.popUntil(context, (route) => route.isFirst);
      
    } else {
      // Mostrar error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al iniciar sesión: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // ⚠️ Se envuelve en Builder para poder usar Navigator.canPop(context)
    return Builder( 
      builder: (context) {
        // Verifica si hay una ruta anterior a la cual volver
        final canGoBack = Navigator.of(context).canPop(); 
        
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar( // 👈 ¡AÑADIMOS UN APPBAR!
            backgroundColor: AppColors.background,
            elevation: 0,
            // 👈 Muestra el botón de volver solo si NO es la primera pantalla.
            leading: canGoBack
                ? IconButton( 
                    icon: const Icon(Icons.arrow_back, color: Color(0xFF333333)),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                : null, // Si es la primera pantalla, no muestra el botón.
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
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
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => value == null || !value.contains('@') ? 'Ingrese un correo válido' : null,
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
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      validator: (value) => value == null || value.length < 6 ? 'Mínimo 6 caracteres' : null,
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
                        onPressed: () {
                          // Navegar a 'nuevo_password_screen.dart'
                        },
                        child: Text(
                          '¿Olvidaste tu contraseña?',
                          style: AppTextStyles.body.copyWith(color: AppColors.primary),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Botón de iniciar sesión
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleSignIn,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text(
                                'Iniciar Sesión',
                                style: AppTextStyles.subtitle.copyWith(color: AppColors.white, fontSize: 18),
                              ),
                      ),
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
                          onPressed: () {
                            // Navegar a 'registro_screen.dart'
                          },
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
          ),
        );
      }
    );
  }
}
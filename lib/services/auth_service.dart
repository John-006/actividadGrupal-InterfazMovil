// lib/services/auth_service.dart
import 'package:supabase_flutter/supabase_flutter.dart';

// Obtén tu instancia de Supabase Client (asumiendo que está inicializada en main.dart)
final supabase = Supabase.instance.client;

class AuthService {

  // --- REGISTRO DE USUARIO ---
  Future<String?> signUp({
    required String email,
    required String password,
    required String nombre,
  }) async {
    try {
      final AuthResponse response = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user != null) {
        // El registro fue exitoso. Ahora insertamos el perfil:
        await supabase.from('profiles').insert({
          'id': response.user!.id,
          'nombre': nombre,
          'created_at': DateTime.now().toIso8601String(),
        });
        return null; // Éxito
      } else {
        // Esto captura errores si el correo ya está registrado, etc.
        return 'Error al registrar: ${response.session?.user.email}'; 
      }
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return 'Ocurrió un error inesperado durante el registro: $e';
    }
  }

  // --- INICIO DE SESIÓN ---
  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return null; // Éxito
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return 'Ocurrió un error inesperado al iniciar sesión';
    }
  }
}
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class AuthService {
  Future<String?> signUp({
    required String email,
    required String password,
    required String nombre,
    required String telefono,
    required String genero,
  }) async {
    try {
      final AuthResponse response = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user != null) {
        await supabase.from('profiles').insert({
          'id': response.user!.id,
          'nombre': nombre,
          'telefono': telefono,
          'genero_prefer': genero,
          'created_at': DateTime.now().toIso8601String(),
        });
        return null;
      } else {
        return 'Error al registrar el usuario';
      }
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return 'Error inesperado: $e';
    }
  }

  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return null;
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return 'Error al iniciar sesión';
    }
  }
}
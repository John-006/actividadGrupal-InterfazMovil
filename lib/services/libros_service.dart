// lib/services/libros_service.dart
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class LibrosService {
  Future<List<Map<String, dynamic>>> getLibros() async {
    final response = await supabase
        .from('libros')
        .select()
        .order('created_at');

    return List<Map<String, dynamic>>.from(response);
  }
}

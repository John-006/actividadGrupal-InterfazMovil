// screens/editar_libro_screen.dart

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app_theme.dart'; // Asegúrate de que esta ruta sea correcta

final supabase = Supabase.instance.client;

class EditarLibroScreen extends StatefulWidget {
  // 1. La pantalla debe recibir los datos del libro
  final Map<String, dynamic> libro;

  const EditarLibroScreen({super.key, required this.libro});

  @override
  State<EditarLibroScreen> createState() => _EditarLibroScreenState();
}

class _EditarLibroScreenState extends State<EditarLibroScreen> {
  final _formKey = GlobalKey<FormState>();

  // 2. Controladores de formulario (declarados como 'late final' para inicializar en initState)
  late final TextEditingController _tituloController;
  late final TextEditingController _autorController;
  late final TextEditingController _generoController;
  late final TextEditingController _precioController;
  late final TextEditingController _stockController;
  late final TextEditingController _imagenController;

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    // 3. Inicializar controladores con los valores actuales del libro
    _tituloController = TextEditingController(text: widget.libro['titulo'] ?? '');
    _autorController = TextEditingController(text: widget.libro['autor'] ?? '');
    _generoController = TextEditingController(text: widget.libro['genero'] ?? '');
    
    // Convertir números a String para el TextField. Usamos ?.toString() para manejar nulos
    _precioController = TextEditingController(text: widget.libro['precio']?.toString() ?? '');
    _stockController = TextEditingController(text: widget.libro['stock']?.toString() ?? '');
    
    _imagenController = TextEditingController(text: widget.libro['imagen_url'] ?? '');
  }

  Future<void> _actualizarLibro() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      // 4. FUNCIÓN UPDATE: Actualizamos los datos
      await supabase
          .from('libros')
          .update({
            'titulo': _tituloController.text.trim(),
            'autor': _autorController.text.trim(),
            'genero': _generoController.text.trim(),
            'precio': double.parse(_precioController.text),
            'stock': int.parse(_stockController.text),
            'imagen_url': _imagenController.text.trim(),
          })
          .eq('id', widget.libro['id']); // 👈 Filtramos por el ID del libro

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Libro actualizado correctamente')),
      );

      // 5. Volvemos a la pantalla anterior, enviando 'true' para refrescar la lista.
      Navigator.pop(context, true); 
      
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar: ${e.toString()}')),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _autorController.dispose();
    _generoController.dispose();
    _precioController.dispose();
    _stockController.dispose();
    _imagenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text('Editar: ${widget.libro['titulo']}', style: const TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _campo('Título', _tituloController),
              _campo('Autor', _autorController),
              _campo('Género', _generoController), 
              _campo(
                'Precio',
                _precioController,
                tipo: TextInputType.number,
                esNumero: true, 
              ),
              _campo(
                'Stock (Cantidad)',
                _stockController,
                tipo: TextInputType.number,
                esNumero: true,
                esEntero: true,
              ),
              _campo(
                'URL Imagen',
                _imagenController,
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: _loading ? null : _actualizarLibro, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: _loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Guardar cambios', style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget auxiliar para crear campos de texto de forma consistente (incluye validación)
  Widget _campo(
    String label,
    TextEditingController controller, {
    TextInputType tipo = TextInputType.text,
    bool esNumero = false, 
    bool esEntero = false, 
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: tipo,
        validator: (v) {
          if (v == null || v.isEmpty) {
            return 'Campo requerido';
          }
          if (esNumero) {
            final value = double.tryParse(v);
            if (value == null) {
              return 'Debe ser un número válido';
            }
            if (esEntero && value != value.toInt()) {
              return 'Debe ser un número entero (sin decimales)';
            }
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
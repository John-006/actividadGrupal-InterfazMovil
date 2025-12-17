// screens/agregar_libro_screen.dart (Versión Final)

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app_theme.dart';

final supabase = Supabase.instance.client;

class AgregarLibroScreen extends StatefulWidget {
  const AgregarLibroScreen({super.key});

  @override
  State<AgregarLibroScreen> createState() => _AgregarLibroScreenState();
}

class _AgregarLibroScreenState extends State<AgregarLibroScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores de formulario
  final _tituloController = TextEditingController();
  final _autorController = TextEditingController();
  final _generoController = TextEditingController(); 
  final _precioController = TextEditingController();
  final _stockController = TextEditingController(); // 👈 ¡NUEVO CONTROLADOR AÑADIDO!
  final _imagenController = TextEditingController();

  bool _loading = false;

  Future<void> _guardarLibro() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      // ⚠️ CAMBIO CRUCIAL: Incluir el 'stock' en la inserción
      await supabase.from('libros').insert({
        'titulo': _tituloController.text.trim(),
        'autor': _autorController.text.trim(),
        'genero': _generoController.text.trim(),
        'precio': double.parse(_precioController.text),
        'stock': int.parse(_stockController.text), // 👈 ¡Convertir y añadir el stock!
        'imagen_url': _imagenController.text.trim(),
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Libro agregado correctamente')),
      );

      // Limpiar campos después de guardar exitosamente
      _tituloController.clear();
      _autorController.clear();
      _generoController.clear();
      _precioController.clear();
      _stockController.clear();
      _imagenController.clear();

    } catch (e) {
      // Manejo de errores
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar: ${e.toString()}')),
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
    _stockController.dispose(); // 👈 ¡Dispose del nuevo controlador!
    _imagenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Agregar libro', style: TextStyle(color: Colors.white)),
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
              _campo( // 👈 ¡NUEVO CAMPO EN LA UI!
                'Stock (Cantidad)',
                _stockController,
                tipo: TextInputType.number,
                esNumero: true,
                esEntero: true, // Para validar que sea un número entero
              ),
              _campo(
                'URL Imagen',
                _imagenController,
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: _loading ? null : _guardarLibro,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: _loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Guardar libro', style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget auxiliar para crear campos de texto de forma consistente
  Widget _campo(
    String label,
    TextEditingController controller, {
    TextInputType tipo = TextInputType.text,
    bool esNumero = false, 
    bool esEntero = false, // Nuevo parámetro para enteros (stock)
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
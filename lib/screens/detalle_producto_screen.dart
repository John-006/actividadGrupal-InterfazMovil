import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DetalleProductoPage extends StatefulWidget {
  final Map<String, dynamic> libro;

  const DetalleProductoPage({super.key, required this.libro});

  @override
  State<DetalleProductoPage> createState() => _DetalleProductoPageState();
}

class _DetalleProductoPageState extends State<DetalleProductoPage> {
  final supabase = Supabase.instance.client;
  bool _isPurchasing = false;

  Future<void> _realizarCompra() async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, inicia sesión para comprar')),
      );
      return;
    }

    setState(() => _isPurchasing = true);

    try {
      await supabase.from('orders').insert({
        'profile_id': user.id,
        'libro_id': widget.libro['id'],
        'total': widget.libro['precio'],
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('¡Orden de compra generada exitosamente!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al procesar la compra: $e')),
      );
    } finally {
      setState(() => _isPurchasing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6A4C93),
        title: const Text('Detalle del Libro', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 250,
                    color: Colors.white,
                    child: widget.libro['imagen_url'] != null
                        ? Image.network(widget.libro['imagen_url'], fit: BoxFit.contain)
                        : const Icon(Icons.book, size: 100, color: Colors.grey),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.libro['titulo'] ?? 'Sin título',
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.libro['autor'] ?? 'Autor desconocido',
                          style: const TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Información',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        _buildDetailRow('Género', widget.libro['genero'] ?? 'N/A'),
                        _buildDetailRow('Stock disponible', widget.libro['stock']?.toString() ?? '0'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(color: Colors.white),
            child: Row(
              children: [
                Text(
                  '\$${widget.libro['precio']}',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF6A4C93)),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isPurchasing ? null : _realizarCompra,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6A4C93),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: _isPurchasing
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Comprar Ahora', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
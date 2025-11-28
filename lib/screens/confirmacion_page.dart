import 'package:flutter/material.dart';

class ConfirmacionPage extends StatelessWidget {
  const ConfirmacionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.check_circle, size: 80),
            SizedBox(height: 20),
            Text('Acción completada', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}

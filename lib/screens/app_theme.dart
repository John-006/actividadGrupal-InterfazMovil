import 'package:flutter/material.dart';

// Colores de la aplicación
class AppColors {
  static const Color primary = Color(0xFF6A4C93); // Morado
  static const Color secondary = Color(0xFF8B5FBF); // Morado claro
  static const Color accent = Color(0xFFFFCA3A); // Amarillo
  static const Color background = Color(0xFFF5F5F5); // Gris claro
  static const Color white = Colors.white;
  static const Color text = Color(0xFF333333);
  static const Color textLight = Color(0xFF666666);
  // Grises y rojos usados en pantallas
  static final Color grey300 = Colors.grey.shade300;
  static final Color grey400 = Colors.grey.shade400;
  static final Color grey500 = Colors.grey.shade500;
  static final Color grey600 = Colors.grey.shade600;
  static final Color red400 = Colors.red.shade400;
}

// Estilos de texto
class AppTextStyles {
  static const TextStyle title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    color: AppColors.text,
  );

  static const TextStyle bodyLight = TextStyle(
    fontSize: 14,
    color: AppColors.textLight,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
}

// Widget de botón reutilizable
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutline;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutline = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutline ? AppColors.white : AppColors.primary,
          foregroundColor: isOutline ? AppColors.primary : AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: isOutline
                ? BorderSide(color: AppColors.primary, width: 2)
                : BorderSide.none,
          ),
        ),
        child: Text(text, style: AppTextStyles.button),
      ),
    );
  }
}

// Widget de campo de texto reutilizable
class AppTextField extends StatelessWidget {
  final String label;
  final String hint;
  final bool obscureText;
  final TextInputType keyboardType;
  final IconData? prefixIcon;

  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.body),
        const SizedBox(height: 8),
        TextField(
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: AppColors.primary) : null,
            filled: true,
            fillColor: AppColors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

// Widget de tarjeta de libro
class BookCard extends StatelessWidget {
  final String title;
  final String author;
  final String imageUrl;
  final VoidCallback onTap;

  const BookCard({
    super.key,
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Center(
                child: Icon(Icons.book, size: 60, color: Colors.grey.shade500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    author,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
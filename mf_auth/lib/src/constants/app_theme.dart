import 'package:flutter/material.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

/// Clase que proporciona acceso a temas y estilos para el módulo de autenticación
class AuthThemeData {
  // Usamos el proveedor de temas compartido para mantener coherencia
  static ThemeData lightThemeData = SharedThemeProvider.lightThemeData;
  static ThemeData darkThemeData = SharedThemeProvider.darkThemeData;
  
  // Colores específicos del módulo de auth
  static const Color primaryButtonColor = Color(0xFFd21e1d);
  static const Color secondaryButtonColor = Color(0xFF9e1718);
  static const Color formBackgroundColor = Color(0xFFFAFBFB);
  
  // Estilos específicos del módulo
  static ButtonStyle primaryButtonStyle = SharedThemeProvider.roundedButtonStyle(
    backgroundColor: primaryButtonColor,
    textColor: Colors.white,
  );
  
  static ButtonStyle secondaryButtonStyle = SharedThemeProvider.roundedButtonStyle(
    backgroundColor: secondaryButtonColor,
    textColor: Colors.white,
  );
  
  // Decoración de entrada de texto personalizada para el módulo de auth
  static InputDecoration authInputDecoration({
    String? hintText,
    IconData? prefixIcon,
    Color? iconColor,
  }) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: formBackgroundColor,
      prefixIcon: prefixIcon != null 
        ? Icon(prefixIcon, color: iconColor ?? Colors.grey) 
        : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
    );
  }
} 
import 'package:flutter/material.dart';

/// Clase que proporciona temas coherentes para todos los módulos microfrontend
class SharedThemeProvider {
  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withAlpha(31);
  static final Color _darkFocusColor = Colors.white.withAlpha(31);

  /// Tema claro para toda la aplicación
  static ThemeData lightThemeData = themeData(lightColorScheme, _lightFocusColor);
  
  /// Tema oscuro para toda la aplicación
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  /// Crear un ThemeData con el esquema de colores y el color de enfoque dados
  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: _textTheme,
      // Matches manifest.json colors and background color.
      primaryColor: const Color(0xFF030303),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.primary),
      ),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      canvasColor: colorScheme.surface,
      scaffoldBackgroundColor: colorScheme.surface,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          _lightFillColor.withAlpha(204),
          _darkFillColor,
        ),
        contentTextStyle: _textTheme.titleMedium!.apply(color: _darkFillColor),
      ),
    );
  }

  /// Esquema de colores claro
  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFFd21e1d),
    primaryContainer: Color(0xFF9e1718),
    secondary: Color(0xFFEFF3F3),
    secondaryContainer: Color(0xFFFAFBFB),
    surface: Color(0xFFFAFBFB),
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: _lightFillColor,
    onSecondary: Color(0xFF322942),
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
  );

  /// Esquema de colores oscuro
  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFFFF8383),
    primaryContainer: Color(0xFF1CDEC9),
    secondary: Color(0xFF4D1F7C),
    secondaryContainer: Color(0xFF451B6F),
    surface: Color(0xFF1F1929),
    error: _darkFillColor,
    onError: _darkFillColor,
    onPrimary: _darkFillColor,
    onSecondary: _darkFillColor,
    onSurface: _darkFillColor,
    brightness: Brightness.dark,
  );

  //static const _light = FontWeight.w300;
  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;

  /// Tema de texto con fuentes Poppins
  static final TextTheme _textTheme = TextTheme(
    headlineMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 20.0,
      fontWeight: _bold
    ),
    bodySmall: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16.0,
      fontWeight: _semiBold
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16.0,
      fontWeight: _medium
    ),
    titleMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16.0,
      fontWeight: _medium
    ),
    labelSmall: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 12.0,
      fontWeight: _medium
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14.0,
      fontWeight: _regular
    ),
    titleSmall: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14.0,
      fontWeight: _medium
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16.0,
      fontWeight: _regular
    ),
    titleLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16.0,
      fontWeight: _bold
    ),
    labelLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14.0,
      fontWeight: _semiBold
    ),
  );

  /// Configuración de botones redondeados
  static ButtonStyle roundedButtonStyle({
    Color backgroundColor = Colors.blue,
    Color textColor = Colors.white,
    double elevation = 0,
    EdgeInsetsGeometry? padding,
  }) {
    return ElevatedButton.styleFrom(
      foregroundColor: textColor,
      backgroundColor: backgroundColor,
      elevation: elevation,
      padding: padding ?? const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    );
  }
} 
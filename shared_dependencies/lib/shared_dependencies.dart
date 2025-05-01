library shared_dependencies;

// Solo exportamos las dependencias necesarias y evitamos conflictos
export 'package:flutter/material.dart' show 
  // Widgets básicos
  Widget, StatelessWidget, StatefulWidget, State, SizedBox, Center, Text, SingleChildScrollView,
  // Controladores y clases de forma
  TextEditingController, InputDecoration, TextField, TextFormField, TextInputType, TextInputAction,
  // Decoración y estilo
  ThemeData, ColorScheme, TextTheme, TextStyle, InputDecoration, Scaffold, Column, Stack, Padding,
  // Contexto y localización
  BuildContext, Locale, LocalizationsDelegate, Localizations,
  // Otros
  Color, EdgeInsets, Key, Icon, IconData, Icons, ButtonStyle, TextButton, MainAxisSize, Colors,
  MainAxisAlignment, CrossAxisAlignment, Size, BorderRadius, BorderSide, OutlineInputBorder, 
  CircularProgressIndicator, FocusNode, FocusScope, FractionalOffset, MaterialTapTargetSize, 
  WidgetsBinding, Theme, Align, Visibility;

// Exportamos los providers y localizaciones
export 'package:flutter_localizations/flutter_localizations.dart';

// Exportamos MobX sin conflictos
export 'package:mobx/mobx.dart' hide Interceptor, Interceptors, Action, Listener, Listenable;
export 'package:flutter_mobx/flutter_mobx.dart' hide version;

// Exportamos GetIt para inyección de dependencias
export 'package:get_it/get_it.dart';

// Exportamos SharedPreferences para almacenamiento local
export 'package:shared_preferences/shared_preferences.dart';

// Exportamos el sistema de localización 
export 'src/localization/app_localization.dart';

// Exportamos el proveedor de temas compartido
export 'src/theme/theme_provider.dart';

// Exportamos el bus de eventos y los eventos
export 'src/events/global_event_bus.dart';
export 'src/events/language_events.dart';
export 'src/events/theme_events.dart';
export 'src/events/user_events.dart';

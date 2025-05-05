#!/bin/bash

# Script para crear un nuevo microfrontend en la arquitectura
# Requiere: yq, flutter
set -e

# Funciones auxiliares para formateo de nombres
to_pascal() {
  echo "$1" | sed -E 's/(^|_)([a-z])/\U\2/g'
}

to_title() {
  echo "$1" | sed -E 's/(^|_)([a-z])/\U\2/g' | sed -E 's/_/ /g'
}

# Verificar requisitos
if ! command -v yq &> /dev/null; then
  echo "❌ Error: 'yq' no está instalado."
  echo "Para instalar:"
  echo "  • macOS: brew install yq"
  echo "  • Linux: snap install yq o pip install yq"
  echo "  • Windows: choco install yq o scoop install yq"
  exit 1
fi

if ! command -v flutter &> /dev/null; then
  echo "❌ Error: 'flutter' no está instalado."
  exit 1
fi

# Pedir nombre del módulo
read -p "Nombre del módulo (en minúsculas, p. ej. 'payments'): " module_name

# Validar nombre del módulo (solo letras minúsculas, números y guiones bajos)
if ! [[ $module_name =~ ^[a-z0-9_]+$ ]]; then
  echo "❌ Error: El nombre debe contener solo letras minúsculas, números y guiones bajos."
  exit 1
fi

# Crear variables derivadas
module_pascal=$(to_pascal "$module_name")
module_title=$(to_title "$module_name")
package_name="mf_$module_name"
package_dir="$package_name"

# Crear el paquete base
echo "📦 Creando paquete flutter '$package_name'..."
flutter create --template=package "$package_dir"

# Navegación a la carpeta del paquete
cd "$package_dir" || exit 1

# Actualizar pubspec.yaml con dependencias básicas
cat > pubspec.yaml << EOF
name: $package_name
description: Módulo de $module_title para la aplicación Boilerplate
version: 0.0.1
publish_to: 'none'

environment:
  sdk: '>=3.0.6 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  
  # Dependencias compartidas
  shared_dependencies:
    path: ../shared_dependencies
    
  # Dependencias específicas
  mobx: ^2.1.4
  flutter_mobx: ^2.0.6+5
  get_it: ^7.2.0
  shared_preferences: ^2.1.0
  dio: ^5.0.0
  json_annotation: ^4.8.1
  go_router: ^12.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.3.3
  mobx_codegen: ^2.2.0
  json_serializable: ^6.7.1

flutter:
  # Configuración vacía inicialmente - añadir assets según sea necesario
EOF

# Crear estructura de carpetas
mkdir -p lib/src/data/api
mkdir -p lib/src/data/datasource
mkdir -p lib/src/data/repository
mkdir -p lib/src/domain/entity
mkdir -p lib/src/domain/repository
mkdir -p lib/src/presentation/screens
mkdir -p lib/src/presentation/store
mkdir -p lib/src/presentation/widgets
mkdir -p lib/src/di

# Crear archivo principal del módulo
cat > lib/$package_name.dart << EOF
library $package_name;

// Exportamos las pantallas principales
export 'src/presentation/screens/${module_name}_screen.dart';

// Exportamos las rutas
export 'src/presentation/routes.dart';

// Exportamos la inyección de dependencias
export 'src/di/${module_name}_module.dart';
EOF

# Crear di/${module_name}_module.dart
cat > lib/src/di/${module_name}_module.dart << EOF
import 'package:get_it/get_it.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

class ${module_pascal}Module {
  static final GetIt _getIt = GetIt.instance;
  static bool _initialized = false;
  
  static Future<void> init() async {
    if (_initialized) return;
    
    // Registrar servicios, repositorios y stores
    // TODO: Implementar inyección de dependencias
    
    _initialized = true;
  }
  
  static void dispose() {
    if (!_initialized) return;
    
    // Limpiar recursos cuando el módulo ya no se use
    // TODO: Implementar limpieza de recursos
    
    _initialized = false;
  }
}
EOF

# Crear presentation/routes.dart
cat > lib/src/presentation/routes.dart << EOF
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:$package_name/src/presentation/screens/${module_name}_screen.dart';

// Nombre de ruta base para este módulo
const String ${module_name}RouteName = '$module_name';

// Rutas para el módulo de $module_title
final List<RouteBase> ${module_name}Routes = [
  GoRoute(
    path: '/$module_name',
    name: ${module_name}RouteName,
    builder: (BuildContext context, GoRouterState state) {
      return const ${module_pascal}Screen();
    },
  ),
];
EOF

# Crear presentation/screens/${module_name}_screen.dart
cat > lib/src/presentation/screens/${module_name}_screen.dart << EOF
import 'package:flutter/material.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

class ${module_pascal}Screen extends StatefulWidget {
  const ${module_pascal}Screen({Key? key}) : super(key: key);

  @override
  State<${module_pascal}Screen> createState() => _${module_pascal}ScreenState();
}

class _${module_pascal}ScreenState extends State<${module_pascal}Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$module_title'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$module_title',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Text(
              'Este es el módulo de $module_title',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
EOF

# Crear README.md
cat > README.md << EOF
# $module_title Microfrontend

Este módulo forma parte de la arquitectura de microfrontends de la aplicación Boilerplate.

## Propósito

Este microfrontend proporciona funcionalidades relacionadas con $module_title para la aplicación principal. Está diseñado para funcionar de forma independiente pero se integra con el shell principal.

## Inicio rápido

### Configuración inicial

1. Asegúrate de tener las dependencias actualizadas:
   \`\`\`
   flutter pub get
   \`\`\`

2. Genera los archivos necesarios (para MobX, etc.):
   \`\`\`
   flutter pub run build_runner build --delete-conflicting-outputs
   \`\`\`

3. Para desarrollo continuo, usa:
   \`\`\`
   flutter pub run build_runner watch --delete-conflicting-outputs
   \`\`\`

### Ejecución de tests

Para ejecutar pruebas unitarias y de widget:
\`\`\`
flutter test
\`\`\`

## Estructura del módulo

\`\`\`
lib/
  ├── src/
  │   ├── data/               # Capa de datos
  │   │   ├── api/            # Clientes API
  │   │   ├── datasource/     # Fuentes de datos
  │   │   └── repository/     # Implementaciones de repositorios
  │   ├── domain/             # Capa de dominio
  │   │   ├── entity/         # Entidades de dominio
  │   │   └── repository/     # Interfaces de repositorios
  │   ├── presentation/       # Capa de presentación
  │   │   ├── screens/        # Pantallas
  │   │   ├── store/          # Stores MobX
  │   │   └── widgets/        # Widgets comunes del módulo
  │   └── di/                 # Inyección de dependencias
  └── $package_name.dart      # Punto de entrada para exportaciones
\`\`\`

## Convenciones

### Rutas

Las rutas en este módulo siguen el patrón:
\`/$module_name/*\`

La navegación debe realizarse a través del sistema de rutas definido en \`routes.dart\`.

### Estado

El estado se gestiona con MobX. Cada tienda se registra en \`${module_name}_module.dart\`.

## Integración con el Shell

### Comunicación entre módulos

Para comunicarse con otros módulos, utiliza el bus de eventos global:

\`\`\`dart
// Escuchar eventos
GlobalEventBus.instance.on<UserLoggedInEvent>().listen((event) {
  // Hacer algo cuando el usuario inicia sesión
});

// Emitir eventos
GlobalEventBus.instance.fire(${module_pascal}Event());
\`\`\`

### Eventos del módulo

Para definir eventos específicos del módulo, crea un archivo en \`src/events/\`:

\`\`\`dart
class ${module_pascal}Event {
  final String data;
  
  ${module_pascal}Event(this.data);
}
\`\`\`

## Comandos útiles

- **Generar código una vez**:
  \`flutter pub run build_runner build --delete-conflicting-outputs\`

- **Generar código continuamente**:
  \`flutter pub run build_runner watch --delete-conflicting-outputs\`

- **Ejecutar tests**:
  \`flutter test\`

- **Análisis de código**:
  \`flutter analyze\`
EOF

# Ejecutar flutter pub get en el paquete nuevo
flutter pub get

# Regresar a la carpeta principal
cd ..

# Actualizar el pubspec.yaml del shell_app para incluir la nueva dependencia
cd shell_app || exit 1

# Comprobar si la dependencia ya existe
if ! grep -q "  $package_name:" pubspec.yaml; then
  # Usar yq para añadir la dependencia
  yq e ".dependencies.\"$package_name\" = {\"path\": \"../$package_dir\"}" -i pubspec.yaml
fi

# Actualizar dependencias del shell
flutter pub get

echo ""
echo "✅ Microfrontend $package_name creado correctamente."
echo "   📁 Carpeta: ./$package_dir"
echo "   📖 Revisa el README.md para empezar a trabajar"
echo "" 
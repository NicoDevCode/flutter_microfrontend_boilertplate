# Arquitectura de Microfrontends en Flutter

Este proyecto utiliza una arquitectura de microfrontends para organizar la aplicación en módulos independientes que pueden desarrollarse, probarse y mantenerse por separado.

## Creación de nuevos módulos

Para crear un nuevo módulo microfrontend, ejecuta el script `create_mf.sh` incluido en la raíz del proyecto:

```bash
./create_mf.sh
```

El script te guiará a través del proceso de creación, pidiendo un nombre para el módulo (por ejemplo, `payments`). El script:

1. Creará un nuevo paquete Flutter en `mf_<nombre>` (ej: `mf_payments`)
2. Configurará la estructura básica siguiendo Clean Architecture
3. Añadirá las dependencias necesarias (MobX, GetIt, etc.)
4. Generará un README con instrucciones específicas para el módulo
5. Actualizará el `shell_app` para incluir el nuevo módulo

### Requisitos previos

Para utilizar el script, necesitarás:

- Flutter instalado y en el PATH
- La herramienta `yq` para manipular archivos YAML

Para instalar `yq`:
- macOS: `brew install yq`
- Linux: `snap install yq` o `pip install yq`
- Windows: `choco install yq` o `scoop install yq`

## Estructura del proyecto

```
flutter_boilerplate_project/
├── shell_app/                  # Aplicación principal (shell)
├── shared_dependencies/        # Dependencias compartidas entre módulos
├── mf_auth/                    # Módulo de autenticación
├── mf_posts/                   # Módulo de posts
├── mf_settings/                # Módulo de configuraciones
├── mf_profile/                 # Módulo de perfil
└── scripts/create_mf.sh                # Script para crear nuevos módulos
```

## Convenciones

### Rutas

Cada módulo define sus propias rutas, siguiendo el patrón:
```
/<nombre-modulo>/*
```

### Comunicación entre módulos

La comunicación entre módulos se realiza a través del `GlobalEventBus` definido en `shared_dependencies`.

### Gestión de estado

Cada módulo utiliza MobX para gestionar su estado interno. Los stores se registran en el método `init()` de la clase `<Nombre>Module` de cada módulo.

## Ejecución

Para ejecutar la aplicación, simplemente abre y ejecuta el proyecto en el directorio `shell_app`:

```bash
cd shell_app
flutter run
``` 
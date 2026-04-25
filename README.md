# GeoSense - Ubicación, Mapas y Sensores

Aplicación móvil desarrollada en Flutter para la Unidad 7 de Aplicaciones Móviles.  
El proyecto integra acceso a la ubicación del dispositivo, visualización de mapas con Google Maps, geofencing básico y lectura de sensores en tiempo real.

## Información del Estudiante

- Nombre: Miguel Rizo  
- Programa: Ingeniería de Sistemas  
- Asignatura: Aplicaciones Móviles  
- Unidad: 7 - Notificaciones, Permisos y Funcionalidades del Dispositivo  

## Objetivo

Desarrollar una aplicación Flutter que permita:

- Solicitar permisos de ubicación correctamente.
- Obtener la posición actual del dispositivo.
- Mostrar un mapa centrado en la ubicación.
- Dibujar un geofencing con radio de 200 metros.
- Actualizar la posición del usuario en tiempo real.
- Leer valores del acelerómetro.
- Detectar agitación del dispositivo.

## Tecnologías y Dependencias

- Flutter SDK 3.19+
- Dart 3.3+
- Android SDK (API 26 mínimo)

Dependencias utilizadas:

```yaml
geolocator: ^11.0.0
permission_handler: ^11.3.0
google_maps_flutter: ^2.6.0
sensors_plus: ^4.0.2
```

## Estructura del Proyecto

```
lib/
 ├── main.dart
 ├── services/
 │    └── location_service.dart
 └── widgets/
      ├── map_view.dart
      └── accelerometer_widget.dart

capturas/
 ├── checkpoint_1_permisos_ubicacion.png
 ├── checkpoint_2_mapa_geofencing.png
 └── checkpoint_3_acelerometro.png
```

## Configuración de Google Maps API Key

1. Ingresar a Google Cloud Console:  
   https://console.cloud.google.com/

2. Crear un proyecto nuevo.

3. Ir a: APIs y servicios → Biblioteca

4. Buscar y habilitar:  
   Maps SDK for Android

5. Ir a: APIs y servicios → Credenciales

6. Crear una nueva Clave de API.

7. Copiar la clave generada.

8. En el proyecto Flutter, abrir el archivo:

```
android/app/src/main/AndroidManifest.xml
```

9. Dentro de la etiqueta `<application>` agregar:

```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="TU_API_KEY_AQUI"/>
```

10. Guardar cambios y ejecutar:

```bash
flutter clean
flutter run
```

## Permisos requeridos

En el archivo `AndroidManifest.xml` agregar:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
```

## Ejecución del Proyecto

Clonar repositorio:

```bash
git clone https://github.com/usuario/apellido-post2-u7.git
```

Entrar al proyecto:

```bash
cd apellido-post2-u7
```

Instalar dependencias:

```bash
flutter pub get
```

Ejecutar la aplicación:

```bash
flutter run
```

## Simulación de ubicación en el emulador

Para probar el movimiento del usuario:

1. Abrir el emulador Android.
2. Hacer clic en los tres puntos (⋮).
3. Ir a Extended Controls.
4. Seleccionar la opción Location.
5. Ingresar coordenadas (latitud y longitud).
6. Presionar Set Location.

Ejemplo:

```
Lat: 4.7110
Lng: -74.0721
```

Resultado esperado:

- El marcador del mapa se actualiza en tiempo real.
- El mapa no se recarga.
- El círculo de geofencing permanece fijo.

## Simulación de sensores

1. Abrir el emulador.
2. Ir a Extended Controls.
3. Seleccionar Sensors.
4. Modificar los valores del acelerómetro.

Resultado esperado:

- Los valores X, Y y Z cambian en tiempo real.
- Se detecta agitación del dispositivo.
- La interfaz cambia de color.

## Evidencia de los Checkpoints

### Checkpoint 1: Permisos y Ubicación

- La aplicación solicita permisos de ubicación al iniciar.
- Se valida si el GPS está activado.
- Se obtiene la ubicación actual.
- El mapa se centra en la posición con zoom 16.
- Se muestra el marcador del usuario.
- Se dibuja un círculo de geofencing de 200 metros.


### Checkpoint 2: Mapa y Geofencing

- El mapa se carga correctamente sin errores.
- No aparece el mensaje "For development purposes only".
- El marcador se actualiza al cambiar la ubicación en el emulador.
- El círculo de geofencing permanece en la posición inicial.
- No se presentan errores en Logcat.


### Checkpoint 3: Sensores en Tiempo Real

- Los valores X, Y y Z del acelerómetro se actualizan en tiempo real.
- Se detecta agitación del dispositivo.
- La tarjeta cambia de color.
- Vuelve a su estado original al detener la agitación.
- No hay errores ni fugas de memoria.



## Commits realizados

```bash
git commit -m "Agrega configuración inicial del proyecto Flutter"
git commit -m "Agrega servicio de ubicación con permission_handler"
git commit -m "Agrega mapa con marcador y geofencing"
git commit -m "Agrega acelerómetro en tiempo real"
git commit -m "Agrega capturas y documentación en README"
```

## Conclusión

La aplicación cumple con todos los requerimientos de la actividad:

- Manejo correcto de permisos.
- Integración de geolocalización.
- Visualización de mapas con Google Maps.
- Implementación de geofencing.
- Uso de sensores del dispositivo.
- Manejo adecuado de recursos y streams.

El proyecto se encuentra funcional, organizado y documentado conforme a la rúbrica de evaluación.

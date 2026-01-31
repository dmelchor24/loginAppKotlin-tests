# 🤖 Automatización de Pruebas Android - Login App

## 📋 Descripción del Proyecto

Este proyecto implementa un framework de automatización de pruebas para aplicaciones Android utilizando **Robot Framework** y **Appium**. Está diseñado para probar el flujo de login de una aplicación móvil tanto en entornos locales como en CI/CD.

![Robot Framework Tests](https://github.com/dmelchor24/loginAppKotlin-tests/actions/workflows/robot-appium-tests.yaml/badge.svg)

📊 Reporte de la última ejecución (GitHub Pages)
👉 https://dmelchor24.github.io/loginAppKotlin-tests

## 🏗️ Arquitectura del Proyecto

```
loginApp-tests/
├── 📁 capabilities/          # Configuraciones de Appium por entorno
│   ├── android-local.py      # Configuración para dispositivos físicos
│   └── android-ci.py         # Configuración para emuladores en CI
├── 📁 elementos/             # Page Object Model - Localizadores
│   └── elementos.robot       # Definición de elementos UI
├── 📁 recursos/              # Keywords reutilizables
│   └── common.robot          # Funciones comunes del framework
├── 📁 scripts/               # Scripts de ejecución
│   ├── execute-tests.py      # Orquestador principal de pruebas
│   └── run-tests.sh          # Script bash para CI/CD
├── 📁 tests/                 # Casos de prueba
│   └── login.robot           # Suite de pruebas de login
├── 📁 variables/             # Variables globales
│   └── variables.robot       # Configuración de variables
├── 📁 reports/               # Reportes generados (ignorado en Git)
└── 📁 docs/                  # Reportes para GitHub Pages
```

## 🛠️ Tecnologías Utilizadas

- **Robot Framework**: Framework de automatización de pruebas
- **Appium**: Herramienta de automatización móvil
- **Python**: Lenguaje de scripting y configuración
- **Android SDK**: Herramientas de desarrollo Android
- **GitHub Actions**: CI/CD (Generación del build de la apk y ejecución de pruebas)
- **GitHub Pages**: Publicación de reportes

## 📱 Aplicación Bajo Prueba

- **Paquete**: `com.example.logincompose`
- **Actividad Principal**: `com.example.logincompose.MainActivity`
- **Funcionalidad**: Aplicación de login con campos de email y contraseña

## 🚀 Configuración del Entorno

### Prerrequisitos

1. **Python 3.11**
2. **Node.js 22** (para Appium)
3. **Android SDK**
4. **Java JDK 17**

### Instalación

```bash
# 1. Instalar Appium globalmente
npm install -g appium

# 2. Instalar driver de UiAutomator2
appium driver install uiautomator2

# 3. Instalar dependencias de Python
pip install robotframework
pip install robotframework-appiumlibrary

# 4. Configurar variables de entorno
export ANDROID_HOME=/path/to/android-sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
```

## 🎯 Ejecución de Pruebas

### Entorno Local (Dispositivo Físico)

```bash
# 1. Conectar dispositivo Android via USB
# 2. Habilitar depuración USB
# 3. Verificar conexión
adb devices

# 4. Actualizar deviceName en capabilities/android-local.py
# 5. Ejecutar pruebas
ENV=local python scripts/execute-tests.py
```

### Entorno CI (Emulador)

```bash
# 1. Configurar variable de entorno con ruta del APK
export APK_PATH=/path/to/app.apk

# 2. Ejecutar script completo (incluye setup de emulador)
ENV=ci ./scripts/run-tests.sh
```

## 📊 Reportes

Los reportes se generan automáticamente en:

- **Reportes detallados**: `reports/run_YYYYMMDD_HHMMSS/`
- **GitHub Pages**: `docs/` (accesible vía web)

### Estructura de Reportes

- `report.html`: Reporte principal con resumen ejecutivo
- `log.html`: Log detallado de ejecución paso a paso
- `output.xml`: Datos estructurados en XML
- Capturas de pantalla automáticas en caso de fallos

## 🧪 Casos de Prueba Implementados

### Suite: Login Exitoso
- ✅ **Login exitoso con credenciales válidas**
  - Ingreso de credenciales
  - Verificación de login
  - Logout exitoso

## 🔧 Configuración por Entorno

### Local (android-local.py)
```python
deviceName = "P83X14L1EFA"    # ID del dispositivo físico
appPackage = "com.example.logincompose"
appActivity = "com.example.logincompose.MainActivity"
```

### CI (android-ci.py)
```python
deviceName = "emulator-5554"    # Emulador estándar
avd = "appium"                  # Android Virtual Device
app = APK_PATH                  # Ruta del APK desde variable de entorno
```

## 🚨 Solución de Problemas Comunes

### Error: "Device not found"
```bash
# Verificar dispositivos conectados
adb devices

# Reiniciar servidor ADB
adb kill-server
adb start-server
```

### Error: "Appium server not running"
```bash
# Verificar que Appium esté instalado
appium --version

# Iniciar Appium manualmente para debug
appium --log-level debug
```

### Error: "App not installed"
```bash
# Verificar que la app esté instalada
adb shell pm list packages | grep logincompose

# Instalar manualmente si es necesario
adb install -r app.apk
```

## 🤝 Contribución

### Estructura de Commits
- `feat:` Nueva funcionalidad
- `fix:` Corrección de bugs
- `docs:` Documentación
- `test:` Nuevos casos de prueba
- `refactor:` Refactorización de código

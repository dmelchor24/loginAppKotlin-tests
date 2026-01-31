#!/bin/bash

# Automatiza la ejecución de pruebas móvil
# Inicialización de emulador, instalación de APK, inicio de Appium y ejecución de tests

# Terminar el script si cualquier comando falla (modo estricto)
set -e

# La limpieza se ejecuta automáticamente al finalizar el script (éxito o error)
cleanup() {
    echo "🧹 Ejecutando limpieza de recursos..."
    
    # Terminar proceso de Appium si está ejecutándose
    if [ ! -z "$APPIUM_PID" ]; then
        echo "🔴 Terminando Appium (PID: $APPIUM_PID)"
        kill $APPIUM_PID 2>/dev/null || true
    fi
    
    # Terminar emulador Android si está ejecutándose
    echo "🔴 Terminando emulador Android"
    adb -s emulator-5554 emu kill 2>/dev/null || true
}

# Registrar función de limpieza para ejecutarse al salir (éxito o error)
trap cleanup EXIT

echo "🚀 Emulador listo, iniciando ejecución de pruebas"

# Esperar que el dispositivo Android esté disponible para comandos ADB
adb wait-for-device
echo "📱 El dispositivo está disponible"
sleep 5

# Verificar que el emulador esté completamente inicializado (no solo conectado)
echo "🔍 Verificando inicialización completa del emulador..."
while [ "$(adb shell getprop sys.boot_completed 2>/dev/null | tr -d '\r')" != "1" ]; do
    echo "⏳ Esperando que el boot se complete..."
    sleep 2
done
echo "✅ Boot del emulador completado"

# Asegurar que el Package Manager de Android esté listo para instalar aplicaciones
echo "📦 Verificando que Package Manager esté listo..."
adb shell pm path android > /dev/null 2>&1
echo "✅ Package Manager está operativo"

# Instalar el APK en el emulador (flag -r permite reinstalación)
echo "📲 Instalando APK: $APK_PATH"
adb install -r $APK_PATH
echo "✅ APK instalado exitosamente"

# Optimización: instalar el servidor UiAutomator2 antes de iniciar Appium
echo "🔧 Pre-instalando UiAutomator2 Server..."
UIAUTOMATOR2_APK="$HOME/.appium/node_modules/appium-uiautomator2-driver/node_modules/appium-uiautomator2-server/apks/appium-uiautomator2-server-v9.10.5.apk"

if [ -f "$UIAUTOMATOR2_APK" ]; then
    echo "📦 Instalando desde: $UIAUTOMATOR2_APK"
    # Timeout de 120 segundos para la instalación
    timeout 120 adb install -r "$UIAUTOMATOR2_APK" || {
        echo "⚠️ Advertencia: No se pudo pre-instalar UiAutomator2 Server"
        echo "   (Se instalará automáticamente al iniciar la primera sesión)"
    }
else
    echo "⚠️ UiAutomator2 Server no encontrado en ruta esperada"
    echo "   Se instalará automáticamente al iniciar la primera sesión"
fi

# Iniciar Appium en segundo plano con nivel de log mínimo (solo errores)
echo "🚀 Iniciando servidor Appium..."
appium --log-level error &
APPIUM_PID=$!
echo "✅ Appium iniciado con PID: $APPIUM_PID"

# Esperar a que Appium se inicialice completamente, 15 segundos es tiempo suficiente para que el servidor esté listo
echo "⏳ Esperando inicialización completa de Appium..."
sleep 15

# Ejecutar el script de Python que maneja Robot Framework
# Capturar el código de salida para determinar éxito o fallo
echo "🧪 Ejecutando suite de pruebas..."
if python scripts/execute-tests.py; then
    echo "✅ Todas las pruebas pasaron exitosamente"
    exit 0
else
    echo "❌ Algunas pruebas fallaron - revisar reportes para detalles"
    exit 1
fi
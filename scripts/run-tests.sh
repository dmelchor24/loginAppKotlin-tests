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
}

# Registrar función de limpieza para ejecutarse al salir (éxito o error)
trap cleanup EXIT

echo "🚀 Iniciando ejecución de pruebas móviles en Docker"

echo "🔌 Conectando al emulador Android remoto..."
adb connect android-emulator:5555 || true

echo "⏳ Esperando dispositivo Android..."
adb wait-for-device

echo "📱 Dispositivos disponibles:"
adb devices

# Verificar que el emulador esté completamente inicializado (no solo conectado)
echo "🔍 Verificando boot completo del emulador..."
while [ "$(adb shell getprop sys.boot_completed 2>/dev/null | tr -d '\r')" != "1" ]; do
    echo "⏳ Esperando que Android termine de arrancar..."
    sleep 2
done
echo "✅ Emulador completamente iniciado"

# Asegurar que el Package Manager de Android esté listo para instalar aplicaciones
echo "📦 Verificando que Package Manager esté listo..."
adb shell pm path android > /dev/null 2>&1
echo "✅ Package Manager listo"

# Instalar el APK en el emulador (flag -r permite reinstalación)
if [ -z "$APK_PATH" ]; then
    echo "❌ ERROR: Variable APK_PATH no definida"
    exit 1
fi

echo "📲 Instalando APK: $APK_PATH"
adb install -r "$APK_PATH"
echo "✅ APK instalado correctamente"

# Optimización: instalar el servidor UiAutomator2 antes de iniciar Appium
echo "🔧 Verificando UiAutomator2 Server..."
UIAUTOMATOR2_APK="$HOME/.appium/node_modules/appium-uiautomator2-driver/node_modules/appium-uiautomator2-server/apks/appium-uiautomator2-server-v9.10.5.apk"

if [ -f "$UIAUTOMATOR2_APK" ]; then
    echo "📦 Instalando UiAutomator2 Server..."
    timeout 120 adb install -r "$UIAUTOMATOR2_APK" || true
else
    echo "⚠️ UiAutomator2 Server no encontrado, Appium lo instalará automáticamente"
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
echo "🧪 Ejecutando pruebas con Robot Framework..."
python scripts/execute-tests.py
EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
    echo "✅ Todas las pruebas pasaron"
else
    echo "❌ Pruebas fallidas, revisar reportes"
fi

exit $EXIT_CODE
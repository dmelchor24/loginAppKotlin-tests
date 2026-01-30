#!/bin/bash

# Terminar el script si cualquier comando falla
set -e

# Función para cleanup
cleanup() {
    echo "Cleaning up..."
    # Matar Appium si está corriendo
    if [ ! -z "$APPIUM_PID" ]; then
        kill $APPIUM_PID 2>/dev/null || true
    fi
    # Matar emulador si está corriendo
    adb -s emulator-5554 emu kill 2>/dev/null || true
}

# Ejecutar cleanup al salir (éxito o error)
trap cleanup EXIT

echo "Emulator ready, running tests"

# Esperar que el dispositivo esté listo
adb wait-for-device
echo "El dispositivo esta listo"
sleep 5

# ⭐ Verificar que el emulador esté completamente inicializado
echo "Verificando inicialización completa del emulador..."
while [ "$(adb shell getprop sys.boot_completed 2>/dev/null | tr -d '\r')" != "1" ]; do
    echo "Esperando boot completo..."
    sleep 2
done
echo "Boot completado"

# ⭐ Esperar a que el Package Manager esté listo
adb shell pm path android > /dev/null 2>&1
echo "Package Manager está listo"

# Instalar APK
echo "Installing APK: $APK_PATH"
adb install -r $APK_PATH
echo "APK installed successfully"

# ⭐ Pre-instalar el servidor UiAutomator2 con timeout largo
echo "Pre-instalando UiAutomator2 Server..."
UIAUTOMATOR2_APK="$HOME/.appium/node_modules/appium-uiautomator2-driver/node_modules/appium-uiautomator2-server/apks/appium-uiautomator2-server-v9.10.5.apk"

if [ -f "$UIAUTOMATOR2_APK" ]; then
    echo "Instalando desde: $UIAUTOMATOR2_APK"
    timeout 120 adb install -r "$UIAUTOMATOR2_APK" || {
        echo "⚠️ Advertencia: No se pudo pre-instalar UiAutomator2 Server"
    }
else
    echo "⚠️ UiAutomator2 Server no encontrado, se instalará al iniciar sesión"
fi

# Iniciar Appium
echo "Starting Appium"
appium --log-level error &
APPIUM_PID=$!
echo "Appium started with PID: $APPIUM_PID"

# Esperar a que Appium inicie completamente
sleep 15

# Ejecutar tests y capturar el código de salida
echo "Running tests"
if python scripts/execute-tests.py; then
    echo "✅ Tests passed"
    exit 0
else
    echo "❌ Tests failed"
    exit 1
fi
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

# Instalar APK
echo "Installing APK: $APK_PATH"
adb install -r $APK_PATH
echo "APK installed successfully"

# Iniciar Appium
echo "Starting Appium"
appium --log-level error &
APPIUM_PID=$!
echo "Appium started with PID: $APPIUM_PID"

# Esperar a que Appium inicie completamente
sleep 10

# Ejecutar tests y capturar el código de salida
echo "Running tests"
if python scripts/execute-tests.py; then
    echo "✅ Tests passed"
    exit 0
else
    echo "❌ Tests failed"
    exit 1
fi
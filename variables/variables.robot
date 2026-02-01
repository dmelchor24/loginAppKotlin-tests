*** Settings ***
# Importación de librerías necesarias para automatización móvil
Library        AppiumLibrary

*** Variables ***
# URL del servidor Appium donde se ejecutarán las pruebas en ambiente local
#${REMOTE_URL}     http://localhost:4723
${REMOTE_URL}     http://android-emulator:4723

# Usuario y contraseña para casos de prueba de login
${USERNAME}        admin@test.com
${CONTRASENA}      123456

# Estas variables reciben sus valores desde los archivos de capabilities (.py)
# Se inicializan como ${None} y son inyectadas en tiempo de ejecución
${platformName}           ${None}        # Plataforma: Android
${deviceName}             ${None}        # ID del dispositivo o emulador
${automationName}         ${None}        # Framework de automatización: UiAutomator2
${appPackage}             ${None}        # Paquete de la aplicación bajo prueba
${appActivity}            ${None}        # Actividad principal de la aplicación
${avd}                    ${None}        # Android Virtual Device (solo para emulador)
${app}                    ${None}        # Ruta del APK (solo para CI)
${newCommandTimeout}      ${None}        # Timeout entre comandos Appium
${adbExecTimeout}         ${None}        # Timeout para comandos ADB
${autoGrantPermissions}   ${None}        # Otorgar permisos automáticamente
${noReset}                ${None}        # Controla si resetear la app entre pruebas
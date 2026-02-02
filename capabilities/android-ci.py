# Configuración de capacidades para entorno CI/CD (Integración Continua)
import os

# Obtener la ruta del APK desde variable de entorno (requerida en CI)
APK_PATH = os.getenv("APK_PATH")

# Validar que la variable de entorno esté definida
if not APK_PATH:
    raise Exception("APK_PATH no está definido")

# Configuración básica de la plataforma
platformName = "Android"
automationName =  "UiAutomator2"  # Nombre estándar del emulador Android
deviceName = "Android Emulator"      # En Docker no se asume un ID fijo

app = APK_PATH  # Ruta del APK obtenida de variable de entorno

# Variables no utilizadas en CI (se instala APK directamente)
appPackage =  ""       # Se detecta automáticamente desde el APK
appActivity = ""       # Se detecta automáticamente desde el APK

# Timeouts básicos para comandos Appium
newCommandTimeout = 300         # 5 minutos - tiempo máximo entre comandos
adbExecTimeout = 60000          # 60 segundos - timeout para comandos ADB

# Los entornos CI suelen ser más lentos que máquinas locales
uiautomator2ServerInstallTimeout = 60000    # 60 segundos para instalar el servidor UiAutomator2
uiautomator2ServerLaunchTimeout = 60000     # 60 segundos para lanzar el servidor UiAutomator2
androidInstallTimeout = 90000               # 90 segundos para instalar aplicaciones Android

autoGrantPermissions = True     # Otorgar permisos automáticamente
noReset = False                 # Resetear app entre pruebas para estado limpio
disableWindowAnimation = True
ignoreHiddenApiPolicyError = True

# Configuración específica para emulador
avd = ""    # NO usar AVD en Docker

# Estas configuraciones mejoran la estabilidad en entornos automatizados
skipDeviceInitialization = True
skipServerInstallation = False              # Asegurar instalación limpia
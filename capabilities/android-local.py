# Este archivo define las capacidades de Appium para ejecutar pruebas en un dispositivo Android real

# Plataforma objetivo - siempre Android para este proyecto
platformName= "Android"

# ID único del dispositivo físico conectado via USB, para obtener el ID: adb devices
deviceName= "R28M41Q1JFY"

# Paquete de la aplicación bajo prueba (Application Under Test - AUT)
appPackage= "com.example.logincompose"

# Actividad principal que se lanza al abrir la aplicación
appActivity= "com.example.logincompose.MainActivity"

# Framework de automatización para Android (UiAutomator2 es el más moderno)
automationName= "UiAutomator2"

# Variables no utilizadas en entorno local (la app ya está instalada en el dispositivo)
app = ""    # Ruta del APK - no necesaria en local
avd = ""    # Android Virtual Device - no se usa dispositivo físico

newCommandTimeout = 300             # 5 minutos - tiempo máximo entre comandos
adbExecTimeout = 60000              # 60 segundos - timeout para comandos ADB
autoGrantPermissions = True         # Otorgar permisos automáticamente
noReset = False                     # Resetear app entre pruebas para estado limpio
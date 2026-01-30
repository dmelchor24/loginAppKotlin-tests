import os

APK_PATH = os.getenv("APK_PATH")

if not APK_PATH:
    raise Exception("APK_PATH no está definido")

platformName = "Android"
deviceName = "emulator-5554"
automationName =  "UiAutomator2"
avd = "appium"
app = APK_PATH
appPackage =  ""       # no usados en CI
appActivity = ""
newCommandTimeout = 300
adbExecTimeout = 60000
autoGrantPermissions = True
noReset = False

# ⭐ Timeouts aumentados para CI
uiautomator2ServerInstallTimeout = 60000    # 60 segundos para instalar el servidor
uiautomator2ServerLaunchTimeout = 60000     # 60 segundos para lanzar el servidor
androidInstallTimeout = 90000               # 90 segundos para instalar apps

# ⭐ Optimizaciones adicionales para CI
skipServerInstallation = False              # Asegurar instalación limpia
skipDeviceInitialization = False
disableWindowAnimation = True
ignoreHiddenApiPolicyError = True           # Evitar errores en API 29+
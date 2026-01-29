import os

APK_PATH = os.getenv("APK_PATH")

if not APK_PATH:
    raise Exception("APK_PATH no está definido")

platformName = "Android",
deviceName = "emulator-5554",
automationName =  "UiAutomator2",
avd = "appium",
app = "APK_PATH",
appPackage =  "",         # no usados en CI
appActivity = "",
newCommandTimeout = 300,
adbExecTimeout = 60000,
autoGrantPermissions = True,
noReset = False
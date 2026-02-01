*** Settings ***
# Importación de librerías y recursos necesarios
Library        AppiumLibrary                        # Librería principal para automatización móvil
Resource       ../variables/variables.robot         # Variables globales del proyecto
Resource       ../elementos/elementos.robot         # Localizadores de elementos UI

*** Keywords ***
Abrir Aplicacion
    # Utiliza todas las capacidades definidas en el archivo de capabilities correspondiente
    Open Application    
    ...    ${REMOTE_URL}                                    # URL del servidor Appium
    ...    platformName=${platformName}                     # Plataforma objetivo (Android)
    ...    appium:deviceName=${deviceName}                         # ID del dispositivo o emulador
    ...    appium:automationName=${automationName}                 # Framework de automatización (UiAutomator2)
    ...    appium:appPackage=${appPackage}                         # Paquete de la aplicación
    ...    appium:appActivity=${appActivity}                       # Actividad principal
    ...    appium:avd=${avd}                                       # Android Virtual Device (solo emulador)
    ...    appium:app=${app}                                       # Ruta del APK (solo CI)
    ...    appium:newCommandTimeout=${newCommandTimeout}           # Timeout entre comandos
    ...    appium:adbExecTimeout=${adbExecTimeout}                 # Timeout para ADB
    ...    appium:autoGrantPermissions=${autoGrantPermissions}     # Otorgar permisos automáticamente
    ...    appium:noReset=${noReset}                               # Controlar reset de app

Ingresar credenciales validas
    # Ingresa las credenciales de prueba en los campos correspondientes
    Wait Until Element Is Visible     ${TituloAPP}    25s
    Wait Until Element Is Visible     ${Email}        25s
    Wait Until Element Is Visible     ${Password}     25s
    Input Text        ${Email}        ${USERNAME}           # Ingresa email en campo correspondiente
    Input Password    ${Password}     ${CONTRASENA}         # Ingresa contraseña en campo correspondiente
    Capture Page Screenshot        pantalla_login.png       # Captura pantalla para debugging

Hacer Login
    # Ejecuta el proceso de inicio de sesión
    Wait Until Element Is Visible     ${IniciarSesion}    25s
    Capture Page Screenshot        captura_login.png         # Captura pantalla antes del login
    Click Element    ${IniciarSesion}                        # Hace clic en el botón de iniciar sesión

Hacer Logout
    # Ejecuta el proceso de cierre de sesión
    Wait Until Element Is Visible     ${LOGOUT}    25s
    Click Element    ${LOGOUT}              # Hace clic en el botón de cerrar sesión
    
Cerrar Aplicacion
    # Cierra la aplicación y termina la sesión de Appium
    Wait Until Element Is Visible     ${TituloAPP}    25s
    Close Application         # Cierra la conexión con la aplicación
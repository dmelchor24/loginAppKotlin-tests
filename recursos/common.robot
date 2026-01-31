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
    ...    deviceName=${deviceName}                         # ID del dispositivo o emulador
    ...    automationName=${automationName}                 # Framework de automatización (UiAutomator2)
    ...    appPackage=${appPackage}                         # Paquete de la aplicación
    ...    appActivity=${appActivity}                       # Actividad principal
    ...    avd=${avd}                                       # Android Virtual Device (solo emulador)
    ...    app=${app}                                       # Ruta del APK (solo CI)
    ...    newCommandTimeout=${newCommandTimeout}           # Timeout entre comandos
    ...    adbExecTimeout=${adbExecTimeout}                 # Timeout para ADB
    ...    autoGrantPermissions=${autoGrantPermissions}     # Otorgar permisos automáticamente
    ...    noReset=${noReset}                               # Controlar reset de app

Ingresar credenciales validas
    # Ingresa las credenciales de prueba en los campos correspondientes
    #Sleep    25                                             # Espera para que la UI se estabilice
    Input Text        ${Email}        ${USERNAME}           # Ingresa email en campo correspondiente
    Input Password    ${Password}     ${CONTRASENA}         # Ingresa contraseña en campo correspondiente
    Capture Page Screenshot        pantalla_login.png       # Captura pantalla para debugging

Hacer Login
    # Ejecuta el proceso de inicio de sesión
    #Sleep    25                                              # Espera para que la UI se estabilice
    Capture Page Screenshot        captura_login.png         # Captura pantalla antes del login
    Click Element    ${IniciarSesion}                        # Hace clic en el botón de iniciar sesión

Hacer Logout
    # Ejecuta el proceso de cierre de sesión
    #Sleep     25                            # Espera para que la UI se estabilice
    Click Element    ${LOGOUT}              # Hace clic en el botón de cerrar sesión
    
Cerrar Aplicacion
    # Cierra la aplicación y termina la sesión de Appium
    #Sleep     25              # Espera para que cualquier proceso termine
    Close Application         # Cierra la conexión con la aplicación
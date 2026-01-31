*** Settings ***
Library        AppiumLibrary
Resource       ../variables/variables.robot
Resource       ../elementos/elementos.robot

*** Keywords ***
Abrir Aplicacion
    Open Application    
    ...    ${REMOTE_URL}
    ...    platformName=${platformName}
    ...    deviceName=${deviceName}
    ...    automationName=${automationName}
    ...    appPackage=${appPackage}
    ...    appActivity=${appActivity}
    ...    avd=${avd}
    ...    app=${app}
    ...    newCommandTimeout=${newCommandTimeout}
    ...    adbExecTimeout=${adbExecTimeout}
    ...    autoGrantPermissions=${autoGrantPermissions}
    ...    noReset=${noReset}

Ingresar credenciales validas
    Sleep    25
    Input Text        ${Email}        ${USERNAME}
    Input Password        ${Password}     ${CONTRASENA}
    Capture Page Screenshot        debug_screen.png
Hacer Login
    Sleep    25
    Capture Page Screenshot        captura_login.png
    Click Element    ${IniciarSesion}

Hacer Logout
    Sleep     25
    Click Element    ${LOGOUT}
    
Cerrar Aplicacion
    Sleep     25
    Close Application
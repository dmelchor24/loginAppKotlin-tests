*** Settings ***
Library        AppiumLibrary

*** Variables ***

${TituloAPP}        xpath=//android.widget.TextView[@text='App de Testing']
${Email}            xpath=//android.widget.EditText[.//android.widget.TextView[@text='Correo Electrónico']]
${Password}         xpath=//android.widget.EditText[.//android.widget.TextView[@text='Contraseña']]
#${IniciarSesion}    //android.view.View[@clickable='true' and @bounds='[63,1325][1017,1472]']
${IniciarSesion}    xpath=//*[@content-desc='login_button']



${BIENVENIDA}       xpath=//android.widget.TextView[@text='¡Bienvenido!']
#${LOGOUT}           //android.view.View[@clickable='true' and @bounds='[63,1447][1017,1573]']
${LOGOUT}           xpath=//*[@content-desc='logout_button']

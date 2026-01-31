*** Settings ***
Library        AppiumLibrary

*** Variables ***

${TituloAPP}        //android.widget.TextView[@text='App de Testing']
${Email}            //android.widget.EditText[.//android.widget.TextView[@text='Correo Electrónico']]
${Password}         //android.widget.EditText[.//android.widget.TextView[@text='Contraseña']]
#${IniciarSesion}    //android.view.View[@clickable='true' and @bounds='[63,1325][1017,1472]']
${IniciarSesion}    (//android.view.View[@clickable='true'])[4]



${BIENVENIDA}       //android.widget.TextView[@text='¡Bienvenido!']
#${LOGOUT}           //android.view.View[@clickable='true' and @bounds='[63,1447][1017,1573]']
${LOGOUT}           (//android.view.View[@clickable='true'])[3]

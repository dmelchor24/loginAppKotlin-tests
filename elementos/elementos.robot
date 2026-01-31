*** Settings ***
Library        AppiumLibrary

*** Variables ***

${TituloAPP}        xpath=//android.widget.TextView[@text='App de Testing']
${Email}            xpath=//android.widget.EditText[@password='false' and .//android.widget.TextView[@text='Correo Electrónico']]
${Password}         xpath=//android.widget.EditText[@password='true' and .//android.widget.TextView[@text='Contraseña']]
${IniciarSesion}    xpath=//android.view.View[@clickable='true' and @package='com.example.logincompose' and .//android.widget.TextView[@text='Iniciar Sesión']]

${BIENVENIDA}       xpath=//android.widget.TextView[@text='¡Bienvenido!']
${LOGOUT}           xpath=//android.view.View[@clickable='true' and @package='com.example.logincompose' and .//android.widget.TextView[@text='Cerrar Sesión']]
*** Settings ***
# Importación de librerías necesarias para automatización móvil
Library        AppiumLibrary

*** Variables ***
# Título principal de la aplicación - usado para verificar que la app se abrió correctamente
${TituloAPP}        xpath=//android.widget.TextView[@text='App de Testing']

# Campo de entrada para el correo electrónico
${Email}            xpath=//android.widget.EditText[@password='false' and .//android.widget.TextView[@text='Correo Electrónico']]

# Campo de entrada para la contraseña
${Password}         xpath=//android.widget.EditText[@password='true' and .//android.widget.TextView[@text='Contraseña']]

# Botón para iniciar sesión
${IniciarSesion}    xpath=//android.view.View[@clickable='true' and @package='com.example.logincompose' and .//android.widget.TextView[@text='Iniciar Sesión']]

# Mensaje de bienvenida - usado para verificar login exitoso
${BIENVENIDA}       xpath=//android.widget.TextView[@text='¡Bienvenido!']

# Botón para cerrar sesión
${LOGOUT}           xpath=//android.view.View[@clickable='true' and @package='com.example.logincompose' and .//android.widget.TextView[@text='Cerrar Sesión']]
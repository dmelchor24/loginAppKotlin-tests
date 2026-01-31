*** Settings ***
# Importación de librerías necesarias para automatización móvil
Library        AppiumLibrary

*** Variables ***
# Título principal de la aplicación - usado para verificar que la app se abrió correctamente
${TituloAPP}        xpath=//*[@content-desc="login_title"]

# Campo de entrada para el correo electrónico
${Email}            xpath=//android.widget.EditText[.//*[@content-desc="email_input"]]

# Campo de entrada para la contraseña
${Password}         xpath=//android.widget.EditText[.//*[@content-desc="password_input"]]

# Botón para iniciar sesión
${IniciarSesion}    xpath=//*[@content-desc="login_button"]

# Mensaje de bienvenida - usado para verificar login exitoso
${BIENVENIDA}       xpath=//*[@content-desc="home_title"]

# Botón para cerrar sesión
${LOGOUT}           xpath=//*[@content-desc="logout_button_main"]
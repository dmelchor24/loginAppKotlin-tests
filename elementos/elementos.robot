*** Settings ***
Library        AppiumLibrary

*** Variables ***

${TituloAPP}        xpath=//*[@content-desc='login_title']
${Email}            xpath=//*[@content-desc='email_input']
${Password}         xpath=//*[@content-desc='password_input']
${IniciarSesion}    xpath=//*[@content-desc='login_button']

${BIENVENIDA}       xpath=//*[@content-desc='home_title']
${LOGOUT}           xpath=//*[@content-desc='logout_button']
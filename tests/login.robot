*** Settings ***
Library        AppiumLibrary
Resource       ../recursos/common.robot

Default Tags    pruebas mobile

Suite Setup       Abrir Aplicacion
Suite Teardown    Cerrar Aplicacion

*** Test Cases ***
Login exitoso con credenciales validas
    Ingresar credenciales validas
    Hacer Login
    Hacer Logout
    
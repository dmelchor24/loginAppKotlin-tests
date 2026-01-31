*** Settings ***
# Importación de librerías y recursos necesarios
Library        AppiumLibrary                # Librería principal para automatización móvil
Resource       ../recursos/common.robot     # Keywords reutilizables del proyecto

# Etiquetas por defecto para todos los casos de prueba en esta suite
Default Tags    pruebas mobile

# Configuración de la suite de pruebas
Suite Setup       Abrir Aplicacion        # Se ejecuta UNA VEZ antes de todos los tests
Suite Teardown    Cerrar Aplicacion       # Se ejecuta UNA VEZ después de todos los tests

*** Test Cases ***
Login exitoso con credenciales validas
    [Documentation]    Verifica que un usuario puede iniciar y cerrar sesión con credenciales válidas
    Ingresar credenciales validas        # Ingresa email y contraseña de prueba
    Hacer Login                          # Ejecuta el proceso de login
    Hacer Logout                         # Ejecuta el proceso de logout
    
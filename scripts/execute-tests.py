#!/usr/bin/env python3

import time
import subprocess
import os
import sys
import shutil

# Obtener la ruta base del proyecto (directorio padre del script)
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# Definir el entorno de ejecución desde variable de entorno
# Por defecto: "local" (para desarrollo)
# En CI/CD: "ci" (para integración continua)
ENV = os.getenv("ENV", "ci")
cap_file = f"android-{ENV}.py"

# Validar que el archivo de capabilities existe
cap_path = os.path.join(BASE_DIR, "capabilities", cap_file)
if not os.path.exists(cap_path):
    raise FileNotFoundError(f"❌ No existe el archivo de capabilities: {cap_path}")

print(f"🔧 Usando capabilities para entorno: {ENV}")
print(f"📁 Archivo de capabilities: {cap_file}")

# Crear timestamp para identificar unívocamente esta ejecución
# Formato: YYYYMMDD_HHMMSS (ej: 20240128_143052)
timestamp = time.strftime("%Y%m%d_%H%M%S")
print(f"🕐 Timestamp de ejecución: {timestamp}")

# Nombres de archivos de salida con timestamp para evitar sobreescritura
report_file = f"report_{timestamp}.html"    # Reporte principal de Robot Framework
log_file = f"log_{timestamp}.html"          # Log detallado de ejecución
output_file = f"output_{timestamp}.xml"     # Archivo XML con resultados estructurados

# Directorio específico para esta ejecución (con timestamp)
reports_dir = os.path.join(BASE_DIR, "reports", f"run_{timestamp}")
# Directorio para GitHub Pages (archivos estáticos)
docs_dir = os.path.join(BASE_DIR, "docs")

# Crear directorios si no existen
os.makedirs(reports_dir, exist_ok=True)
os.makedirs(docs_dir, exist_ok=True)

print(f"📁 Directorio de reportes: {reports_dir}")
print(f"📁 Directorio de docs: {docs_dir}")

# Comando completo para ejecutar Robot Framework con todas las configuraciones
command = [
    sys.executable, "-m", "robot",          # Ejecutar Robot Framework como módulo
    "--variablefile", cap_path,             # Inyectar variables desde archivo de capabilities
    "--outputdir", reports_dir,             # Directorio de salida para todos los archivos
    "--report", report_file,                # Nombre del archivo de reporte HTML
    "--log", log_file,                      # Nombre del archivo de log HTML
    "--output", output_file,                # Nombre del archivo de salida XML
    "tests"                                 # Directorio que contiene los casos de prueba
]

print("🚀 Iniciando ejecución de Robot Framework...")
print(f"📋 Comando: {' '.join(command)}")

# Ejecutar Robot Framework capturando el resultado sin hacer crash inmediato
# Esto permite procesar reportes incluso si algunas pruebas fallan
try:
    result = subprocess.run(command, check=False)           # check=False previene excepción automática
    exit_code = result.returncode
    print(f"🏁 Robot Framework terminó con código: {exit_code}")
except Exception as e:
    print(f"💥 Error ejecutando Robot Framework: {e}")
    exit_code = 1

# Ruta completa al archivo de reporte generado
report_path = f"{reports_dir}/{report_file}"

# Procesar reportes solo si se generaron correctamente
if os.path.exists(report_path):
    print("📊 Procesando reportes generados...")
    
    # Modificar el reporte HTML para que las referencias apunten a nombres estándar
    # Esto es necesario para GitHub Pages que espera nombres fijos
    with open(report_path, "r", encoding="utf-8") as f:
        report_content = f.read()

    # Reemplazar referencias con timestamps por nombres estándar
    report_content = report_content.replace(log_file, "log.html")
    report_content = report_content.replace(output_file, "output.xml")

    # Guardar el reporte modificado
    with open(report_path, "w", encoding="utf-8") as f:
        f.write(report_content)

    # Copiar archivos al directorio docs/ con nombres estándar para GitHub Pages
    print("🌐 Copiando reportes HTML...")
    shutil.copy(f"{reports_dir}/{report_file}", f"{docs_dir}/index.html")
    shutil.copy(f"{reports_dir}/{log_file}", f"{docs_dir}/log.html")
    shutil.copy(f"{reports_dir}/{output_file}", f"{docs_dir}/output.xml")

    # Copiar los screenshots a docs
    print("🖼️ Copiando screenshots al directorio docs/...")

    for file in os.listdir(reports_dir):
        if file.lower().endswith((".png", ".jpg", ".jpeg", ".webp")):
            shutil.copy(
                os.path.join(reports_dir, file),
                os.path.join(docs_dir, file)
            )

    # Almacenar el timestamp de la última ejecución para referencia
    with open(f"{docs_dir}/.last_run.txt", "w") as f:
        f.write(timestamp)

    print("✅ Robot Framework - Ejecución completada")
    print("📄 Reportes y screenshots publicados correctamente en GitHub Pages")
else:
    print("⚠️ No se generó reporte HTML")
    print("   Posible fallo en la inicialización o configuración")
    print("   Revisar logs de Appium y configuración de capabilities")

# Salir con el mismo código que Robot Framework para CI/CD
print(f"🏁 Finalizando con código de salida: {exit_code}")
sys.exit(exit_code)
import time
import subprocess
import os
import sys
import shutil

# Base del proyecto
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# Entorno Local / CI
ENV = os.getenv("ENV", "ci")         # Modificar dependiendo el entorno a utilizar
cap_file = f"android-{ENV}.py"

cap_path = os.path.join(BASE_DIR, "capabilities", cap_file)

if not os.path.exists(cap_path):
    raise FileNotFoundError(f"❌ No existe el archivo de capabilities: {cap_path}")

# Creación de timestamp
timestamp = time.strftime("%Y%m%d_%H%M%S")

# Definir nombres de archivos
report_file = f"report_{timestamp}.html"
log_file = f"log_{timestamp}.html"
output_file = f"output_{timestamp}.xml"

# Definir directorios
reports_dir = f"reports/run_{timestamp}"
docs_dir = "docs"

os.makedirs(reports_dir, exist_ok=True)
os.makedirs(docs_dir, exist_ok=True)

# Ejecutar Robot Framework
command = [
    sys.executable, "-m", "robot",
    "--variablefile", cap_path,
    "--outputdir", reports_dir,
    "--report", report_file,
    "--log", log_file,
    "--output", output_file,
    "tests"
]

# ⭐ Capturar el resultado sin hacer crash inmediato
try:
    result = subprocess.run(command, check=False)  # check=False para no lanzar excepción
    exit_code = result.returncode
except Exception as e:
    print(f"Error ejecutando tests: {e}")
    exit_code = 1

# Referencia del archivo de log dentro del reporte
report_path = f"{reports_dir}/{report_file}"

# Solo hacer esto si el reporte existe
if os.path.exists(report_path):
    with open(report_path, "r", encoding="utf-8") as f:
        report_content = f.read()

    report_content = report_content.replace(log_file, "log.html")
    report_content = report_content.replace(output_file, "output.xml")

    with open(report_path, "w", encoding="utf-8") as f:
        f.write(report_content)

    # Copiar a docs/ para GitHub Pages
    shutil.copy(f"{reports_dir}/{report_file}", f"{docs_dir}/index.html")
    shutil.copy(f"{reports_dir}/{log_file}", f"{docs_dir}/log.html")
    shutil.copy(f"{reports_dir}/{output_file}", f"{docs_dir}/output.xml")

    # Almacena el ultimo timestamp ejecutado
    with open(f"{docs_dir}/.last_run.txt", "w") as f:
        f.write(timestamp)

    print("✅ Robot Framework ejecución completada")
    print("📄 Report publicado correctamente en GitHub Pages")
else:
    print("No se generó reporte (posible fallo en inicialización)")

# ⭐ Salir con el código correcto
sys.exit(exit_code)
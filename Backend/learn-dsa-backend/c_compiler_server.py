from flask import Flask, request, jsonify
import subprocess
import os
import re
import shutil  # Ellenőrzéshez

app = Flask(__name__)

# Ellenőrizzük, hogy a szükséges programok elérhetők-e
def check_requirements():
    if not shutil.which("gcc"):
        print("❌ Hiba: A 'gcc' nincs telepítve. Telepítsd a fordítót!")
        exit(1)  # Kilépünk, ha nincs telepítve

# Ellenőrzi, hogy az include könyvtárak elérhetők-e
def check_includes(code):
    include_pattern = re.compile(r'#include\s+<([\w.]+)>')
    includes = include_pattern.findall(code)

    missing_includes = []
    for lib in includes:
        result = subprocess.run(
            ["gcc", "-E", "-"],
            input=f"#include <{lib}>\n",
            capture_output=True,
            text=True
        )
        if result.returncode != 0:
            missing_includes.append(lib)

    return missing_includes

@app.route('/compile', methods=['POST'])
def compile_code():
    data = request.json
    code = data.get("code", "")

    if not code:
        return jsonify({"error": "No code provided"}), 400

    # Ellenőrizzük az include könyvtárakat
    missing_libs = check_includes(code)
    if missing_libs:
        return jsonify({"error": f"Hiányzó könyvtárak: {', '.join(missing_libs)}"}), 400

    try:
        # Writing out the code to a file
        with open("temp.c", "w") as f:
            f.write(code)

        # Compiling with gcc and detailed errors
        compile_process = subprocess.run(
            ["gcc", "-Wall", "-Wextra", "temp.c", "-o", "temp.out"],
            capture_output=True, text=True
        )

        if compile_process.returncode != 0:
            errors = format_errors(compile_process.stderr)
            return jsonify({"errors": errors}), 400

        # Running and output reading
        run_process = subprocess.run(["./temp.out"], capture_output=True, text=True)

        return jsonify({"output": run_process.stdout})

    except Exception as e:
        return jsonify({"error": str(e)}), 500

def format_errors(stderr_output):
    """
    Hibák formázása, hogy szépen nézzenek ki és mutassák a sor- és oszlopszámokat.
    """
    error_list = []
    
    # Template: temp.c:3:5: error: expected ';' before 'return'
    error_pattern = re.compile(r"temp\.c:(\d+):(\d+): (.+)")

    for line in stderr_output.split("\n"):
        match = error_pattern.search(line)
        if match:
            line_num, col_num, message = match.groups()
            error_list.append(f"Sor {line_num}: {message.strip()}")

    return error_list if error_list else ["Ismeretlen fordítási hiba történt."]

if __name__ == '__main__':
    check_requirements()  # Először ellenőrizzük a függőségeket
    app.run(debug=True, host="0.0.0.0", port=5000)

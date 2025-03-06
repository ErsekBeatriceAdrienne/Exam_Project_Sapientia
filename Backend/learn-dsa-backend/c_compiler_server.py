# pip install flask

from flask import Flask, request, jsonify
import subprocess
import os

app = Flask(__name__)

@app.route('/compile', methods=['POST'])
def compile_code():
    data = request.json
    code = data.get("code", "")

    if not code:
        return jsonify({"error": "No code provided"}), 400

    try:

        with open("temp.c", "w") as f:
            f.write(code)

        # Compiling with gcc
        compile_process = subprocess.run(["gcc", "temp.c", "-o", "temp.out"], capture_output=True, text=True)
        
        if compile_process.returncode != 0:
            return jsonify({"error": compile_process.stderr}), 400

        # Running and output reading
        run_process = subprocess.run(["./temp.out"], capture_output=True, text=True)
        
        return jsonify({"output": run_process.stdout})

    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0", port=5000)

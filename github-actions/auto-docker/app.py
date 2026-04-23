# app.py
from flask import Flask
import datetime
import socket

app = Flask(__name__)

@app.route('/')
def home():
    return {
        "message": "Auto deployed by GitHub Actions!",
        "time": str(datetime.datetime.now()),
        "server": socket.gethostname(),
        "version": "v2.0"
    }

@app.route('/health')
def health():
    return {"status": "healthy"}

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

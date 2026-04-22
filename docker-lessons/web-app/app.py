# app.py — Real Python web server using Flask
from flask import Flask
import datetime
import socket
import platform

app = Flask(__name__)

@app.route('/')
def home():
    return f"""
    <html>
    <head>
        <title>My DevOps App</title>
        <style>
            body {{
                background: #0D1117;
                color: #E6EDF3;
                font-family: monospace;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }}
            .card {{
                background: #161B22;
                border: 1px solid #30363D;
                border-radius: 10px;
                padding: 40px;
                text-align: center;
            }}
            h1 {{ color: #58A6FF; }}
            p  {{ color: #8B949E; }}
            .green {{ color: #3FB950; }}
        </style>
    </head>
    <body>
        <div class="card">
            <h1>🐳 Running inside Docker!</h1>
            <p>Time &nbsp;&nbsp;&nbsp;: {datetime.datetime.now()}</p>
            <p>Hostname : {socket.gethostname()}</p>
            <p>OS &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: {platform.system()}</p>
            <p class="green">✅ Web app is live!</p>
        </div>
    </body>
    </html>
    """

@app.route('/health')
def health():
    return {{"status": "healthy", "time": str(datetime.datetime.now())}}

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

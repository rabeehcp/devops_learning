# app.py — Flask app that connects to Redis
from flask import Flask
import redis
import datetime
import socket

app = Flask(__name__)

# Connect to Redis container
# 'redis' is the container name in docker-compose
cache = redis.Redis(host='redis', port=6379)

@app.route('/')
def home():
    # Count visits using Redis
    visits = cache.incr('visits')
    return f"""
    <html>
    <head>
        <title>Docker Compose App</title>
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
                border-radius: 12px;
                padding: 50px;
                text-align: center;
                min-width: 400px;
            }}
            h1 {{ color: #58A6FF; }}
            .count {{ 
                font-size: 60px; 
                color: #3FB950;
                font-weight: bold;
            }}
            p {{ color: #8B949E; }}
        </style>
    </head>
    <body>
        <div class="card">
            <h1>🐳 Docker Compose App</h1>
            <p>Total page visits:</p>
            <div class="count">{visits}</div>
            <p>Stored in Redis container!</p>
            <p>Server: {socket.gethostname()}</p>
            <p>Time: {datetime.datetime.now().strftime('%H:%M:%S')}</p>
        </div>
    </body>
    </html>
    """

@app.route('/health')
def health():
    return {{"status": "healthy", "visits": int(cache.get('visits') or 0)}}

@app.route('/reset')
def reset():
    cache.set('visits', 0)
    return {{"status": "reset", "visits": 0}}

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)

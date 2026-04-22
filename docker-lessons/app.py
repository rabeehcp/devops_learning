# app.py — Simple Python app we will dockerize
import datetime
import platform
import socket

print("=" * 40)
print("  🐳 Hello from Docker Container!")
print("=" * 40)
print(f"  Time     : {datetime.datetime.now()}")
print(f"  Hostname : {socket.gethostname()}")
print(f"  OS       : {platform.system()} {platform.release()}")
print(f"  Python   : {platform.python_version()}")
print("=" * 40)
print("  App is running inside a container!")
print("=" * 40)

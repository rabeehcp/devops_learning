# Dockerfile for Flask Web App

# Base image — Linux + Python
FROM python:3.11-slim

# Who made this
LABEL maintainer="rabeehcp"

# Set working directory inside container
WORKDIR /app

# COPY requirements first (smart caching!)
# Docker caches this layer — only re-runs if requirements.txt changes
COPY requirements.txt .

# Install Python libraries
RUN pip install -r requirements.txt

# NOW copy your app code
COPY app.py .

# Tell Docker this container listens on port 5000
EXPOSE 5000

# Run the web server when container starts
CMD ["python", "app.py"]

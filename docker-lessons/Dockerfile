# Dockerfile
# Every line is an INSTRUCTION for Docker

# FROM — which base image to start with
# Like choosing which OS to install first
FROM python:3.11-slim

# LABEL — metadata about this image
LABEL maintainer="rabeehcp"
LABEL description="My first Docker container"

# WORKDIR — set working directory inside container
# Like doing: cd /app inside the container
WORKDIR /app

# COPY — copy files from your computer INTO container
# COPY <source on your machine> <destination in container>
COPY app.py .

# CMD — command to run when container starts
# This runs our python script
CMD ["python", "app.py"]

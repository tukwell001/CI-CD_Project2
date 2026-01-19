name: CI/CD Pipeline to Push Docker Image to Docker Hub

on:
  push:
    branches:
      - main

jobs:
  build-and-push:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Log in to Docker Hub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}

      - name: Build and push Docker image (Docker action)
        id: docker_build
        uses: docker/build-push-action@v5
        with:
          context: .
          push: true
          tags: ${{ secrets.DOCKER_USERNAME }}/Dockerfile:3.11-slim

      - name: Fallback manual build and push
        if: failure()
        run: |
          docker build -t ${{ secrets.DOCKER_USERNAME }}/Dockerfile:3.11-slim .
          echo "${{ secrets.DOCKER_PASSWORD }}" | docker login -u "${{ secrets.DOCKER_USERNAME }}" --password-stdin
          docker push ${{ secrets.DOCKER_USERNAME }}/Dockerfile:3.11-slim

          

# # Use an official base image
# FROM python:3.11-slim

# # Set working directory inside container
# WORKDIR /app

# # Copy application files
# COPY . .

# # Install dependencies (if requirements.txt exists)
# RUN pip install --no-cache-dir -r requirements.txt

# # Run the application
# CMD ["python", "app.py"]

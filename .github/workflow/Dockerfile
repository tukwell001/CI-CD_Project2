# Use an official base image
FROM python:3.11-slim

# Set working directory inside container
WORKDIR /app

# Copy application files
COPY . .

# Install dependencies (if requirements.txt exists)
RUN pip install --no-cache-dir -r requirements.txt

# Run the application
CMD ["python", "app.py"]

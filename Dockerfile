# Use modern Python image
FROM python:3.10-slim

# Prevent Python from writing .pyc files and enable unbuffered logs
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Copy only dependency file first (for Docker cache efficiency)
COPY requirements.txt .

# Upgrade pip and install dependencies
RUN apt-get update && apt-get install -y gcc && \
    pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt && \
    apt-get remove -y gcc && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

# Copy project files
COPY . .

# Expose port 5000 for Flask
EXPOSE 5000

# Command to start app
CMD ["python3", "app.py"]

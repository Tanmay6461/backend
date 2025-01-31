# Use the official Python 3.10-slim image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    FASTAPI_PORT=8000

# Set the working directory in the container
WORKDIR /app

# Install system dependencies (if needed)
RUN apt-get update && apt-get install -y gcc libffi-dev build-essential && rm -rf /var/lib/apt/lists/*

# Copy and install dependencies separately to leverage Docker cache
COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install  -r requirements.txt --timeout 1000

# Copy the rest of the application code
COPY . /app/

# Expose FastAPI port
EXPOSE 8000

# Command to run the FastAPI application
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]


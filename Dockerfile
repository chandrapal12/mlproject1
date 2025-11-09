# Use small, stable base
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Install system dependencies for ML libs
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential gcc g++ python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy dependency list and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy only essential files
COPY src ./src
COPY app.py .
COPY setup.py .
COPY templates ./templates
COPY artifacts_dir/preprocessor.pkl artifacts_dir/model.pkl ./artifacts_dir/

# Expose Flask port
EXPOSE 5000

# Default command
CMD ["python", "app.py"]

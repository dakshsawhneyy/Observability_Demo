pip install flask prometheus_client

################################## Create App
from flask import Flask
from prometheus_client import Counter, generate_latest

app = Flask(__name__)

REQUEST_COUNT = Counter('http_requests_total', 'Total HTTP Requests')

@app.route('/')
def home():
    REQUEST_COUNT.inc()
    return "Hello from Python App!"

@app.route('/metrics')
def metrics():
    return generate_latest()

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)


curl localhost:5000
curl localhost:5000/metrics

################## Dockerfile
# Stage 1
FROM python:3.10 AS builder

# Create an app directory
WORKDIR /app

COPY requirements.txt .
# Install Dependencies
RUN pip install --no-cache-dir -r requirements.txt 

COPY app.py app.py

# Stage 2: Production
FROM python:3.10-slim
WORKDIR /app

# Copying the required dependencies
COPY --from=builder /usr/local /usr/local
COPY --from=builder /app /app

# Run the application
CMD ["python", "app.py"]

#########################################
# Docker Compose
version: '3'

services:
  app:
    build: .
    ports:
      - "5000:5000"

  prometheus:
    image: prom/prometheus
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml

  grafana:
    image: grafana/grafana
    ports:
      - "3001:3000"

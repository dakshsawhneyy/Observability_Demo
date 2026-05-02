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


###############################
# Prometheus Config

global:
  scrape_interval: 5s

scrape_configs:
  - job_name: 'python-app'
    static_configs:
      - targets: ['app:5000']


###############################
PROMETHEUS UI

Open:
- http://localhost:9090

Query:
- http_requests_total

########### generate traffic
for i in {1..50}; do curl localhost:5000; done


################## grafana
GRAFANA (VISUAL PART)

Open: http://localhost:3001
Login: admin/admin
Add Prometheus datasource

Create dashboard:
    Query:
        - http_requests_total

# Metrics
rate(http_requests_total[1m])


#####################
# Add Latency Metric

from prometheus_client import Histogram

REQUEST_LATENCY = Histogram(
    'http_request_latency_seconds',
    'Latency of HTTP requests in seconds',
    buckets=(0.1, 0.3, 0.5, 1.0, 2.0)
)

# Wrap your endpoint
@app.route('/')
def home():
    with REQUEST_LATENCY.time():
        time.sleep(random.uniform(0.1, 1.5))  # simulate delay
        return "Hello"

# Query
rate(http_request_latency_seconds_count[1m])

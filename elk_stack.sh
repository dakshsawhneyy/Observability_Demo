What is Observability?

Observability is the ability to understand what’s happening inside a system by looking at its outputs.

Three Pillers

Logs → detailed events (what happened)
Metrics → numbers over time (how much/how often)
Traces → request journey (where it happened)

Example:
- Food delivery app crash
-- Metrics: spike in errors
-- Traces: slow API
-- Logs: actual error message

##############################

Logging

Why Logs Matter:
- Debugging issues
- Monitoring system health
- Security auditing
- Compliance

Problem: Distributed Systems

What happens when you have 50 microservices?”

Problems:
- Logs scattered across servers
- Different formats
- Hard to correlate events
- Time-consuming debugging

Example: 

User places order → fails

Where do you check?
- frontend logs?
- API logs?
- payment logs?
- database logs?
This becomes chaos.

##################################

Solution: Centralized Logging

“Bring all logs into one place.”

Benefits:
- Single source of truth
- Real-time monitoring
- Faster debugging
- Easy search & filtering
- Better security tracking

##################################
ELK Stack  

Elasticsearch
- Stores logs
- Super fast search
- JSON-based
Think: “Google for your logs”

Logstash
- Collects logs
- Transforms them
- Sends to Elasticsearch
Think: “Log processor”

Kibana
- Visualizes logs
- Dashboards & charts
Think: “UI for logs”

FileBeat
- Lightweight agents on servers
- Send logs to Logstash


Flow Diagram
Servers → Beats → Logstash → Elasticsearch → Kibana

Real Example:
User login failure:

App generates log
Filebeat ships log
Logstash parses JSON
Elasticsearch indexes it
Kibana shows dashboard


##################### Demo
Launch Two Instances -- ELK and Server

Install Java (Required for Elasticsearch & Logstash)

# Elastic Search
Install Elastic Search

# Configure Elasticsearch
sudo vi /etc/elasticsearch/elasticsearch.yml 

# Modify: 
network.host: 0.0.0.0  # Makes Elasticsearch listen on all network interfaces
cluster.name: my-cluster # Defines the name of the Elasticsearch cluster
node.name: node-1 # Gives a unique name to this node
discovery.type: single-node # “Run as a single-node cluster”

# Why Cluster ?
# Data is too big, queries are too fast, and systems must not fail.

# A cluster is a group of machines (nodes) working together as one system.

sudo systemctl start elasticsearch 
sudo systemctl enable elasticsearch 
sudo systemctl status elasticsearch 


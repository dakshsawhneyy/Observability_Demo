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

# Elastic Search is reacheable or not
curl -k -u elastic https://localhost:9200
sudo /usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic

####### LogStash
sudo apt install logstash -y

# Configure Logstash to Accept Logs
sudo vi /etc/logstash/conf.d/logstash.conf

input { 
  beats { 
    port => 5044 
  } 
} 
filter { 
  grok { 
    match => { "message" => "%{TIMESTAMP_ISO8601:log_timestamp} %{LOGLEVEL:log_level} %{GREEDYDATA:log_message}" } 
  } 
} 
output { 
  elasticsearch { 
    hosts => ["http://localhost:9200"] 
    index => "logs-%{+YYYY.MM.dd}" 
  } 
  stdout { codec => rubydebug } 
} 

sudo systemctl start logstash 
sudo systemctl enable logstash 
sudo systemctl status logstash

# Allow Traffic on Port 5044 
sudo ufw allow 5044/tcp 

#################### Kibana
sudo apt install kibana -y 

# Configure Kibana
sudo vi /etc/kibana/kibana.yml 

# Modify: 
server.host: "0.0.0.0" 
elasticsearch.hosts: ["http://localhost:9200"] 

sudo systemctl start kibana 
sudo systemctl enable kibana 
sudo systemctl status kibana 

# Allow Traffic on Port 5601 
sudo ufw allow 5601/tcp 

# Open a browser and go to: 
http://<ELK_Server_Public_IP>:5601 

sudo /usr/share/elasticsearch/bin/elasticsearch-reset-password -u kibana_system
sudo journalctl -u kibana -n 50

sudo /usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic

################### Application

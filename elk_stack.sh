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
Stores logs
Super fast search
JSON-based

👉 Think: “Google for your logs”

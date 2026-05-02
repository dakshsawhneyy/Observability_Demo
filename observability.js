// Express App
const express = require('express');
const app = express();

app.get('/', (req, res) => {
  console.log("Request received");
  console.log("User logged in");
  // console.log("Payment failed");
  // console.error("DB connection timeout");
  res.send("Hello");
});

app.listen(3000);

// Run app and show logs

// ########################################
Stress CPU Usage

- sudo apt install stress
- stress --cpu 4 --timeout 60
- stress --vm 1 --vm-bytes 1G --timeout 60s

// ###################
User → API → Auth → DB → Payment

// ###############
// Scenario: 
“Your API response time jumped from 100ms → 2 seconds”
“What do you check first?”

Metrics
-- Latency graph spikes
-- Request count maybe increased
 Detect problem

Logs
Look for:
-- DB connection timeout
-- Slow query detected
 Find symptoms

Traces
See request path:
-- API → DB (2s delay)
 Root cause = DB slow

“Metrics told us something is wrong
Logs told us what is wrong
Traces told us where it is wrong”

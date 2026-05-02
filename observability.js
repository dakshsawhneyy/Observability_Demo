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

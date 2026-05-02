// Express App
const express = require('express');
const app = express();

app.get('/', (req, res) => {
  console.log("Request received");
  console.log("User logged in");
  console.log("Payment failed");
  console.log("DB connection timeout");
  res.send("Hello");
});

app.listen(3000);

// Run app and show logs

// ########################################


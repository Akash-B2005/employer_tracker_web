const express = require('express');
const cors = require('cors');
const app = express();

app.use(cors());

const location = {
  name: "Test User",
  latitude: 12.9716,
  longitude: 77.5946,
  time: "10:25:30",
  status: "Online",
  address: "Bangalore",
  speed: 35,
  battery: 90
};

app.get('/location', (req, res) => {
    res.json(location);
});

app.listen(3000, () => {
    console.log('Server is running on port 3000');
});


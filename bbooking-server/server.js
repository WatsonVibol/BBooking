const express = require('express');
const app = express();
app.use(express.json());

let bookings = [];

app.get('/bookings', (req, res) => {
    res.json(bookings);
});

app.post('/bookings', (req, res) => {
    const booking = req.body;
    bookings.push(booking);
    res.status(201).send();
});

app.listen(3000, () => console.log('Server listening on port: 3000'));



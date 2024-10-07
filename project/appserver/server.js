const express = require('express');
const app = express();
const PORT = 3000;


// Sample route
app.get('/', (req, res) => {
    res.send('Hello, World!');
});

// Get a greeting
app.get('/greet', (req, res) => {
    res.send('Hello, User!');
});

// Post example
app.post('/data', (req, res) => {
    console.log(req.body);
    res.send('Data received!');
});


// Start the server
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});

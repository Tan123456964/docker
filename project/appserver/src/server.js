const express = require('express');
const pool = require('./sqldb');

const app = express();
const PORT = 8080;

// API for fetching cat pictures
app.get('/api/cat', async (req, res) => {
    const query = 'SELECT * FROM cat';
    try {
        const [results] = await pool.query(query);
        res.json(results);
    } catch (error) {
        console.error('Error fetching cat data:', error);
        res.status(500).send('Server error');
    }
});

// API for fetching profile info
app.get('/api/profile', async (req, res) => {
    const query = 'SELECT * FROM profile';
    try {
        const [results] = await pool.query(query);
        res.json(results);
    } catch (error) {
        console.error('Error fetching profile data:', error);
        res.status(500).send('Server error');
    }
});

// API for fetching resumes
app.get('/api/resume', async (req, res) => {
    const query = 'SELECT * FROM resume';
    try {
        const [results] = await pool.query(query);
        res.json(results);
    } catch (error) {
        console.error('Error fetching resume data:', error);
        res.status(500).send('Server error');
    }
});

// API for fetching achievements
app.get('/api/achievement', async (req, res) => {
    const query = 'SELECT * FROM achievement';
    try {
        const [results] = await pool.query(query);
        res.json(results);
    } catch (error) {
        console.error('Error fetching achievement data:', error);
        res.status(500).send('Server error');
    }
});


//////////
// Start the server
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});

const express = require('express');
const getConnection = require('./sqldb');
const logger = require('./logger');

const app = express();
const PORT = 3000;

app.get('/api/cat', (req, res) => {
  const connection = getConnection();
  const query = 'SELECT * FROM project.cat';

  logger.info({ message: `Executing query: ${query}` });

  connection.query(query, (err, result) => {
    if (err) {
      logger.error({ message: `Query failed: ${err.message}` });
      connection.destroy();
      return res.status(500).send('Server error');
    }

    logger.info({ message: 'Query successful: /api/cat' });
    res.json(result);
    connection.destroy();
  });
});

app.get('/api/profile', (req, res) => {
  const connection = getConnection();
  const query = 'SELECT * FROM project.profile';

  logger.info({ message: `Executing query: ${query}` });

  connection.query(query, (err, result) => {
    if (err) {
      logger.error({ message: `Query failed: ${err.message}` });
      connection.destroy();
      return res.status(500).send('Server error');
    }

    logger.info({ message: 'Query successful: /api/profile' });
    res.json(result);
    connection.destroy();
  });
});

app.get('/api/resume', (req, res) => {
  const connection = getConnection();
  const query = 'SELECT * FROM project.resume';

  logger.info({ message: `Executing query: ${query}` });

  connection.query(query, (err, result) => {
    if (err) {
      logger.error({ message: `Query failed: ${err.message}` });
      connection.destroy();
      return res.status(500).send('Server error');
    }

    logger.info({ message: 'Query successful: /api/resume' });
    res.json(result);
    connection.destroy();
  });
});

app.get('/api/achievement', (req, res) => {
  const connection = getConnection();
  const query = 'SELECT * FROM project.achievement';

  logger.info({ message: `Executing query: ${query}` });

  connection.query(query, (err, result) => {
    if (err) {
      logger.error({ message: `Query failed: ${err.message}` });
      connection.destroy();
      return res.status(500).send('Server error');
    }

    logger.info({ message: 'Query successful: /api/achievement' });
    res.json(result);
    connection.destroy();
  });
});

app.listen(PORT, () => {
  logger.info({ message: `Server running at http://localhost:${PORT}` });
});

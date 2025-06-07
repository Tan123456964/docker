const mysql = require('mysql2');
const logger = require('./logger');

function getConnection() {

  const connection = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    port: process.env.DB_PORT,
  });

  connection.connect(err => {
    if (err) {
      logger.error({ message: `DB connection failed: ${err.stack}` });
    } else {
      logger.info({ message: `DB connected: threadId ${connection.threadId}` });
    }
  });

  return connection;
}

module.exports = getConnection;

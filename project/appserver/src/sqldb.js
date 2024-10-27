const mysql = require('mysql2');

const pool = mysql.createPool({
    host: 'mysql',
    user: 'appuser',
    password: 'apppassword',
    database: 'onlinestore',
    port: 3306,
    waitForConnections: true,
    connectionLimit: 4, // Maximum number of connections in the pool
    queueLimit: 0 // Unlimited queue limit for pending requests
});

module.exports = pool.promise(); // Use promise-based for async/await support

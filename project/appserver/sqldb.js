import { createConnection } from 'mysql';

// Create a connection to the MySQL database
const connection = createConnection({
    host: 'mysql', // Use the service name defined in Docker Compose
    user: 'appuser', // MySQL user
    password: 'apppassword', // MySQL password
    database: 'onlinestore' // MySQL database name
});

// Connect to the MySQL database
connection.connect(err => {
    if (err) {
        console.error('Error connecting to MySQL:', err);
        return;
    }
    console.log('Connected to MySQL database');
});

// Export the connection for use in other modules
export default connection;

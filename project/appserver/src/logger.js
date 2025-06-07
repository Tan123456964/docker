const winston = require('winston');

const logger = winston.createLogger({
  level: 'info',
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.errors({ stack: true }), // capture stack traces
    winston.format.printf(info => {
      const { timestamp, level, message, ...extra } = info;

      return JSON.stringify({
        timestamp,
        level,
        message,
        ...extra  // includes requestId, error stack, custom fields, etc.
      });
    })
  ),
  transports: [new winston.transports.Console()]
});

module.exports = logger;

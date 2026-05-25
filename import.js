const fs = require('fs');
const mysql = require('mysql2');

const connection = mysql.createConnection({
  host: 'maglev.proxy.rlwy.net',
  user: 'root',
  password: 'SjMscCRiczEAXcfVxJAnNqJdizjpNbPi',
  database: 'railway',
  port: 3306
});

const sql = fs.readFileSync('backup.sql', 'utf8');

connection.query(sql, (err) => {
  if (err) throw err;
  console.log('Import success');
  connection.end();
});
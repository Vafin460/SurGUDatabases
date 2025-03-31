const mysql = require('mysql');

module.exports = {
    host : '127.0.0.1',
    user : 'root',
    password : '',
    database : 'slonyratwitter'
}

function conn(){
    const connection = mysql.createConnection(module.exports)
    connection.connect();

    let query = "SELECT * FROM `users`";

    connection.query(query, function(error, result){
        console.log(result);
    });

    connection.end();
}

conn();

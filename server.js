var express = require('express');
var http = require('http');
var path = require('path');
var socketIO = require('socket.io');
var app = express();
var server = http.Server(app);
var io = socketIO(server);

const mysql = require('mysql');
const { error } = require('console');

max_allowed_packet = 2000000000;

module.exports = {
    host: '127.0.0.1',              // ip адрес хоста на котором стоит sql сервер
    user: 'root',                   // имя пользователя под которым идёт авторизация на сервере
    password: '',                   // пароль (если есть)
    database: 'slonyratwitter'      // имя базы данных
};

function regisr(log, name, pass) {
    const connection = mysql.createConnection(module.exports)
    connection.connect();

    let query = `INSERT INTO users (id, login, name, pass) VALUES (NULL, '${log}', '${name}', '${pass}') `

    connection.query(query, function (error, result) {
        console.log(result);
    });

    connection.end();
};

function newPost(sessionUserId, nPost) {
    const connection = mysql.createConnection(module.exports)
    connection.connect();

    Data = new Date();

    Year = Data.getFullYear();
    Month = Data.getMonth();
    Day = Data.getDate();
    Hours = Data.getHours();
    Minut = Data.getMinutes();

    let today = `${Year}-${Month}-${Day} ${Hours}:${Minut}`;

    console.log(today);

    let query = `INSERT INTO posts (id, postUserId, postText, postDate) VALUES (NULL, '${sessionUserId}', '${nPost}', NOW())`;

    connection.query(query, function (error, result) {
        console.log(error);
        console.log(result);
    });
    connection.end();
};

app.set('port', 5000);
app.use('/static', express.static(__dirname + '/static'));

app.get('/', function (request, response) {
    response.sendFile(path.join(__dirname, 'index.html'));
});

server.listen(5000, function () {
    console.log('Запускаю сервер на порте 5000');
});


io.on("connection", (socket) => {
    socket.on("getAllPost", (sessionId) => {
        const connection = mysql.createConnection(module.exports)
        connection.connect();

        let query = `SELECT posts.id, users.name, posts.postText, posts.postDate, posts.parent_id, COALESCE(SUM(likes.liketype), 0) AS total_likes, lik.likeType AS likedTypeById FROM posts JOIN users ON posts.postUserId = users.id LEFT JOIN likes ON posts.id = likes.postId LEFT JOIN likes AS lik ON posts.id = lik.postId AND lik.userId = '${sessionId}' GROUP BY posts.id, users.name, posts.postText, posts.postDate, posts.parent_id, lik.likeType ORDER BY posts.id DESC`;

        connection.query(query, function (error, result) {
            console.log(result);
            socket.emit("allPost", (result));
            //console.log("Все посты отправлены");
        });

        connection.end();
    });

    socket.on("reg", (regLogin, regName, regPass) => {
        regisr(regLogin, regName, regPass);
        console.log("reg");
    });

    socket.on("login", (logLogin, logPass) => {
        console.log("login");
        const connection = mysql.createConnection(module.exports)
        connection.connect();
        var id;
        let query = `SELECT users.id FROM users WHERE users.login = '${logLogin}' AND users.pass = '${logPass}'`

        connection.query(query, function (error, result) {
            console.log(error);
            console.log(result);
            try{
                socket.emit("authorised", (result[0].id));
            }
            catch (error){
                socket.emit("authorised", (-1));
            }
        });
        connection.end();
    });


    socket.on("newPost", (sessionUserId, nPost) => {
        console.log("login");
        newPost(sessionUserId, nPost);
        io.emit("updatePost", 1);
    });

    socket.on("likePost", (postId, userId, likeType) => {
        const connection = mysql.createConnection(module.exports)
        connection.connect();

        let query2 = `DELETE FROM likes WHERE likes.postId = '${postId}' AND likes.userId = '${userId}'`;
        let query =  `INSERT INTO likes (postId, userId, likeType) VALUES ('${postId}', '${userId}', '${likeType}');`
        connection.query(query2, function (error, result) {
            
        });
        connection.query(query, function (error, result) {
            io.emit("updatePost", 1);
        });
        connection.end();
    });
});
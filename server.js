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

    let query = `INSERT INTO users (usId, usLogin, usName, usPass) VALUES (NULL, '${log}', '${name}', '${pass}') `

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

    let query = `INSERT INTO posts (postId, postUserId, postText, postDate) VALUES (NULL, '${sessionUserId}', '${nPost}', NOW())`;

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
    socket.on("getAllPost", () => {
        const connection = mysql.createConnection(module.exports)
        connection.connect();

        let query = `SELECT posts.postId, users.usName, posts.postText, postDate FROM posts JOIN users ON posts.postUserId = users.usId ORDER BY posts.postId DESC`;

        connection.query(query, function (error, result) {
            console.log(result);
            socket.emit("allPost", (result));
            //console.log("Все посты отправлены");
        });

        connection.end();
    });

    socket.on("reg", (regLogin, regName, regPass) => {
        conn();
        regisr(regLogin, regName, regPass);
        console.log("reg");
    });

    socket.on("login", (logLogin, logPass) => {
        console.log("login");
        const connection = mysql.createConnection(module.exports)
        connection.connect();
        var id;
        let query = `SELECT users.usId FROM users WHERE users.usLogin = '${logLogin}' AND users.usPass = '${logPass}'`

        connection.query(query, function (error, result) {
            console.log(error);
            console.log(result);
            try{
                socket.emit("authorised", (result[0].usId));
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
});
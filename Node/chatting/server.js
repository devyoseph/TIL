var app = require('express')();
var http = require('http').Server(app);
var socket = require('socket.io');
var io = socket(http);

//client가 최초 접속 시  보여지는 화면
app.get('/', function(req, res){
    res.sendFile(__dirname + '/index.html');
});

//서버 실행
http.listen(3000, function(){
    console.log('server listening on port : 3000');
});


var userList = [];


io.on('connection', function(socket){
    userList.push(socket);
    var joindUser = false;
    var nickname;

    // 유저 입장
    socket.on('join', function(){
        console.log('유저가 입장했습니다.');

    });

    // 메시지 전달
    socket.on('send', function(msg){
        console.log(msg);
        userList.forEach(function(item, i) {
            console.log(item.id);
            if (item != socket) {
                item.emit('send', msg);
            }
        });
    });

    // 접속 종료
    socket.on('disconnect', function(){
        console.log('유저가 나갔습니다.');
        userList.splice(userList.indexOf(socket), 1);
    });

});
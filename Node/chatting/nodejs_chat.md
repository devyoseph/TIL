## node.js와 socket.io를 활용한 채팅 server/client 구현

​                     

### 1. 환경 구축

> node.js를 먼저 다운 받고 npm 명령어를 통해 express와 socket.io 설치

#### 1) [node.js 설치](https://nodejs.org/ko/about)

* 설치 후 작업할 폴더로 들어간다. 이후 다음 코드를 실행

  ```bash
  $ npm init
  ```

* Enter를 치다가 `entry point`가 나오면 `server.js`를 입력한다.

* `package.json` 파일이 만들어진다.

​                 

#### 2) [Express 설치](https://expressjs.com/ko/)

* `package.json`이 만들어졌다면 다음 코드를 입력한다.

  ```bash
  $ npm install express
  ```

  

#### 3) [Socket.io 설치](https://socket.io/docs/v4/)

* `socket.io` 라이브러리를 설치한다.

  ```bash
  $ npm install socket.io
  ```

* 참고

  ```bash
  $ npm install express socket.io # 동시 설치 가능
  ```

  ​            

### 2. 라이브러리 연결 및 화면 생성

​            

#### 1) server.js 생성

* `package.json`이 있는 곳에 `server.js` 파일을 생성한다.

  ```js
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
  ```

​            

#### 2) index.html

* socket을 통해 값을 받고 전달한다.

  ```html
  <body>
      <div id="container">
          <div id="chatView">
   
          </div>
          <form id="chatForm" onsubmit="return false">
              <input type="text" id="msg">
              <input type="submit" id="send" value="전송">
          </form>
      </div>
      
   
      <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
      <script src="/socket.io/socket.io.js"></script>
      
      <style>
          #container {
              width: 400px;
              height: 400px;
              border: 1px solid black;
              background: ivory;
          }
          #chatView {
              height: 90%;
              overflow-y: scroll;
          }
          #chatForm {
              height: 10%;
              border-top: 1px solid black;
              text-align: center;
          }
          #msg {
              width: 80%;
              height: 32px;
              border-radius: 8px;
          }
          #send {
              width: 16%;
              height: 34px;
              border-radius: 50px;
              background: rgb(134, 217, 10);
              color: rgb(6, 71, 35);
          }
          .msgLine {
              margin: 15px;
          }
          .msgBox {
              border: 1px solid silver;
              background: paleturquoise;
              padding: 2px 5px;
              border-radius: 10px;
          }
      </style>
  
      <script>
          var socket = io();
          
          var chatView = document.getElementById('chatView');
          var chatForm = document.getElementById('chatForm');
  
          socket.emit('join'); //첫 입장
  
          chatForm.addEventListener('submit', function() {
              var msg = $('#msg');
   
              if (msg.val() == '') {
                  return;
   
              } else {
                  socket.emit('send', msg.val());
   
                  var msgLine = $('<div class="msgLine">');
                  var msgBox = $('<div class="me">');
   
                  msgBox.append(msg.val());
                  msgBox.css('display', 'inline-block');
                  msgLine.css('text-align', 'right');
                  msgLine.append(msgBox);
   
                  $('#chatView').append(msgLine);
              }
          });
  
          socket.on('send', function(msg) {
          var msgLine = $('<div class="msgLine">');
          var msgBox = $('<div class="msgBox">');
                  
          msgBox.append(msg);
          msgBox.css('display', 'inline-block');
   
          msgLine.append(msgBox);
          $('#chatView').append(msgLine);
   
          chatView.scrollTop = chatView.scrollHeight;
      });
      </script>
  </body>
  ```

  

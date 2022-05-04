# Promise

> 자바스크립트 비동기 처리에 사용되는 객체.
> 비동기 처리: 특정 코드의 실행이 완료될 때까지 기다리지 않고 다음 코드를 먼저 수행하는 자바스크립트의 특성

​           

* ajax를 이용한 비동기 처리

  ```js
  function getData(callbackFunc) {
    $.get('url 주소/products/1', function(response) {
      callbackFunc(response); // 서버에서 받은 데이터 response를 callbackFunc() 함수에 넘겨줌
    });
  }
  
  getData(function(tableData) {
    console.log(tableData); // $.get()의 response 값이 tableData에 전달됨
  });
  ```

* Promise 적용

  ```js
  function getData(callback) {
    // new Promise() 추가
    return new Promise(function(resolve, reject) {
      $.get('url 주소/products/1', function(response) {
        // 데이터를 받으면 resolve() 호출
        resolve(response);
      });
    });
  }
  
  // getData()의 실행이 끝나면 호출되는 then()
  getData().then(function(tableData) {
    // resolve()의 결과 값이 여기로 전달됨
    console.log(tableData); // $.get()의 reponse 값이 tableData에 전달됨
  });
  ```

​                   

​                   

### Promise의 3가지 상태(states)

* Pending(대기): 비동기 처리 로직이 아직 완료되지 않은 상태
  * `new Promise(function(resolve, reject){ })` 에서 인자로 받아주기까지의 과정
* Fulfilled(이행): 비동기 처리가 완료되어 프로미스 결과 값을 반환해준 상태
  * 위 Promise 객체 메서드 안에서 `resolve()`를 하는 순간 이행 상태
  * `resolve(data)`내부에 파라미터를 집어넣은 상태로 보낼 수 있다. 
* Rejected(실패): 비동기 처리가 실패하거나 오류가 발생한 상태
  * `reject()`가 호출되면 실패상태

​           

#### - then()

> 위 정의된 getData() 메서드에 .then()을 붙이면 Fullfilled나 Rejected의 반환값을 받아서 일을 처리해줄 수 있다.

* 만약 Fulfilled(resolve( ))로 신호가 온 경우: 그냥 바로 `.then()`에서 받아준다.

```js
getData().then(function(data){
	console.log(data);
})
```

* 만약 Rejected(reject( ))로 신호가 온 경우: 되도록 **catch()**를 사용한다.
  1. `.then()`으로도 `.then().catch()` 로도 받을 수 있다.

```js
getData().then().catch(function(err) {
  console.log(err); // Error: Request is failed
});
```

​		2. `then()`으로 받지만 2번째 인자에서 확인할 수 있다.		

```js
//then()의 두 번째 인자로 에러를 처리하는 코드
getData().then(function() {
  // ...
}, function(err) {
  console.log(err);
});
```

​                    

​                  

### 여러 개의 Promise 연결하기(Promise Chaining)

> 연쇄적으로 연결하고 인자로 계속 집어넣으면 메서드 내에서 연산된 데이터들이 이동한다.
> 즉 동일한 resolve()값이 이동하는 것이 아니라 순서대로 이동하며 이 값이 변경된다.

```js
function getData() {
  return new Promise({
    // ...
  });
}

// then() 으로 여러 개의 프로미스를 연결한 형식
getData()
  .then(function(data) {
    // ...
  })
  .then(function() {
    // ...
  })
  .then(function() {
    // ...
  });
```

​                    

#### - new Promise로 바로 생성해서 사용하기

```js
new Promise(function(resolve, reject){
setTimeout(function() {
resolve(1);
}, 2000);
})
.then(function(result) {
console.log(result); // 1: 이전 보내준 1을 출력
return result + 10; // 1에다 10을 더해서 다음으로 보냄
})
.then(function(result) {
console.log(result); // 11
return result + 20;
})
.then(function(result) {
console.log(result); // 31
});
```

​                      

### 실무 프로미스 연결 사례

> 로그인 정보 받기, 파싱, 인증, 화면 보여주기 등 promise를 통해 로직을 단순화할 수 있다.

```js
getData(userInfo)
  .then(parseValue)
  .then(auth)
  .then(diaplay);
```



​           


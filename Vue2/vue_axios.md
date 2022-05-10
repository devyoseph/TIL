# Axios

> **HTTP 통신: axis**
>
> * Vue에서 권고하는 HTTP 통신 라이브러리는 axios이다.
> * Promise 기반의 HTTP 통신 라이브러리이며 상대적으로 다른 HTTP 통신 라이브러리들에 비해 문서화가 잘되어 있고 API가 다양하다.
> * axios.get(URL) << Promise 객체를 return >> then, catch 사용가능
> * https://github.com/axios/axios

* Promise란 서버에 데이터를 요청하여 받아오는 동작과 같은 비동기 로직 처리에 유용한 자바스크립트 라이브러리이다. 자바스크립트는 단일 스레드로 코드를 처리하기 때문에 특정 로직의 처리가 끝날 때까지 기다려 주지 않는다. 따라서 데이터를 요청하고 받아올 때까지 기다렸다가 화면에 나타나는 로직을 실행해야 할 때 주로 Promise를 활용한다. 그리고 데이터를 받아왔을 때 Promise로 데이터를 화면에 표시하거나 연산을 수행하는 등 특정 로직을 수행한다.

  ```js
  	const promise = new Promise((resolve, reject) => {
              console.log("promise 객체 생성");
              //resolve("성공했습니다.");
              reject("실패했습니다.");
          });
  
          promise
            .then((response) => {
              console.log("then : "+response);
            })
            .catch((error) => {
              console.log("catch : "+error);
            })
            .finally(()=> {
                console.log("finally 실행");
            });
  ```

* **Arrow function을 사용하는 이유**

  * 내부에서 this를 사용할 때 Vue를 가리키기 위해서
  * 만약 안쓰면 closer를 이용해 등록해서 사용해야한다.

​              

### axios 설치

* CDN 방식

  ```js
  <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
  ```

* NPM 방식

  ```bash
  npm install axios
  ```

  ​                 

### axis API

* Axis 대표 API

| API 유형                            | 처리 결과                                                    |
| ----------------------------------- | ------------------------------------------------------------ |
| axis.get('URL주소').then().catch()  | 해당 URL 주소에 대해 HTTP GET 요청을 보냄. 서버에서 보낸 데이터를 정상적으로 받아오면 then() 안에 정의된 로직이 실행되고, 데이터를 받아올 때 오류가 발생하면 catch()에 정의한 로직이 실행 |
| axis.post('URL주소').then().catch() | 해당 URL 주소에 대해 HTTP POST 요청을 보냄<br />then()과 catch()는 get 방식과 동일 |
| axis({옵션 속성})                   | HTTP 요청에 대한 자세한 속성들을 직접 정의하여 보낼 수 있다. 데이터 요청을 보낼 URL, HTTP 요청방식 보내는 데이터 유형 등.. |

​              

​                 

### axios API

* axios(config)

  ```js
  // Send a POST request
  axios({
    method: 'post',
    url: '/user/12345',
    data: {
      firstName: 'Fred',
      lastName: 'Flintstone'
    }
  });
  ```

  ```js
  // GET request for remote image in node.js
  axios({
    method: 'get',
    url: 'https://bit.ly/2mTM3nY',
    responseType: 'stream'
  })
    .then(function (response) {
      response.data.pipe(fs.createWriteStream('ada_lovelace.jpg'))
    });
  ```

  ​              

  ​                 

### axios chaining

```js
// 2. axios
        const promise = axios.get(URL);
        console.log("3", promise);

        promise
            .then((response) => {
                console.log("4", response);
                return response.data;
            })
            .then((data) => {
                console.log("5",data);
                return data.id;
            })
            .then((id) => {
                console.log("6",id);
            })
            .catch((error) => {})
            .finally(() => {});
```

​                       

### then 내부에서 비동기 호출

```js
					axios
            .get(URL)
            .then((response) => {
                console.log("1", response.data[4].id);
                return response.data[4].id;
            })
            .then((id) => {
                console.log("2",id);
                return axios.get(`${URL}/${id}`);
            })
            .then((todo) => {
                console.log("3",todo.data.title);
            })
            .catch((error) => {})
            .finally(() => {
                console.log("finally")
            });
```

​                           

### async 와 await

> promise의 then을 여러번 사용하지 않고 메서드에 `async` 비동기 호출마다 `await`를 써주어서 비동기 통신을 한다.

```vue
 <script>
        //뒤에 id 번호를 없애면 목록이 뜨는데, 목록으로 불러온다.
        const URL = "https://jsonplaceholder.typicode.com/todos";
        
        async function getTodo(URL) {
            const response = await axios.get(URL);
            const id = response.data[4].id;
            const todo = await axios.get(`${URL}/${id}`);
            console.log(todo.data.title);
        }

        getTodo(URL).catch((error) => {
            console.log(error);
        });
</script>
```

 
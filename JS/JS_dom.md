# Web Browser와 Window 객체

> Window 객체는 웹 브라우저에서 작동하는 Javascript의 최상위 전역객체이다.
>
> 그 안에는 브라우저와 관련된 여러 객체와 속성, 함수가 있다(**BOM**: Browser Object Model).
>
> 
>
> 동기: 현재 명령문이 끝나고 다음 명령문을 실행함을 반복
>
> 비동기: 현재 실행하지 않고 나중에 호출함(등록의 개념)
>
> ```javascript
> setTimeout(function(){
> 	console.log('end'); //상황: setTimeout은 동기함수지만 비동기 함수를 호출하고 있다.
> }, 2000)
> ```
>
> 

```html
<script>
	console.log(this = window) //script 내에서 this는 곧 window
</script>
```

​           

### 1. 알림창

* alert(): 알림창

  ```javascript
  alert("알림창입니다.");
  ```

* confirm(): 확인/취소창

* prompt(): 브라우저 입력창

​          

### 2. navigator

* 브라우저 정보가 내장된 객체

```javascript
console.log(navigator.userAgent); // 모바일로 들어왔는지 PC로 들어왔는지 확인가능
// 네이버의 경우 모바일로 접속하면 n.naver.com으로 가는 원리
```

​         

### 3. location, history

* location

  ```javascript
  console.log(location); //현재 URL조회
  ```

* location.href

  ```javascript
  console.log(location.href); //자바스크립트의 링크버전
  ```

* location.reload(): 현재페이지 새로고침

* history.back(): 페이지의 뒤로가기

* history.forward(): 페이지의 앞으로 가기

​         

### 4. self, window.open()

* `self` : 자기 자신의 문서를 가르킴

* 새 창을 열 수 있다

```javascript
window.open('URL','창 이름', '특성', 히스토리 대체여부);
```

* 예시

```javascript
window.open("./localURL","winname","top=100,left=100,width=300,height=500");
```

* `opener`의 사용: open()으로 열린 창에서 볼 때 자기를 연 창

```javascript
function send(){ //전송버튼을 누르면 입력한 값의 정보를 가져와 저장하고 opener를 통해 값을 수정
  var msg = document.getElementById("test").value;
  opener.document.getElementById("view").innerHTML = msg; //msg는 사용자가 입력한 메시지
  self.close();
}
```

​        

### 5. setTimeout()

* 지정한 밀리초 시간이 흐른 뒤에 함수를 호출

* `clearTimeout()`: 을 통해 `setTimeout()`함수를 정지

​        

### 6. setInterval()

* 지정한 밀리초 주기마다 함수를 반복적으로 호출

​          

## DOM(Document Object Model)

* HTML과 XML 문서의 구조를 정의하는 API 제공

​       

### 1. createElement(' ');

* Element node 생성

​      

### 2. createTextNode(text);

* Text node 생성: text를 바로 인식해서 가져옴

​         

### 3. appendChild(node);

```javascript
요소명.appendChild(msg); //요소명은 elementById 등으로 가져온 요소
```

​          

### 4. setAttribute(name, value);

```javascript
요소명.setAttribute('src','profile.png');
```

​        

### 5. getAttribute(name);

```javascript
요소명.getAttribute('background-color');
```

​        

### 6. innerHTML / innerText

```javascript
var html = document.getElementById('divHtml');
html.innerHTML = '<h2>Hello<h2>' //html문을 인식한 언어로 변경
html.textHTML = '<h2>ddd<h2>' //인식을 못하고 전체를 텍스트로 인식
```

​            

### 7. 문서의 객체 가져오기 

| 함수명                              | 설명                                                 |
| ----------------------------------- | ---------------------------------------------------- |
| getElementById('id')                | id와 일치하는 객체 얻기                              |
| getElementsByClassName('classname') | class와 일치하는 모든 요소 배열 얻기                 |
| getElementsByTagName('tagname')     | tag(ex:h2)와 일치하는 모든 요소 배열 얻기            |
| getElementsByName(name)             | 태그의 name 속성이 name과 일치하는 element 배열 얻기 |
| querySelector(selector)             | selector에 일치하는 첫번째 element 객체 얻기         |
| querySelectorAll(selector)          | selector에 일치하는 모든 element 배열 얻기           |

​       

### 8. 객체 제거

> 부모 위치에서 자식을 지워주는 것이기 때문에 document.body에서 지워주거나
>
> 부모까지 Import한 다음 
>
> `parent.removeChild('child');` 를 통해 지워야한다. 

* removeChild('childnode');

```javascript
var ss6 = document.querySelector("#ss6");
document.body.removeChild(ss6); //ss6는 자바스크립트로 임포트 된 상태
```


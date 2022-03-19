## Javascript 주의점

​       

### 1. 콜백함수는 처음 실행할 때 로드되므로 파라미터로 함수를 호출하면 로드될 때 실행이 되버림

```javascript
btn.addEventListener("click", view(document.getElementById("test").value));
fuction view(val){
	console.log(val);
}
```

```javascript
//해결
var callback = fuction view(val){
	console.log(val);
} //표현식은 변수 호이스팅이 안되기 때문에 미리 올려놓기

btn.addEventListener("click", callback); //표현식을 이용한 호출
```

​       

### 2. 쿼리셀렉터에 #이나 .을 명시 안하면 Name으로 검색하므로 주의

```javascript
document.querySelector('btn-subscribe'); //이렇게 name으로 검색했을 때 null이 발생해서 검색X

document.querySelector('#btn-subscribe'); //정확히 id인지 class인지 밝힌다
```

* 마찬가지로 getElementById 같은 것으로 가져올 때는 `#`을 쓰지 않도록 주의

```javascript
let poll_ans = document.querySelectorAll("[name='poll-answer']");
```

* `querySelectorAll`을 사용하는 경우 배열 내부에 식으로 적어준다.

​         

### 3. 함수 표현식: Hoisting

```javascript
btn.addEventListener('click', func); //오류 발생: 표현식으로 작성하면 호이스팅이 안되기 때문에 위에 써주어야 함 : 선언문으로 작성하거나 표현식은 맨 위에 작성하기

var func = function(e){
  console.log("함수 호출");
}
```

​          

### 4. 백틱의 사용

* 동적인 타이핑을 위해선 ``` ` ``` 을 활용한다.

```javascript
ans = `이 값은 ${number} 입니다`;
```

​        

### 5. 자바스크립트에서 HTML 내부 text값 넣기

* <button>사이에 텍스트를 넣기 위해서도 자식 태그라고 인식해야한다.

```javascript
    let buttonEl = document.createElement("button");
    buttonEl.setAttribute("class", "button");
    buttonEl.setAttribute("type", "button");

    buttonEl.appendChild(document.createTextNode("삭제"));
		//버튼을 만들고 <button> </button> 이 사이에 값을 넣기 위해 자식을 추가하지만 텍스트로 넣어준다.		

		buttonEl.addEventListener("click", function () {
      pollAnswerList.removeChild(buttonEl.parentElement);
    })
```

​        

### 6. opener는 해당 창을 띄운 부모 객체를 가르킨다.

```javascript
opener.location.reload(); //자식 문서가 수정되고 부모의 값을 바꿀 때 리로드 해주는 역할
```

*  `reload()`를 호출하면 `onload()` 에 들어가 호출한다.

​      

### 7. 텍스트 값을 가져올 때는 innerHTML로 가져오지만 input의 값을 가져올 때는 `.value`를 이용한다.

​         

### 8. localStorage에는 텍스트만 저장할 수 있다.

* 그렇기 때문에 배열은 들어갈 수 없고 `JSON.stringify`로 변환하여 저장해준다.

```javascript
localStorage.setItem("question", question);
localStorage.setItem("answers", JSON.stringify(answerArr));
```

​           

### 9. 반복적으로 태그를 삽입하고 싶다면?

* 백틱을 활용한다.

```javascript
 let poll = ` <div> <div class="poll-title">[당신의 선택]</div>
    <div class="poll-question">${question}</div>
    <div class="poll-answer">
      <ul>` ;

for (let i = 0; i < answerArr.length; i++){ //for문으로 문자열 추가
  poll +=
    `<li><input type="radio" name="poll-answer" value="${answerArr[i]}" /> ${answerArr[i]}</li>`;
}

pollViewDiv.innerHTML = poll; // 그 동안의 문자열의 합을 HTML로 변환해서 넣는다.
```



### 10. 요소 숨기기

* display는 속성이 아니기에 `setAttribute`로 변경할 수 없음을 주의한다.

```css
display : none;
display : block;
을 이용한다
```

```javascript
login.style.display = 'none';
```

​         

### 11. forEach()

* 내부 function의 첫번째 인자는 data, 두번째는 index, 세번째는 자기자신

  ```javascript
  let arr = ["A", "B", "C", "D", "E"];
  
  arr.forEach(function(e, i, obj){ // data / index / 자기자신
    console.log("출력 : ", e, i, obj, obj[i]);
  });
  ```

* jQuery의 .each(function(i,e){ })

  ```javascript
  $("h2").each(function (index, item) {
  			// item 대신 this 사용 가능
  			$(item).addClass("high-light-" + index);
  		});
  ```

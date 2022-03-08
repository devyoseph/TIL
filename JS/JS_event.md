# Event

* mouse, keyboard 이벤트가 대다수

​          

## Frame(UI) 이벤트

* Frame 자체에 대한 이벤트
* load 이벤트가 가장 많이 사용: 문서 및 자원들이 웹 브라우저에 탑재되면 이벤트 수행
* unload: 사용자가 브라우저를 떠날 때 발생하는 이벤트

| 이벤트   | 설명                                                 |
| -------- | ---------------------------------------------------- |
| onload   | Document, image, frame 등이 모두 로딩 되었을 때 발생 |
| onabort  | 이미지 등 내용을 로딩하는 도중 취소 되었을 때 발생   |
| onerror  | 로딩 중 오류가 발생했을 때 발생                      |
| onresize | Document, element의 크기가 변경 되었을 경우 발생     |
| onscroll | Document, element가 스크롤 되었을 때 발생            |
| onselect | 텍스트를 선택 했을 때 발생                           |

​       

## Form 이벤트

* 웹 초기에 지원되어 가장 안정적으로 동작하는 이벤트

| 이벤트   | 설명                                                         |
| -------- | ------------------------------------------------------------ |
| onsubmit | form이 전송될 때 발생                                        |
| onreset  | 입력 form이 reset될 때 발생                                  |
| oninput  | Input 또는 textarea 값이 변경되었을 때 발생                  |
| onchange | Select box, checkbox, radio button의 상태가 변경되었을 때 발생 |
| onfocus  | 포커스가 들어올 때 발생                                      |
| onblur   | 다른 곳으로 포커스가 이동할 때 발생                          |
| onselect | input, textarea에 입력 값 중 일부가 마우스 등 선택될 때 발생 |

​         

## 이벤트 핸들러 등록

​        

### 1. 인라인 이벤트 핸들러

* 자바스크립트 초기의 방식: HTML을 침범한다는 문제점 발생

```javascript
<div onclick="javascript: alert('안녕하세요');">클릭해보세요</div>
```

* 최근 CBD(Component Based Development) 방식의 Angular, React, Vue.js 와 같은 프레임워크/라이브러리에서는 인라인 방식으로 처리
* 여러 개의 함수를 처리 가능

```javascript
<div id="div1" onclick="msg1(); msg2();">클릭해보세요</div>
```

​          

### 2. 이벤트 핸들러 프로퍼티 방식

* HTML과 자바스크립트 코드를 분리 가능하다.

```javascript
<script>

  document.getElementById("div1").onclick = function(){
		alert('안녕하세요');
	};
  
</script>
```

* 단점: 하나의 이벤트 핸들러만 바인딩이 가능하다.

​        

### 3. addEventListener 방식

* 인자: 첫번째는 **이벤트명**, 두번째는 **핸들러(함수)**, 세번째는 **캡쳐링 여부**
* 첫번째 인자에는 `on`을 제거해야한다.

#### 주의사항

* addEventListener 핸들러 내부에 함수를 호출하는 경우 처음 로드할 때 바로 실행해버린다는 문제가 발생한다.
* 해결: 무명함수를 사용해 내부에서 재호출한다.

```javascript
input.addEventListener('blur', function(){
	checkVal(MIN_ID_LENGTH); //무명 함수 내부에서 재호출
});
```

​         

## 버블링/캡쳐링 요약

* 버블링: 이벤트 발생한 요소부터 최상단 객체까지 올라가며 이벤트 검사
* 캡쳐링: 최상단 객체부터 자식요소까지 검사하는 것




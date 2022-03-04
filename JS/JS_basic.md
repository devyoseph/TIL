# JavaScript

> MVC 모델: HTML / CSS / JavaScript
>
> 대부분의 JavaScript Engine은 ECMAScript 표준을 지원한다.
>
> Edition 6까지 표준화됨(class, querySelector 등등)

* 프로토타입 기반(prototype-based) 객체 지향 프로그래밍
* dynamic type 지원
* setInterval() / setTimeout()

​          

​         

## Javascript 선언

> HTML에서 <script> 태그 사용

*  <script> : 내부 어느 곳에서나 선언 가능

  * **<body>안 끝 부분에 둘 것을 권장 = <head>에 두면 초기화 시간이 오래걸림**

  * src: 외부 스크립트 파일의 경로

    ```html
    <script src="hello.js" type="text/javascript">
    console.log("실행되지 않는 구문") <!-- 위 경로의 스크립트 파일에 의해 모두 덮어씌워짐 -->
    </script>
    
    <script> <!--여긴 출력: 덮어씌워지지 않음-->
      hello("new World!!!")
    </script>
    ```

  * type: 생략가능, `text/javascript` 나 `module` 사용

  * 위에서부터 아래로 차례차례 실행한다.

  * **변수 선언** `var` : 맨 뒤에서나, 내부에서 정의해도 전역에서 사용 가능 **(=Hoisting)**

    * 현재 선언문이 해당 Scope의 처음으로 옮겨진 것처럼 동작하는 특성. Ex) `var`, `function`

    ```javascript
    console.log("1 :",x); //출력이 된다
    var x = 10;
    ```

​            

​             

## Javascript 시작

> var 사용을 지양하고 let 이나 const로 변수를 선언한다.

* 주석: `//`  `/* */`

* 변수 선언: `var`, `let`, `const`

  * `let`과 `const`는 재선언이 불가능하다.

* 변수형 조사: `typeof()` 연산자

  ```javascript
   console.log(typeof a); //괄호를 열지 않아도 실행됨: 연산자
   console.log(typeof(a)); //괄호를 열지 않아도 실행됨
  ```

  

​	

### 구구단 출력하기

```javascript
   <script>
        for(let i=2; i<10; i++){
            for(let j=1; j<10; j++){
                console.log(i+" * "+j+" = "+i*j);
            }
        }
    </script>
```

​      

### 시계 구현

```javascript
<script>
  window.onload = function(){
  setInterval(showTime,1000);
	};

  function showTime(){
    let view = document.getElementById("view");
    let date = new Date();
    view.innerHTML = date.toLocaleDateString() + " " + date.toLocaleTimeString();
  }
</script>
```

​            

​           

## JavaScript 문법

> 자바스크립트는 문자는 존재하지 않으며 문자열만 있다.

### 자료형(data type)

| 자료형    | typeof 연산 | 설명                            |
| --------- | ----------- | ------------------------------- |
| 숫자형    | number      | 정수/실수(float,double X)       |
| 문자열형  | string      | 문자('', "")                    |
| boolean형 | boolean     | 참(true), 거짓(false)           |
| undefined | undefined   | **변수가 선언**되었지만 초기화X |
| null      | object      | 값이 존재X                      |

​        

### 연산

> **자바스크립트의 연산은 무조건 반환값이 존재한다.** (undefined, null, Infinity)

* 0으로 나누는 값에 대해 오류가 발생하지 않는다

  * `Infinity` 라는 무한대를 나타내는 상수로 나타난다.
  * `Nan`: 계산식의 결과가 숫자가 아님을 나타냄

* 이스케이프 시퀀스 `\`

  ```javascript
  console.log('작은 따옴표 안 \'작은 따옴표 \'');
  ```

* boolean과 연계: **[ semi-boolean 지원 ]**

  * false : 비어있는 문자열, null, undefined, 0

* 자동 형 변환(동적 타이핑, Dynamic Typing)

  ```javascript
  console.log("40"-5);
  ```

     

​       

### 연산자

> **주의: ==, != 은 형 변환을 지원하지만 ===과 !==은 형 변환을 지원하지 않으므로 경우에 따라 사용한다**

* `delete` : 파이썬과 마찬가지로 변수 삭제 지원
* `instanceof`: 자바스크립트와 마찬가지로 클래스 상속 판단 가능
* `in`: 프로퍼티가 존재하는지 확인



* eval() : 연산의 결과값을 나타낸다. **caller 의 권한으로 실행하기 때문에 해킹의 위험이 있으므로 사용을 지양한다.**

  ```javascript
  console.log(eval(23+4+5/2+7));
  console.log(eval("23+4+5/2+7"));
  ```

​         

### 조건문 / 반복문

* if

  ```javascript
  	if(score >= 90) {
  		console.log('A 학점입니다.');	// A 학점입니다. 출력됨.
  	} else if(score >= 80) {
  		console.log('B 학점입니다.');
  	} else if(score >= 70) {
  		console.log('C 학점입니다.');
  	} else {
  		console.log('F 학점입니다.');
  	}
  ```

* switch: case / break / default

  ```javascript
  	var score2 = 78;
  	
  	switch(parseInt(score2 / 10)) {
  	case 10 : case 9 : console.log('A 학점입니다.'); break;
  	case 8 : console.log('B 학점입니다.'); break;
  	case 7 : console.log('C 학점입니다.'); break;	// C 학점입니다. 출력됨.
  	default : console.log('F 학점입니다.'); 
  	}
  ```

* while

  ```javascript
  	var number = 1, sum = 0;
  	
  	while(number < 11) {
  		sum += number;
  		number++;
  	}
  	console.log(sum);
  ```

* do / while

  ```javascript
  	number = 1;
  	sum = 0;
  	
  	do{
  		sum += number;
  		number++;
  	} while(number < 11);
  	console.log(sum);
  ```

* for : **for ~ of(배열만) / in(객체) 문을 활용**  

  ```javascript
  	sum = 0;
  	
  	for(var number=1;number<11;number++) {
  		sum += number;
  	}
  	console.log(sum);
  ```



​         

### 객체

> 파이썬의 Dictionary, Java의 Map이 있다면 Javascript에는 Object(객체)가 있다. 
>
> 객체는 복사되지 않고 **참조됨**을 주의한다.

* boolean, null, undefined 는 객체가 아니다.
  * 근데 변수에 null을 할당하고 typeof 연산을 수행하면 object로 나온다.
* 객체는 **Key, Value**로 구성되어있다. = 이 두개를 묶어 **Property**라고 한다.(Python은 items)
  * 자바스크립트에서 함수 또한 객체므로 **Value**의 값으로 함수를 사용 가능하다.
  * 프로토타입(prototype)이라는 특별한 프로퍼티를 포함

​       

#### 객체 생성

* `{ }` 로 정의

  ```javascript
  var student = {
    name: "홍길동",
    info: function(){
      console.log("객체 함수");
  	}, //obj 메서드
  };
  
  let student = { };
  ```

* `new Object()` 생성자 함수

  ```javascript
  var student = new Object();
  
  student.name = "홍길동"; //값을 추가하는 방법
  ```

* 생성자 함수 이용

  ```javascript
  function Student(name, area, classNum){
  	this.name = name;
    this.area = area;
    this.classNum = classNum;
  }
  
  
  var student1 = new Student("홍길동", "서울", 20);
  ```

​        

### 조회

```javascript
console.log(student.age);
console.log(student["age"]);
console.log(student["user-name"]); //속성명에 연산자가 있으면 [ ]로 호출 
```

​      

### 변경/제거

```javascript
student.age = 30; //값 변경, 만약 key가 없다면 값이 아예 추가된다.
student['age'] = 30; //값 변경, 만약 key가 없다면 값이 아예 추가된다.

delete student.age; //값 삭제
```

​            

​          

## 함수

> 자바스크립트에서 **함수는 일급(first-class) 객체이다.**
>
> 함수를 변수, 객체, 배열 등에 저장할 수 있고 다른 인자나 리턴 값으로 사용 가능하다.
>
> 함수는 실행 중에 동적으로 생성 가능하다. 
>
> 함수 또한 **선언된 이후 Hoisting** 된다. = **너무 많은 함수 선언시 변수 객체를 많이 사용하므로 응답속도 저하**

### 함수 생성

```javascript
//함수 선언
function 함수명(매개변수1, 매개변수2,....,매개변수3){
	//함수 내용
}
```

```javascript
//함수를 변수로 저장
var 함수명 = function(매개변수1, 매개변수2,....,매개변수3){
	//함수 내용
}
```

```javascript
// Function 생성자 함수
var 함수명 = new Function("매개변수1", "매개변수2",....,"매개변수n");
```

​       

### 함수 호출

```javascript
function(매개변수1, 매개변수2,...,매개변수n);
```

​        

### 주의

* 함수 선언문이 아닌 **함수 표현식**의 경우 **변수 호이스팅**이 일어나지 않음

  ```javascript
  var result = plus(5, 7); //함수를 찾아야함: 하지만 plus는 var로 정의 = TypeError
  console.log(result);
  
  var plus = function(num1, num2){ //함수 선언이 아닌 표현식이므로 호이스팅이 일어나지 않음
  	return num1 + num2;
  };
  ```

* 매개변수가 함수 정의시 생기는 것보다 많아도 호출 가능

  ```javascript
  	<script>
  		function m1(a,b){ //매개변수로 2개를 받을 수 있지만 그 이상 넣어도 arguments로 연산 가능
  			let tot = 0;
  			for(let i of arguments){
  				tot += i;
  			}
  			return tot;
  		}
  		console.log(m1(1,2,3,4,5));
  	</script>
  ```

  ​       

### 콜백 함수

> 특정 이벤트가 발생했을 때 시스템이 함수를 호출
>
> 주로 비동기식 처리 모델에서 사용된다

* 이벤트 핸들러에서의 처리 예

```javascript
<button id="btn">click!</button>

<script type="text/javascript">
  var btn = document.getElementById('btn');
	btn.addEventListener('click', function(){
    console.log('안녕하세요!');
  })
</script>
```

​      

* setTimeout()의 예

```javascript
setTimeout(function(){
	console.log('3초 후 실행됩니다.');
}, 3000);
```


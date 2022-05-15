# Vue Final

​                 

### 1. MVVM

>개념: UI 및 비 UI 코드를 분리하기 위한 UI 아키텍처 디자인 패턴
>Model: 순수 자바스크립트 객체
>View: 웹페이지의 DOM
>ViewModel: Vue의 역할 = DOM Listener(가상 돔, Virtual DOM), Data Binding

​               

### 2. Vue Instance

> **인스턴스 화면 적용**
> 뷰 라이브러리 파일 로딩 →  인스턴스 객체 생성 → 특정 화면 요소에 인스턴스 붙임 → 인스턴스 내용이 화면 요소로 변환 → 변환된 화면 요소를 사용자가 최종 확인
>
> **유효 범위를 벗어난다면??**
> 오류는 나오지 않으나 `{{message}}`로 그대로 출력
>
> **this.**
> 인스턴스 내부에서 인스턴스 내부의 데이터를 사용하기 위해서는 this를 붙여야 함을 명심한다.

```js
new Vue({
	el: "#app", // Vue가 적용될 요소 지정. CSS Selector or HTML Element
	data: { // Vue엫서 사용할 정보 저장, 객체 또는 함수 형태
    message: "첫번째 Vue.js 앱입니다."
  },
  /* data 추천 형식
  data() {
  	return {
  	 	message: "test."
  	}
  }
  */
  methods: { // 화면 로직 제어와 관계된 method를 정의하는 속성. 마우스 클릭 이벤트 처리와 같이 화면의 전반적인 이벤트와 화면 동작과 관련된 로직을 추가
		myMethod(){
		
    }
  },
  components: {
    MyLocal: {
      template:`<h2>컴포넌트 입니다.</h2>`
//화면에 표시할 HTML, CSS등의 마크업 요소를 정의하는 속성, 뷰의 데이터 및 기타 속성들도 함께 화면에 그릴 수 있다.
    }
  }
});
```

​           

### 3. Vue Instance Life-Cycle

```js
new Vue({
	el: "#app",
	data(){
		return{
		}
	},
	beforeCreate(){
    //Vue Instance 생성되고 각 정보 설정 전에 호출. DOM 화면 접근 불가
  },
  created(){
    // Vue Instance 생성 후 데이터 설정 완료 후 호출
		// Instance 화면 부착 전: template 속성에 정의된 DOM 요소 접근 불가
    // 서버에 데이터 요청(http 통신)하여 받아오는 로직을 수행하기 좋다.
  },
  beforeMount(){
		//마운트가 시작되기 전 호출
  },
  mounted(){
		//지정된 element에 Vue Instance 데이터가 마운트 된 후에 호출
    //template 속성에 정의한 화면 요소에 접근 가능: 화면 요소를 제어하는 로직
  },
  beforeDestroy(){
		//Vue Instance가 제거되기 전에 호출
  },
  destroyed(){
		//Vue Instance가 제거된 후에 호출
  },
  beforeUpdate(){
    //데이터가 변경될 때 virtual DOM이 랜더링, 패치되기 전 호출
  },
  updated(){
		//Vue에서 관리되는 데이터가 변경되어 DOM이 업데이트 된 상태
		//데이터 변경 후 화면 요소 제어와 관련된 로직을 추가
  }
})
```

​            

### 4. 보간법(interpolation)

​              

### 0. Mustache

* 데이터 바인딩 기능
* 이 내부에선 JavaScript 표현식의 모든 기능 지원

```js
{{number + 1}}
{{ ok? 'YES' : 'NO' }}
{{ message.split('').reverse().join('')}}
```

* 표현식만 가능하지 구문을 사용하는건 아니다.

```js
//불가능한 표현 예시
{{ var a = 1 }}
```

​              

#### 1. v-once

```vue
<span>메시지: {{msg}}</span>
<span v-once>다시 변경되지 않습니다. {{msg}}</span>
```

​              

#### 2. v-html

> v-text: 텍스트가 직접 호출된다.

```vue
<h2 v-html="message">내용이 무엇이든 나오지 않는다</h2>
```

```js
 data(){
   return{
   message: "<span style='color: red;'>안녕하세요</span>",
   number: 5, 
 	 }
}, 
```

​           

### 5. Directives

> v-접두가사 있는 특수 속성

​            

#### 1. v-model

* 양방향 데이터 바인딩(form의 input, textarea)

​           

#### 2. v-bind

* 엘리먼트의 속성과 바인딩 처리를 위해서 사용

```vue
<!-- 속성을 바인딩-->
<div v-bind:id="idValue">v-bind 지정 연습</div>
<button v-bind:[key]="btnId">버튼</button>

<!--약어를 사용-->
<div :id="idValue">v-bind 지정 연습</div>
<button :[key]="btnId">버튼</button>
```

​              

### 3. v-show

* 조건에 따라 화면에 렌더링
* display를 변경하는 것이다,

```vue
 <div v-show="isShow">{{msg}}</div>
 <button @click="isShow = !isShow">클릭</button>
```

​             

#### 4. v-if, v-else-if, v-else

* 엘리먼트 자체의 생성/제거(show와는 다름)

```vue
 <div>요금 : </div>
 <div v-if="age < 10">무료</div>
 <div v-else-if="age < 20">5000원</div>
 <div v-else-if="age < 70">9000원</div>
```

​              

#### v-show와 v-if 차이

* v-show는 렌더링이 늘 일어나고 조건에 맞지 않아도 display:none이다
  * 하지만 template에서 사용할 수 없다.
* v-if는 false라면 렌더링 자체가 일어나지 않고 엘리먼트가 생성되지 않는다.
  * 하지만 template에서 사용할 수 있고
  * v-else를 추가적으로 사용할 수 있다.

​            

### 5. v-for

* 배열이나 객체 반복에 사용

> v-for="요소변수이름 in 배열"
> v-for="(요소변수이름, 인덱스) in 배열" 

​                

#### 6. v-cloak

* Vue Instance가 준비될 때까지 mustache 바인딩을 숨길 수 있다
* 태그에 v-cloak 을 설정하면 내부 전체가 설정해준 content로 대체된다.
* 특이하게 `<style>`에 값을 넣어준다.

```vue
<style>
[v-cloak]::before {
	content: '로딩중...'
}
[v-cloak] > * {
	display: none;
}
</style>
```


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
	data: { // Vue에서 사용할 정보 저장, 객체 또는 함수 형태
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

> Vue Instance 기준으로 나눈다.

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

* `<textarea>` 내부에서 {{ }} 는 작동하지 않는다. = `v-model` 사용

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
* `v-model.lazy=""`: change 이벤트 이후에 동기화가 된다.(input 내부에서 입력 후 빠져나와야 적용)
* `v-model.number=""`: 사용자 입력이 자동으로 숫자로 형 변환
* `v-model.trim=""`: 입력에 자동으로 trim 적용
* checkbox에서 v-model="VALUE" 을 지정할 경우 data 내부에서 정의된 VALUE 값은 true 아니면 false 이다.
  * 하지만 이 값을 true-value="Y", false-value="N" 이런식으로 각 값을 정의해줄 수 있다. 
  * 심지어  check 박스에서 v-model로 모두 연결해놓은 상태라면 VALUE: [] 로 비워둔 배열에 true인 value가 모두 들어간다.
* radio 버튼은 하나만 선택할 수 있기 때문에 v-model로 서로 연결하면 VALUE에 선택된 요소의 값이 저장되고 나머지는 체크 해제
* select 박스의 경우 하위의 option에는 지정할 필요없이 `<select v-model="selectedArea">`로 지정해서 사용 가능하다.
  * select박스를 열어 option을 선택하면 selectedArea 값이 option의 value로 바뀐다.
  * **multiple**: `<select v-model="selectedArea" multiple>` 로 하면 v-model에 연결된 값에 선택한 여러 값을 저장할 수 있다.

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

* v-for에서 `key=""`값을 설정하는 이유
  * 자료의 개수가 많을 수록 렌더링 속도가 빨라진다(대조 기능).
    * 가상 DOM과의 비교가 원활해지는 역할
    * 보통 `:key="index"`로 자동부여되는 인덱스로 지정해줄 수 있다.

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

​                

​                 

### 6. Vue Filter

* 뷰의 필터는 화면에 표시되는 텍스트의 형식을 쉽게 변환해주는 기능
* filter를 이용해 표현식에 새로운 결과를 지정
* 중괄호 보간법 {{}} 또는 v-bind에서 사용이 가능

```vue
{{ msg | capitalize }}
<div v-bind:id="rawId | formatId"></div>
```

* 선언1(전역필터): `Vue.filter('', arrow function)`

  ```js
  Vue.filter('count1', (val) => {
    if (val.length == 0) {
    	return;
    }
  	return `${val} : ${val.length}자`;
  });
  ```

* 선언2(지역필터): new Vue(뷰 인스턴스) 내부에 `filters :`

  ```js
  new Vue({
        el: '#app',
        data: {
          msg: '',
        },
        filters: {
          count2(val, alternative) {
            if (val.length == 0) {
              return alternative;
            }
            return `${val} : ${val.length}자`;
          },
        },
  });
  ```

  ​                

### 7. computed, watch, methods

#### 1. computed

>* 특정 데이터 변경사항 실시간 처리: 즉 해당 데이터 변경시 재계산
>
>* **캐싱**을 이용해 데이터의 변경이 없을 경우 캐싱된 데이터를 반환(값)
>
>* Setter, Getter 직접 지정 가능: `get()`, `set()`
>
>  ```js
>  computed: {
>            // get만 가능합니다.
>            aDouble() {
>              return this.a * 2;
>            },
>            // get과 set 입니다.
>            aPlus: {
>              get() {
>                console.log('get');
>                return this.a + 1;
>              },
>              set(v) {
>                console.log('set');
>                this.a = v - 1;
>              },
>            },
>          },
>  ```
>
>* 작성은 methods 같지만 Vue에서 proxy 처리해 property처럼 사용

​                 

### 2. watch

> Vue Instance의 특정 property가 변경될 때 실행할 콜백함수 설정
> 해당 데이터 변경시 다른 data 변경하는 작업

```js
watch: {
        a: function (val, oldVal) {
          console.log('new: %s, old: %s', val, oldVal);
        },
      },
```

​                

### 8. Vue event

> DOM Event를 청취하기 위해 v-on directive
>
> ```vue
> <button v-on:click="counter += 1">클릭</button>
> ```
>
> Inline event handling
>
> ```vue
> <button v-on:click="greet('VALUE')">Greet</button>
> ```
>
> method를 이용한 event handling
>
> ```vue
> <button v-on:click="greet">Greet</button>
> ```
>
> ​                   

​               

#### 이벤트 수식어(Event Modifier)

```vue
<a v-on:click.stop="METHOD"></a> <!--이벤트 전파 중단: event.stopPropagation() -->
<a v-on:click.stop.prevent="METHOD"></a> <!--이벤트 전파 중단, 수식어는 체이닝 가능: event.preventDefault()-->
<form v-on:submit.prevent="METHOD"></form> <!-- 페이지 로드 X -->
<form v-on:submit.prevent></form> <!-- 수식어 가능 -->
```

​              

#### - 키 수식어

```vue
<input v-on:keyup.enter="submit">
```

* key code

```
.enter=""
.13=""
.tab=""
.delete=""
.esc=""
.space=""
.up=""
.down=""
.left=""
.right=""
.page-down=""
```

​                              

### 9. DOM 접근: ref, $ref

* ref로 등록

  ```vue
  <input type="text" v-model="id" ref="id" />
  ```

* $refs에서 꺼내서 사용

  ```js
  console.log(this.$refs.id.value);
  ```

  ​                               

### 10. class binding

* element의 class와 style 변경

* v-bind:class 는 조건에 따라 class 적용이 가능하다.

* 클래스 바인딩은 **중괄호**를 사용함을 명심한다

  ```vue
  <div v-bind:class="{ active: isActive }">
  ```

​            

### 11. 컴포넌트(Component)

> * Vue의 강력한 기능 중 하나
>
> * HTML Element를 확장하여 재사용 가능한 코드를 캡슐화
>
> * Vue Component는 Vue Instance이기도 하기 때문에 모든 옵션 객체를 사용
>
> * Life Cycle Hook 사용 가능
>
> * 전역 컴포넌트와 지역 컴포넌트
>
>   * 전역 컴포넌트
>
>     ```js
>     Vue.component('my-component', {
>     	//옵션
>     })
>     ```
>
>     ```js
>     Vue.component('MyComp', {
>       template: '#Mycomp', //위에서 작성한 <template id="Mycomp"> 내부 값을 가져옴
>       data() {
>         return {
>           msg: 'hello component', // template 내부로 들어갈 프로퍼티 값
>         };
>       },
>     });
>     
>     new Vue({
>       el: '#app',
>     });
>     ```
>
>     
>
>   * 지역 컴포넌트
>
>     ```js
>     var Child = {
>       template: '<div>사용자 정의 컴포넌트</div>'
>     }
>     
>     new Vue({
>     	components:{
>         'my-component': Child
>     	}
>     })
>     ```
>
>     ​                   
>
>     ​               

​              

#### - 컴포넌트간 통신

> 상위(부모) - 하위(자식) 컴포넌트 간의 data 전달 방법
>
> * 부모에서 자식: props라는 특별한 속성 전달(Pass Props)
> * 자식에서 부모: event로만 전달 가능. (Emit Event)

* **props**: 부모에서 자식으로 넘겨줄 때 자식이 받는 방법

  * 내부에 보내준 프로퍼티의 `type`와 `required`를 명시해줄 수 있다.

  * 보내는 방법?: 태그내부에 넣어준다.

    ```vue
    <child-component pdata="안녕하세요 props 입니다."></child-component>
    ```

```js
props: {
        pdata: {
          type: String,
          required: true,
        }
      }
,template: `<span>{{props}}</span>`,      
```

​             

#### 사용자 정의 이벤트: $on

* 정의하는 법

````js
vm.$on("이벤트명", 콜백함수(){})

this.$on('sendMsg', (msg) => {
  alert(msg);
  this.message = msg;
})
````

* 상위로 발생시키는 법

```js
vm.$emit("이벤트명", [ ... 파라미터]);
```

* 상위에서 받는 방법
  * `v-on:`을 `@`로 바꿔 사용할 수 있다. 

```vue
<child v-on:이벤트명="메서드명"></child>
```

```vue
<child @이벤트명="메서드명"></child>
```

​                

​             

### 12. axios

* Vue에서 권장하는 통신 라이브러리
* Promise 기반: then().catch() 사용 가능
  * 자바스크립트의 단일 스레드 기반 로직의 한계를 보완한다.

​                

| API 유형                              |
| ------------------------------------- |
| axios.get('URL 주소').then().catch()  |
| axios.post('URL 주소').then().catch() |
| axios({옵션 속성})                    |

* 속성으로 사용하기

  ```js
  axios({
  	method: 'post',
  	url: '/user',
  	data: {
  		name: '홍길동',
  		userid: 'site'
  	}
  })
  .then(function (response){
    //logic
  });
  ```

  ​              

### 13. vue-router

> **< 필수 태그 >**
>
> ```vue
> <router-link to="/">HOME</router-link> <!-- a 태그로 렌더링 -->
> ```
>
> ```vue
> <router-view></router-view>
> ```
>
> ​            

* 라우팅: 웹 페이지 간 이동 방법
* Vue.js의 공식 라우터
* 라우터는 컴포넌트와 매핑해 사용
* SPA를 제작할 때 유용하다

​             

#### - 라우터 객체 생성

```js
const router = new VueRouter({
	mode: 'history',
	routes: [
		{
			path: "/",
			component: Main,
		},
	]
})
```

* 라우터 주입

  ```js
  // Vue 인스턴트 라우터 주입
        const app = new Vue({
          el: "#app",
          router,
        });
  ```

​              



​                       

#### - 컴포넌트 export

```js
export default{
	template: ``,
	data(){
		return(){
		
		}
	}
}
```

​           

#### - 여러 컴포넌트를 받는 router.js

```js
// 라우트 컴포넌트
import Main from './components/Main.js';
import Board from './components/Board.js';
import QnA from './components/QnA.js';
import Gallery from './components/Gallery.js';

// 라우터 객체 생성
const router = new VueRouter({
  routes: [
    {
      path: '/',
      component: Main,
    },
    {
      path: '/board',
      component: Board,
    },
    {
      path: '/qna',
      component: QnA,
    },
    {
      path: '/gallery',
      component: Gallery,
    },
  ],
});

// Vue 인스턴트 라우터 주입
const app = new Vue({
  el: '#app',
  router,
});
```

​              

#### - index.html에서 받아주기

* src로 파일로드하기

```js
<script type="module" src="app.js"></script>
```

* 또는 이름으로 가져와서 임포트

```vue
<script type="module">
      import router from "./App.js";
      import HeaderNav from "./components/HeaderNav.js";

      new Vue({
        el: "#app",
        components: {
          HeaderNav,
        },
        router,
      });
</script>
```

​              

#### - 주소에 파라미터 바인딩

```js
const router = new VueRouter({
	routes: [
		{
			path: '/board/:no', // 파라미터가지는 URL 등록
			component: BoardView,
		}
	]
})
```

* 라우터 정보 접근하기

  ```js
  this.$route.params.no
  this.$route.path
  ```

* 전체 라우터정보

  ```js
  this.$router
  ```

​             

#### - 바인딩해서 호출하기

> 작은따옴표(')를 혼용한다.

```vue
<router-link to="'/board/' + i"> {{i}}번 게시글</router-link>
```

​            

#### - 라우터 이름으로 바인딩하기

> `:to="{name: '이름', params: {} }"`로 바인딩해서 이름으로 이동하고 값을 보낼 수 있다.
> 또는 `$router.push({name: '이름', params: {}});`으로 이동한다.

* 이름 지정

```js
const router = VueRouter({
	routes: [
		{
			path: '/board',
			name: 'board',
			component: Board,
		}
	]
});
```

* 이름으로 이동하기(**to**에 바인딩 사용)

  ```vue
  <a @click="$router.push({name: 'Board', params: {no:3}});">3번 게시글</a>
  ```

  ```vue
  <router-link :to="{name: 'Board', params:{no:3}}">3번 게시글</router-link>
  ```

​                

#### - 기본 컴포넌트 지정: redirect

> path, name, component 외에 redirect와 children: [ ] 을 설정할 수 있다.
> **children에는 "/"가 필요없음을 주의**한다.

```js
 {
   path: "/board",
   name: "board",
   component: BoardMain,
   redirect: '/board/view', // redirect: {name: 'list'}
   children: [
     {
     path: 'view',
     name: 'boardlist',
     component: BoardView,
     },
     {
     path: 'register',
     name: 'boardregister',
     component: BoardRegister,
     },
   ],
 },
```

​          

​                

### 14. @vue/cli

> package.json 파일의 dependencies 확인

* 생성

  ```bash
  vue create 이름
  ```

* 플러그인 설치

  ```
  vue add <plugin-name>
  ```

* axios 설치

  ```bash
  npm install axios
  ```

* 서버 실행

  ```bash
  npm run serve
  ```

​                

### 15. SFC(Single File Component)

* 확장자가 `.vue`인 파일

* .vue = template + script(최대 한 개, js) + style(여러 개, scoped 속성)

* 구문 강조 가능

* 컴포넌트에만 CSS 범위를 제한할 수 있음

  ```vue
  <style scoped>
  </style>
  ```

* 전처리기를 사용해 기능의 확장 가능

​              

### 16. SPA

> 현대 웹페이지가 고도화됨에 따라 한 페이지마다의 용량이 커졌고 매번 새로운 페이지를 전달하는 것이 버겁게 되었다.
> 그래서 전체 페이지를 하나의 페이지에 담아 동적으로 동작하게 해 상호작용하기 위한 최소한의 요소만 변경된다.
> HTML 5의 history api를 이용해(vue에서는 history 모드) 현재 페이지 내에서 화면 이동이 일어난처럼 작동한다.

​             

### 17. package.json

> 프로젝트 정보를 정의(name, version) 하고 의존하는 패키지 정보를 명시하는 파일(dependencies, devDependencies)

* dependencies
* devDependencies

​           

### 18. query vs params

* query: 주소 "?" 이후에 쓰여진 변수: `/endOfAddress?id=hong&age=26`
* params: 주소에 포함된 변수: `/params/params2 `

​             

### 19. 양방향 바인딩 vs 단방향 바인딩

* 양방향 바인딩: model의 값이 변경될 때 view의 값도 변경되고 view의 값이 변경될 때 model의 값도 변경되는 것
  * 즉 JS -> HTML, HTML -> JS 양 쪽 가능
  * 단점: DOM 렌더링에 의한 성능 저하 
  * 프레임워크에서 감지하고 있다 데이터가 변경되는 시점에서 가상 DOM을 렌더링하고 실제 DOM에 변경사항을 렌더링
    * 애플리케이션의 복잡도가 높아질수록 코드를 간결하게 만들어주기 때문에 유지보수와 확장성을 증가시킨다.
    * Vue에서는 v-model을 사용합니다.
* 단방향 바인딩
  * 장점: 데이터 변경에 따른 성능저하를 생각하지 않아도 됩니다.
  * 단점: 업데이트 코드를 매번 작성해야함
    * JS -> HTML만 가능
    * 대표적으로 React가 있는데 부모 뷰 -> 자식 뷰

​           

### 20. vuex

> store 내부에서는 5가지 속성이 존재
>
> * state
> * getters: computed에 등록, 전달인자를 받을 수 없다
> * mutations: methods에 등록, 전달인자를 받을 수 있다, 동기적 변이를 다룬다
> * actions: 비동기적 변이를 다룬다 ex)setTimeout()
> * modules: 각각의 state, getters, mutations, actions를 분리해 저장

* $store

```js
export const store = new Vuex.Store({
	state: {
	}
})
```

* main에서 받아주기

````json
new Vue({
	render: h => h(App),
	storeL store,	
})
````


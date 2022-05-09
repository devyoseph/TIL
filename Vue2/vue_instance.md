# Vue Instance

​                     

### 1. Vue 인스턴스 생성

```vue
<script>
	new Vue({
    el: '#app',
    data: {
      message: 'Vue란 무엇인가?'
    }
  })
</script>
```

* 이후 component를 사용하기 위해 권장 형식

  ```vue
  data(){
  	return{
  		message: 'test.'
  	}
  }
  ```

| 속성     | 설명                                                         |
| -------- | ------------------------------------------------------------ |
| el       | Vue가 적용될 요소 지정<br />CSS Selector / HTML Element      |
| data     | Vue에서 사용되는 정보 저장<br />객체 또는 함수 형태          |
| template | 화면에 표시할 HTML, CSS 등의 마크업 요소를 정의하는 속성<br />뷰의 데이터 및 기타 속성들도 함께 화면에 그릴 수 있다. |
| methods  | 화면 로직 제어와 관계된 method를 정의하는 속성.<br />마우스 클릭 이벤트 처리와 같이 화면의 전반적인 이벤트와 화면 동작과 관련된 로직을 추가 |
| created  | 뷰 인스턴스가 생성되자마자 실행할 로직을 정의                |

​                   

#### Vue Instance의 유효범위

* Vue Instance를 생성하면 HTML 특정 범위 안에서만 옵션 속성이 적용
* el 속성과 밀접한 관계가 있다.

<img src="https://mblogthumb-phinf.pstatic.net/MjAxODA2MTRfMTcx/MDAxNTI4OTY4NzMxNTQ0.wHB8_8djPCnz_Zhchv1bK5hMC_QQ0bqIwhcI3oLlHMUg.TDyLpwOmgS40mhuSRbRXjYFxOZEzT2-JxA01mrt8l2kg.PNG.dmswldla91/image.png?type=w800" alt="img" style="zoom: 67%;" />

* 예시

  ```vue
  <script>
  	new Vue({
      el: '#app',
      data: {
        message: 'Vue란 무엇인가?'
      }
    })
  </script>
  ```

* 순서

  1. Vue()에 의해 인스턴스가 생성

  2. el 속성에 지정한 화면 요소(DOM)에 인스턴스가 부착

     ```html
     <div id="app">
     	<h2>{{message}}</h2>
     </div>
     ```

  3. el 속성에 인스턴스가 부착된 후 data 속성이 el 속성에 지정한 화면 요소와 그 이하 레벨의 화면 요소에 적용되어 치환

     * {{message}} → Vue란 무엇인가?

  4. 만약 유효범위를 벗어나면 작동하지 않는다.

     ```html
     <div id="app">
     </div>
     	<h2>{{message}}</h2>
     ```

​           

​                 

### 2. Vue Instance Life-Cycle

* LifeCycle은 크게 나누면 Instance의 생성 / 생성된 Instance를 화면에 부착 / 화면에 부착된 Instance 내용 갱신 / Instance가 제거되는 소멸의 4단계로 나뉜다.

<img src="https://kr.vuejs.org/images/lifecycle.png" alt="The Vue Instance Lifecycle" style="zoom: 33%;" />

​             

#### [ Life Cyde Hooks ]

| life cycle 속성 | 설명                                                         |
| --------------- | ------------------------------------------------------------ |
| beforeCreate    | Vue Instance가 생성되고 각 정보의 설정 전에 호출<br />DOM과 같은 화면요소에 접근 불가 |
| **created**     | Vue Instance가 생성되고 데이터 설정이 완료된 후 호출<br />Instance 화면 부착 전이며 template 속성에 정의된 DOM 요소 접근 불가<br />서버에 데이터 요청(http 통신)으로 받아오는 로직을 수행하기가 좋다 |
| beforeMount     | 마운트가 시작되기 전에 호출                                  |
| mouted          | 지정된 element에 Vue Instance 데이터가 마운트 된 후에 호출<br />template 속성에 정의한 화면 요소에 접근할 수 있어 화면 요소를 제어하는 로직 수행 |
| beforeUpdate    | 데이터가 변경될 때 virtual DOM이 랜더링, 패치되기 전 호출    |
| **updated**     | Vue에서 관리되는 데이터가 변경되어 DOM이 업데이트 된 상태<br />데이터 변경 후 화면 요소 제어와 관련된 로직을 추가 |
| beforeDestroy   | Vue Instance가 제거되기 전에 호출                            |
| destroyed       | Vue Instance가 제거된 후에 호출                              |

​          

```vue
    <div id="app">
        <h2>클릭 카운트: {{count}}</h2>
        <button @click="count++">카운트 증가</button>
    </div>
    <script>
        new Vue({
            el: "#app",
            data(){
                return{
                    count: 0,
                }
            }, 
            beforeCreate(){ //undefined가 나온다. = 초기화가 일어나지 않음
                console.log("beforeCreate: 호출!!");
                console.log("beforeCreate: " + this.count);
            },
            created(){ // $el 연결 X
                console.log("created: 호출!!");
                console.log("created: " + this.count);
                console.log("created el: "+ this.$el);
            },
            beforeMount(){ 
                console.log("beforeMount: 호출!!");
                console.log("beforeMount: " + this.count);
            },
            mounted(){
                console.log("mounted: 호출!!");
                console.log("mounted: " + this.count);
                console.log("mounted el: "+ this.$el);
            },
            updated(){console.log("updated: 호출!!")},
            destroyed(){console.log("destroyed: 호출!!")},
        });
    </script>
```

​                   

#### - 이벤트 예시

* 빠르게 연결할 수 있다.

```vue
 <div id="app">
        <h2>클릭 카운트: {{count}}</h2>
        <button @click="count++">카운트 증가</button>
 </div>
```

​                     

​                      

### 3. Vue Instance 속성

> method, filter, computed, watch

​           

#### - Vue method

* Vue Instance는 생성과 관련된 data 및 method 정의 가능
* method 안에서 data를 `this.데이터명`으로 접근 가능
* method 내에서 this가 사용됐다면 arrow function을 사용할 수 없다.

```vue
<body>
    <div id="app">
      <div>data : {{message}}</div>
      <div>method kor : {{helloKor()}}</div>
      <div>method eng : {{helloEng()}}</div>
    </div>
    <script>
      new Vue({
        el: '#app',
        data: {
          message: 'Hello 뷰',
          name: '홍길동',
        },
        methods: {
          helloEng() {
            return 'Hello ' + this.name;
          },
          helloKor() {
            return '안녕 ' + this.name;
          },
        },
      });
    </script>
  </body>
```

```vue
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vue.js</title>
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
</head>
<body>
        <div id="app">
            <h2>method test</h2>
            <div>
                <label for="userid">아이디</label>
                <input type="text" id="userid" v-model="userid">
                <label for="username"></label>
                <input type="text" id="username" v-model="username">
                <button @click="checkVal">등록</button>
            </div>
        </div>
        <script>
            new Vue({
            el: "#app",
            data: {
                userid: "",
                username: "",
            },
            methods: {
                checkVal() {
                    if(!this.userid){
                        alert("아이디 입력!!");
                        return;
                    } else {
                        this.register();
                    }
                },
                register(){
                    alert("서버에 전송합니다!!");
                }
            }
        })

    </script>
</body>
</html>
```



​                  

#### - Vue filter

> 기존 데이터를 바꾸지 않고 형식만 바꿔준다.



> 보건법 {{ 값 | 메서드명 }}
> Vue.filter( '메서드명', (val) =>
> new Vue({
>
> ​	filters:{
>
> ​	}
>
> })

* 뷰의 필터는 화면에 표시되는 텍스트의 형식을 쉽게 변환해주는 기능
* filter를 이용해 표현식에 새로운 결과 형식을 적용
* 중괄호 보간법 {{}} 또는 v-bind 속성에서 사용이 가능

```vue
<!-- 중괄호 보간법 -->
{{ message | capitalize }} <!-- message를 capitalize 메서드에게 넣어준다 -->

<!-- v-bind 표현 -->
<div v-bind:id="rawId | formatId"></div>
```

​                

* 전역필터

  ```javascript
  Vue.filter('count1', (val) => { //count1에 val을 넣어준다면
  			if (val.length == 0){
  				return;
  			}
  			return `${val} : ${val.length}자`;
     }
  );
  ```

* 지역필터

  ```javascript
  new Vue({
  	el: '#app',
    filters: {
  			count2(val, alternative){
  				if (val.length == 0){
  					return alternative;
  				}
      	return `${val} : ${val.length}자`;
     }
  })        
  ```

* filter 여러개 적용

  ```vue
  <div>
    <h3>{{ msg1 | price | won}}</h3>
  </div>
  ```

  ​                   

  

#### - Vue computed

> method의 return값을 computed의 이름에 저장해 놓고 호출함

* 특정 데이터의 변경사항을 실시간으로 처리
* 캐싱을 이용하여 데이터의 변경이 없을 경우 캐싱된 데이터를 반환. >> 값
* Setter와 Getter를 직접 지정할 수 있음
* 작성은 method 형태로 작성하지만 Vue에서 proxy 처리하여 property처럼 사용

​          

* 메서드의 호출은 methods: { } 내부의 메서드를 호출하고 {{method( ) }} 실행문으로 적어주어야 한다.

* methods 대신 **computed** 라고 적고 실행문이 아닌 값으로 취급해 호출한다.

  ```vue
  <body>
    <div id="app">
      <input type="text" v-model="message" />
      <p>원본 메시지: "{{ message }}"</p>
      <p>역순으로 표시한 메시지1: "{{ reversedMsg }}"</p> <!-- 메서드를 값으로 취급해 호출 -->
      <p>역순으로 표시한 메시지2: "{{ reversedMsg }}"</p>
      <p>역순으로 표시한 메시지3: "{{ reversedMsg }}"</p>
    </div>
    <script>
      var vm = new Vue({
        el: '#app',
        data: {
          message: '안녕하세요 싸피여러분',
        },
        computed: {
   <!-- 처음 한번만 수행하고 이것을 캐싱하고 있다가 여러번 호출하면 계산을 여러번 하지 않고 저장된 값을 출력 -->
          reversedMsg: function () {
            console.log('꺼꾸로 찍기');
            return this.message.split('').reverse().join('');
          },
        },
      });
    </script>
  </body>
  ```

​                               

#### - Vue watch

> Computed는 종속된 data가 변경되었을 경우 그 data를 다시 계산하여 캐싱한다.
> Watch의 경우 data가 변경되었을 경우 다른 data를 (변경하는) 작업을 한다.
> 데이터가 변경되지 않기를 바랄 때 사용한다고 생각한다.

* Vue Instance의 특정 property가 변경될 때 실행할 콜백 함수 설정

```vue
<div id="app">
    <div>
      <input type="text" v-model="a" />
    </div>
  </div>
  <script>
    var vm = new Vue({
      el: '#app',
      data: {
        a: 1, //감시할 대상
      },
      watch: {
        a: function (val, oldVal) { //a를 감시하고 값이 바뀌면 현재값과 이전값을 가져옴
          console.log('new: %s, old: %s', val, oldVal);
        },
      },
    });
    console.log(vm.a);
    vm.a = 2; // => new: 2, old: 1
    console.log(vm.a);
 </script>
```

​               

### watch VS computed

```vue
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
</head>
<body>
    <div id="app">
        <h2>watch</h2>
        <div>반지름 : {{radius}} 원의 넓이 : {{area}} 원의 둘레 : {{round}}</div>
    </div>
    <script>
        new Vue({
            el: "#app",
            data(){
                return{
                    radius: 2,
                    area : 3.14 * 2 ** 2,
                    round: 2 * 3.14 * 2,
                };
            },
            watch: {
                radius: function(n, o){
                    this.area = 3.14 * this.radius ** 2;
                    this.round = 2 * 3.14 * this.radius;
                }
            },
        });
    </script>
</body>
</html>
```

```vue
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
</head>
<body>
    <div id="app">
        <h2>watch</h2>
        <div>반지름 : {{radius}} 원의 넓이 : {{area}} 원의 둘레 : {{round}}</div>
    </div>
    <script>
        new Vue({
            el: "#app",
            data(){
                return{
                    radius: 2,
                };
            },
            computed: {
                area: function(){
                    return 3.14 * this.radius ** 2;
                },
                round: function(){
                   return 2 * 3.14 * this.radius;
                }
            },
        });
    </script>
</body>
</html>
```



​              

#### - 포커스 강제

```html
<input type="text" id="userid" v-model="userid" ref="uid">
```

 ```js
 this.$refs.uid.focus();
 ```




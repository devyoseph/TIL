# template - 보간법(interpolation)

> **문자열**
>
> * 데이터 바인딩의 가장 기본적인 형태는 "Mustache" 구문(이중 중괄호)을 사용한 텍스트 보간
>
>   * {{속성명}}
>
> * v-once 디렉티브를 사용하여 데이터 변경 시 업데이트 되지 않는 일회성 보간을 수행
>
>   * v-once
>
>   ```vue
>    <div id="app">
>           <h2>{{message}}</h2>
>           <h2 v-once>{{message}}</h2>
>    </div>
>   //message 값이 변경되면 v-once는 변경되지 않는다.
>   ```
>
>   * v-html=""
>     * css를 직접 적용할 수 있지만 클라이언트가 악용할 수 있기에 사용을 지양한다.
>
>   ```vue
>       <div id="app">
>           <h2>{{message}}</h2>
>           <h2 v-html="message">{{message}}</h2>
>       </div>
>       <script>
>           new Vue({
>               el: "#app",
>               data(){
>                   return{
>                      message: "<span style='color: red;'>안녕하세요</span>",
>                   }
>               }, 
>           });
>       </script>
>   ```
>
>   * Javascript 표현식을 사용 가능
>
>   ```vue
>   <div id="app">
>           <h2>{{number >3? "YES" : "NO"}}</h2>
>   </div>
>   ```
>
>   ​          

​            

## template-Directive

> **디렉티브(Directives)**
>
> * 디렉티브는 v- 접두사가 있는 특수 속성
> * 디렉티브 속성 값은 단일 JavaScript 표현식이 된다. (v-for는 예외)
> * 디렉티브의 역할은 표현식의 값이 변경될 때 사이드 이펙트를 반응적으로 DOM에 적용
>
> ​          
>
> **종류**
>
> * v-text / v-html / v-once / v-model
> * v-bind / v-show / v-if / v-else-if
> * v-else / v-for / v-cloak /v-on
>
> ​         

​                

### v-model

> 한 쪽이 바뀌면 다른 한쪽도 바뀜(**양방향 데이터 바인딩**)
> Input 내부에서 message 값을 수정하면 아래 \<div>태그 내부의 message 값도 같이 변한다. 

```vue
 <div id="app">
        <input type="text" name="" id="" v-model="message">
        <div>{{message}}</div>
 </div>
```

​                 

### v-bind

* 엘리먼트 속성과 바인딩 처리를 위해서 사용
* v-bind는 약어로 `:`로 사용 가능

```vue
<style>
  #btn1 {
      width: 200px;
      background-color: ivory;
  }
</style>

<div id="app">
        <!-- 속성을 바인딩-->
        <div v-bind:id="idValue">v-bind 지정 연습</div>
        <button v-bind:[key]="btnId">버튼</button>
        <!--문자열의 id가 아니라 데이터의 idValue에 해당하는 값을 가져옴 -->
  			<!--속성의 이름은 [대괄호]로 묶어서 불어와야 인식 -->
  
  			<!--약어를 사용-->
        <div :id="idValue">v-bind 지정 연습</div>
        <button :[key]="btnId">버튼</button>
  
  			<!--링크 연결-->
        <a v-bind:href="link">이동1</a>
        <a :href="link">이동2</a>
</div>

<script>
  new Vue({
    el: "#app",
    data(){
      return{
        idValue: 'test-id',
        key: 'id',
        btnId: 'btn1',
        link: 'http://www.naver.com',
      }
    }, 
  });
</script>
```

​                           

### v-show

> v-if나 이벤트와 같이 활용

* 조건에 따라 엘리먼트를 화면에 렌더링
* style의 display를 변경

```vue
<div id="app">
        <h2>v-Show</h2>
        <div v-show="isShow">{{msg}}</div>
        <button @click="isShow = !isShow">클릭</button>
    </div>
    <script>
        new Vue({
            el: "#app",
            data(){
                return{
                   msg: "Hello Vue!",
                   isShow: false,
                }
            }, 
        });
    </script>
```

​                 

### v-if, v-else-if, v-else

> v-model로 연결해서 한번에 값을 띄움

```vue
<div id="app">
        <label for="age">나이 : </label>
        <input type="text" id="age" v-model="age" />
        <div>
            <div>요금 : </div>
            <div v-if="age < 10">무료</div>
            <div v-else-if="age < 20">5000원</div>
            <div v-else-if="age < 70">9000원</div>
        </div>
    </div>
    <script>
        new Vue({
            el: "#app",
            data(){
                return{
                   age: 0,
                }
            }, 
        });
    </script>
```

​                            

### * v-show VS v-if 차이점

|               | v-if           | v-show             |
| ------------- | -------------- | ------------------ |
| 렌더링        | false일 경우 X | 항상 O             |
| false일 경우  | 엘리먼트 삭제  | display: none 적용 |
| template 지원 | O              | X                  |
| v-else 지원   | O              | X                  |

​                       

### v-for

> v-for=`"A in B"`을 활용해 반복 개수를 결정하거나 객체 내부의 값을 꺼낼 수 있다.
> 배열의 값을 꺼낼 때 index도 지정하면서 꺼내줄 수 있다.
> 임의의 태그(span, div) 안에서 vfor을 입력하고 엔터를 치면 된다.
>
> * 만약 객체 내부에 객체가 또 있다면?
>
>   ```vue
>   {{item.value}}
>   ```
>
>   와 같이 꺼내서 사용할 수 있다.
>
> ​         
>
> **우선순위**
>
> v-for > v-if
>
> * 먼저 뿌린다음 if로 걸러지므로 처음부터 외부 태그에서 if문으로 걸러준다.

* 배열이나 객체의 반복에 사용
* v-for="요소변수이름 in 배열" v-for="(요소변수이름, 인덱스) in 배열"

```vue
<div id="app">

        <!-- :key ? -->
        <h2>단순 for문</h2>
        <span v-for="i in 5" :key="index">{{i}}번 </span>
        
        <h2>객체 반복</h2>
        <span v-for="value in student" :key="value.id">{{value}}</span>
    </div>
    <script>
        new Vue({
            el: "#app",
            data(){
                return{
                   student: {
                       id: "인간",
                       name: "홍길동",
                       age: 33,
                   }
                }
            }, 
        });
    </script>
```



​            

### template

* 여러 개의 태그들을 묶어서 처리해야 할 경우 template를 사용
* v-if, v-for, component등과 함께 사용

​            

### v-cloak

> 자주 사용되지는 않는다.

* Vue Instance가 준비될 때까지 mustache 바인딩을 숨기는데 사용
* [v-cloak] {display: none}과 같은 CSS 규칙과 함께 사용
* Vue Instance가 준비되면 v-cloak는 제거됨

​            

### Vue method

* Vue Instance는 생성과 관련된 data 및 method의 정의 가능
* Method 안에서 data를 "this.데이터이름"으로 접근 가능
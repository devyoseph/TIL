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


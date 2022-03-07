# Vue 이벤트 핸들러

> HTML 클릭시 코드 실행 방법

## v-on:

> vue는 값이 바뀌면 실시간 랜더링 해주는 것을 이용한다.

* `v-on:`은 @로 축약가능하다.

```vue
 <button v-on:click="자바스크립트 코드">허위매물신고</button> <span>신고수 : {{}}</span>

 <button @click="자바스크립트 코드">허위매물신고</button> <span>신고수 : {{}}</span>
```

​        

* 신고 버튼 누르면 1씩 증가하도록 만들기

  ```vue
    <div v-for="i in 3" :key="i">
      <h4>{{products[i-1]}}</h4>
      <p>{{price[i-1]}} 만원</p>
      <button @click="declareCount[i-1]++">허위매물신고</button> <span>신고수 : {{declareCount[i-1]}}</span>
    </div>
  ```

  ```vue
  <script>
  export default {
    name: 'App',
    data(){
      return {
          style1: 'color : blue;',
          products : ['역삼동원룸', '천호동원룸', '마포구원룸'],
          price : [70,80,90],
          menu : ['Home', 'Products', 'About'],
          declareCount : [0,0,0],
      }
    },
    components: {
      
    }
  }
  </script>
  ```

  ​      

### 이벤트 종류 몇 가지

> 자동완성을 이용해 잘 살핀다.

​        

​       

# Vue에서 함수 관리

* <script> 내부 data{}안이 아닌 methods 항목을 추가하고 함수를 추가한다

````vue
<script>
export default {
  name: 'App',
  data(){
    return {
        style1: 'color : blue;',
        products : ['역삼동원룸', '천호동원룸', '마포구원룸'],
        price : [70,80,90],
        menu : ['Home', 'Products', 'About'],
        declareCount : [0,0,0],
    }
  },

  methods : {      //새로 추가한 부분
    increase(i){    //increase 함수를 추가 
      this.declareCount[i]++; //this 키워드: 현재 데이터 안에 있는 declareCount를 가져온다.
    }
  },

  components: {
  }
}
</script>
````

```vue
  <div v-for="i in 3" :key="i">
    <h4>{{products[i-1]}}</h4>
    <p>{{price[i-1]}} 만원</p>
    <button @click="increase(i-1)">허위매물신고</button> <span>신고수 : {{declareCount[i-1]}}
    <!--함수를 호출 가능-->
    </span>
  </div>
```


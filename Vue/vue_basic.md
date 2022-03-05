## {{ 데이터 바인딩 }}

> JS 데이터를 HTML에 꽂아넣는 문법

### - 데이터 보관통 만들기(변수와 같은 개념)

  ```vue
  <script>
  
  export default {
    name: 'App',
    
    data(){ //데이터 보관함: return 안에 변수들 보관 / 자바스크립트 기준 Object 자료로 저장
      return {
  			price1 : 60,
        price2 : 70,
        스타일 : 'color : blue', //CSS 속성값도 저장이 가능하다. 대신 불러올 때 :를 사용한다
      }
    },
    
    components: {
      
    }
  }
  </script>
  ```

* 데이터 바인딩 하는 이유
  1. HTML에서는  변수를 사용할 수 없기 때문에 Vue는 재사용성이나 유지보수면에서 떨어지는 것을 보완한다.
  2. **실시간 렌더링 기능** : 값이 변경되면 서버의 HTML에도 새로 반영해준다.
     * **웹 앱**을 만들 수 있다.
     * 부드럽게 변경된다.
  3. **CSS 속성 또한 바인딩이 가능하다**



​                  

### 판매 상품 작성 : 데이터 보관통을 이용했을 때

* 사용 전

```vue
<template>
  <img alt="Vue logo" src="./assets/logo.png">
  <div>
    <h4>XX 원룸</h4>
    <p>XX 만원</p>
  </div>
    <div>
    <h4>XX 원룸</h4>
    <p>XX 만원</p>
  </div>
</template>
```

* 사용 후

```vue
<template>
  <img alt="Vue logo" src="./assets/logo.png">
  <div>
    <h4 :style="스타일">{{room1}} 원룸</h4> <!-- :으로 사용하고 따옴표 안에 가둔다 --> 
    <p>{{price1}} 만원</p>
  </div>
    <div>
    <h4>{{room2}} 원룸</h4>
    <p>{{price2}} 만원</p>
  </div>
</template>
```



​        

### 배열을 활용한 데이터 활용

```vue
<template>
  <img alt="Vue logo" src="./assets/logo.png">
  <div>
    <h4 :style = 'style1'>{{products[0]}} 원룸</h4>
    <p>{{price[0]}} 만원</p>
  </div>
  
  <div>
    <h4>{{products[1]}} 원룸</h4>
    <p>{{price[1]}} 만원</p>
  </div>

  <div>
    <h4>{{products[2]}} 원룸</h4>
    <p>{{price[2]}} 만원</p>
  </div>
  
</template>

<script>
```


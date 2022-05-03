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




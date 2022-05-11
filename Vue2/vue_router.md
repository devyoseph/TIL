# Vue-router

> * 라우팅: 웹 페이지 간의 이동 방법
> * Vue.js의 공식 라우터
> * 라우터는 컴포넌트와 매핑
> * Vue를 이용한 SPA를 제작할 때 유용
> * URL에 따라 컴포넌트를 연결하고 설정된 컴포넌트를 보여준다.
>
> https://router.vuejs.org/kr

​                     

### vue-router 설치

* CDN 방식

  ```vue
  <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
  <script src="https://unpkg.com/vue-router@3.5.3/dist/vue-router.js"/>
  ```

* NPM 방식

  ```bash
  npm install vue-router
  ```

  ​             

​                      

### vue-router 연결

* 'routes' 옵션과 함께 router instance 생성
* **router 주입**하는 것을 잊으면 안된다!!

```vue
<body>
    <div id="app">
      <h1>SSAFY - Router</h1>
      <p>
        <router-link to="/">HOME</router-link>
        <router-link to="/board">게시판</router-link>
        <router-link to="/qna">QnA</router-link>
        <router-link to="/gallery">갤러리</router-link>
      </p>

      <!-- 현재 라우트에 맞는 컴포넌트가 렌더링 -->
      <router-view></router-view> <!-- 갈아 끼워지는 곳-->
    </div>
    <script>
      // 라우트 컴포넌트
      const Main = {
        template: "<div>메인 페이지</div>",
      };
      const Board = {
        template: "<div>자유 게시판</div>",
      };
      const QnA = {
        template: "<div>질문 게시판</div>",
      };
      const Gallery = {
        template: "<div>갤러리 게시판</div>",
      };

      // 라우터 객체 생성
      const router = new VueRouter({
        routes: [
          {
            path: "/",
            component: Main,
          },
          {
            path: "/board",
            component: Board,
          },
          {
            path: "/qna",
            component: QnA,
          },
          {
            path: "/gallery",
            component: Gallery,
          },
        ],
      });

      // Vue 인스턴트 라우터 주입
      const app = new Vue({
        el: "#app",
        router,
      });
    </script>
  </body>
```

​                 

### vue-router 이동 및 렌더링

> * 네비게이션을 위해 router-link 컴포넌트를 사용
>
> * 속성은 'to' prop을 사용
>
> * 기본적으로 `<router-link>`는 `<a>` 태그로 렌더링
>
>   ```vue
>   <router-link to="/">HOME</router-link>
>   <router-link to="/board">게시판</router-link>
>   ```
>
> * 현재 라우트에 맞는 컴포넌트가 렌더링된다.
>
>   ```vue
>   <!-- 현재 라우트에 맞는 컴포넌트 렌더링-->
>   <router-view></router-view>
>   ```
>
> * history 모드: url로 직접 쳐서 들어올 수 없다 (404에러)
>
>   ```java
>    const router = new VueRouter({
>           mode: "history",
>           routes: [
>             {
>               path: "/",
>               component: Main,
>             },
>             {
>               path: "/board",
>               component: Board,
>             },
>             {
>               path: "/qna",
>               component: QnA,
>             },
>             {
>               path: "/gallery",
>               component: Gallery,
>             },
>           ],
>         });
>   ```
>
> * 라우터를 외부 js와 연결
>
>   ```vue
>   <script type="module" src="app.js"></script>
>   ```
>
>   ​             

​                  

### $router, $route

* 라우터 설정

  ```vue
  
  ```

* 라우터 링크

  ````vue
   <router-link to="/board/30">30번 게시글</router-link>
  ````

* 전체 라우터 정보

  ```js
  this.$router
  ```

* 현재 호출된 해당 라우터 정보

  ```js
  this.$route
  this.$route.params.no
  this.$route.path
  ```

​           

### vue-router 이동 및 렌더링

* v-for 응용

```vue
export default {
  template: `<div>
    자유 게시판
    <ul>
      <li v-for="i in 5">
        <router-link :to="'/board/' + i">{{i}}번 게시글</router-link>
      </li>
    </ul>
  </div>`,
};
```

​           

### 이름을 가지는 라우트

* 라우트는 연결하거나 탐색을 수행할 때 이름이 있는 라우트를 사용

* Router Instance를 생성하는 동안 routes 옵션에 지정

  ```js
  // 라우터 객체 생성
  const router = new VueRouter({
    routes: [
      {
        path: '/',
        name: 'main',
        component: Main,
      },
      {
        path: '/board',
        name: 'board',
        component: Board,
      },
      {
        path: '/board/:no',
        name: 'boardview',
        component: BoardView,
      },
      {
        path: '/qna',
        name: 'qna',
        component: QnA,
      },
      {
        path: '/gallery',
        name: 'gallery',
        component: Gallery,
      },
    ],
  });
  ```

* 이름 호출

  ```vue
  <body>
      <div id="app">
        <h1>SSAFY - Router</h1>
        <p>
          <router-link :to="{name: 'main'}">HOME</router-link>
          <router-link :to="{name: 'board'}">게시판</router-link>
          <router-link :to="{name: 'qna'}">QnA</router-link>
          <router-link :to="{name: 'gallery'}">갤러리</router-link>
        </p>
        <router-view></router-view>
        <div>만든이 : SSAFY</div>
      </div>
  
      <script type="module" src="app.js"></script>
    </body>
  ```

​                     

### 프로그래밍 방식 라우터

* `<router-link>`를 사용하여 선언적 네비게이션용 anchor 태그를 만드는 것 외에도 라우터의 instance method를 사용하여 프로그래밍으로 수행

  ```js
  $router.push('home')
  $router.push({path: 'home'})
  $router.push({name: 'boardview', params: { no: 3 }})
  $router.push({path: '/board', query: {pg : 1}})
  ```

* 예제

  ```vue
  export default {
    template: `<div>
      자유 게시판
      <ul>
        <li v-for="i in 5">
          <a :href="'#' + i" @click="$router.push({name: 'boardview', params: {no: i}})">{{i}}번 게시글</a>
        </li>
      </ul>
    </div>`,
  };
  ```

  ​            

### 중첩된 라우트 + 라우트 리다이렉트

* 앱 UI는 일반적으로 여러 단계로 중첩된 컴포넌트 구조임
* URL의 세그먼트가 중첩된 컴포넌트의 특정 구조와 일치하는 것을 활용
* `children` 속성을 이용해서 하위 URL 주소를 설정해줌
* `redirect`를 이용해서 `/board`만 입력해도 `board/list` 로 이동 

```js
// 라우트 컴포넌트
import Main from './components/Main.js';
import Board from './components/Board.js';
import QnA from './components/QnA.js';
import Gallery from './components/Gallery.js';
// import NotFound from './components/NotFound.js';
import BoardView from './components/board/BoardView.js';
import BoardUpdate from './components/board/BoardUpdate.js';
import BoardWrite from './components/board/BoardWrite.js';
import BoardList from './components/board/BoardList.js';

// 라우터 객체 생성
const router = new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'main',
      component: Main,
    },
    {
      path: '/board',
      name: 'board',
      component: Board,
      redirect: '/board/list',
      children: [
        {
          path: 'list',
          name: 'boardlist',
          component: BoardList,
        },
        {
          path: 'write',
          name: 'boardwrite',
          component: BoardWrite,
        },
        {
          path: 'detail/:no',
          name: 'boardview',
          component: BoardView,
        },
        {
          path: 'update/:no',
          name: 'boardupdate',
          component: BoardUpdate,
        },
      ],
    },
    {
      path: '/qna',
      name: 'qna',
      component: QnA,
    },
    {
      path: '/gallery',
      name: 'gallery',
      component: Gallery,
    },
    // {
    //   path: '/404',
    //   name: 'notFound',
    //   component: NotFound,
    // },
    // {
    //   path: '*',
    //   redirect: '/404',
    //   // component: NotFond
    // },
  ],
});

// Vue 인스턴트 라우터 주입
const app = new Vue({
  el: '#app',
  router,
});

```


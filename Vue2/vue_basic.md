# Vue.js

> 공식 사이트: https://vuejs.org/
> 한글 공식문서의 효율이 매우 좋아서 교재를 살 필요가 없다.      
>
> Vue.js Installation(CDN)
>
> * https://kr.vuejs.org/v2/guide/installation.html
> * 개발 버전과 배포 버전이 따로 있음
>
> ```html
> <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
> ```
>
> ​        
>
> **Vue.js**
>
> * Evan You에 의해 만들어짐
> * Vue 탄생은 Goole에서 Angular로 개발하다가 가벼운 걸 만들어 보고 싶은 생각으로 생각한 개인 프로젝트
> * 사용자 인터페이스를 만들기 위해 사용하는 오픈소스 Progressive Framework
>
> ​           
>
> **Vue.js 특징**
>
> * Approachable (접근성)
> * Versatile (유연성)
> * Performant (고성능)
>
> ​           
>
> **VS CODE 확장 프로그램**
>
> * Material Theme
> * Live Server
> * Bracket Pair Colorization Toggler
> * indent-rainbow
> * Auto Rename Tag
> * HTML CSS Support
> * TabOut: Tab을 누르면 Tab 단위로 이동(이클립스 기본 기능 중 하나)
> * Prettier - Code formatter
>   * Tab width: 2
>   * Print width: 100
>   * Javascript > Preference Quite Style: Double
>   * Format On save: Check
>
> * Vetur: .vue 파일에 코드생성, 문법 강조, 자동완성, 디버깅, vue 입력 시 template, script, style 자동완성
> * Vue 3 Snippets : 띄어쓰기를 주의해서 검색한다(200만 다운로드 이상).
>
> ​                      
>
> **Vue.js devtools - Chrome**
>
> * https://chrome.google.com/webstore/detail/vuejs-devtools/nhdogjmejiglipccpnnnanhbledajbpd
>
> ​            

​                   

## MVVM 패턴

* Model(Plain Javascript) + View(html) + ViewModel(Vue: DOM Listener, Data Binding)

* Model: 순수 자바스크립트 객체

* View: 웹페이지의 DOM

* ViewModel: Vue의 역할

  * 기존에는 자바스크립트로 view에 해당하는 DOM에 접근하거나 수정하기 위해 jQquery와 같은 library 이용
  * Vue는 view와 Model을 연결하고 자동으로 바인딩하므로 양방향 통신을 가능하게 함

  <img src="https://cheonmro.github.io/images/vue.png" alt="Vue" style="zoom: 25%;" />

​                    

### MVC와 MVVM의 차이

​             

#### - MVC

> MVC: Controller에 요청이 오면 Model을 통해 Data를 갱신하고 다시 받아 View로 보내줌

<img src="https://velog.velcdn.com/images/jungjaedev/post/ff2e0e72-0ef0-4b48-9c80-f4113133faf6/mvc.png" alt="post-thumbnail" style="zoom: 67%;" />

​              

#### - MVVM

> View에서 변경되면 ViewModel이 바인딩을 통해 알아내서 javascript를 통해 Model의 Data를 갱신 

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/87/MVVMPattern.png/500px-MVVMPattern.png" alt="MVVMPattern.png"  />

​                      


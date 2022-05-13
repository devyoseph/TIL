# 기술 면접 대비

​                

1. 서버에는 동기 비동기의 개념이 없다.
   * Controller를 통해 받아서 리턴값을 어떻게 조정하냐의 차이지 백엔드는 무조건 동기다.
   * 그래서 비동기를 물어본다면 client 입장에서 비동기를 물어보는 것이다. HTTP 통신을 할 때 client가 request시 동기든 비동기든 string 형태로 통신하는데 비동기 방식은 HTML 페이지 전체를 리로드 하지 않고 client가 요청하는 값만으로 필요한 부분만 리로드해서 보여줄 수 있다. 이 때의 방식으로 json이나 xml을 사용한다. 
   
2. Autowired vs 생성자 주입?

3. CSR vs SSR
   * CSR: 클라이언트 사이드 렌더링
     * 클라이언트 입장에서 화면을 구성해서 랜덩링하는 방식: vue, react 등
     * MVVM
   * SSR: 서버 사이드 랜더링
     * 서버 입장에서 화면을 구성해 랜더링하는 방식
     * MVC
   * 후속 질문: react나 vue의 디자인 패턴?
     * MVVM: ViewModel이 binding을 통해 View 단을 잡아주고 Model(javascript)에게 요청해 값을 갱신

4. DOM이란 무엇인가?

   * Document Object Model: 웹페이지를 객체로 표현한 모델 ex) HTML

   1. 가상 DOM이란?
      * 실제 DOM(html)을 ViewModel로 모양을 본 떠서 관리
      * ViewModel의 create 후 mount 하는 것이 곧 가상 DOM으로 생성이 완료된 것이다.
      * 불필요한 렌더링 횟수를 줄일 수 있다.
        * 가상돔을 리렌더링한다음 이전 가상돔과 비교해 바뀐 부분만 Real DOM에 적용
   
4. async와 await 의 단점

   * 비동기는 원래 클라이언트가 다른 작업을 처리할 때 통신한 내용을 바탕으로 로드해주는 것인데
* await를 쓰면 비동기를 동기적인 방식으로 바꾸는 것이다(lock을 걸어서 지연시킴).

6. SPA란 무엇인가?
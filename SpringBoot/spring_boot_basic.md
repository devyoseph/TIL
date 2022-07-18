# Spring Boot 복습

​                    

## 1. 동작 원리

> Spring으로 요청(request)를 받는다고 하면 담당하는 Controller가 바로 신호를 받는 것으로 오해할 수 있다.
> 하지만 모든 url 요청은 `Dispatcher Servlet`이 담당한다.

* 인텔리제이 서버 시작 모습

![image-20220718222817732](spring_boot_basic.assets/image-20220718222817732.png)

​                   

### 1) Legacy: Spring MVC 동작

* [프론트 컨트롤러 패턴](https://github.com/devyoseph/TIL/blob/master/Servlet&JSP/design_pattern.md): Servlet에는 치명적인 단점이 존재한다. Servlet 코드를 수정하면 서버를 재시동해야 변경된 코드가 적용되었다. 이를 위해 단 하나의 Servlet만 허용하고 들어온 요청을 HandlerMapping이 분석해주면 @Annotation으로 매핑되어있는 Controller를 찾아 신호를 보내는 것이다.
* Servlet을 써야만 하는 이유? = 빠르다(컴파일)

<img src="spring_boot_basic.assets/image-20220718222921417.png" alt="image-20220718222921417" style="zoom:50%;" />

​                    

### 2) Spring Boot + SPA

> 페이지 이동에 대한 관여가 없어졌고 A 주소에서 데이터를 받고 다시 A 주소로 데이터를 넘겨주는 일을 일반적으로 한다.
> 소셜 로그인의 경우 A에서 데이터를 받기 -  B로 데이터를 주기 - B에서 데이터 받기 - A로 데이터 넘겨주기 등 방식 사용

* 프론트 컨트롤러 패턴
* 페이지 이동
  * 이전: 백엔드에서 페이지 이동을 담당
  * SPA 환경: Vue의 경우 `Redirect`를 이용한 직접적인 페이지 이동이 막혀있기도 하다. 프론트에서 페이지 이동을 관리한다.

<img src="spring_boot_basic.assets/image-20220718224340896.png" alt="image-20220718224340896" style="zoom:67%;" />

* 데이터 이동
  * DTO 사용
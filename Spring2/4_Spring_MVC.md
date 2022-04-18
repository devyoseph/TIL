# Spring Web MVC

​                

## 1. Spring Web MVC

> 어플리케이션 확장을 위해 Model, View, Controller 세가지 영역으로 분리.
> 컴포넌트의 변경이 다른 영역 컴포넌트에 영향을 미치지 않음(유지보수 용이).
> 컴포넌트 간의 결합성이 낮아 프로그램 수정 용이(확장성이 뛰어남).
>
> ​             
>
> \- 특징
>
> * Spring은 DI나 AOP 같은 기능 뿐만 아니라 Servlet 기반의 WEB 개발을 위한 MVC Framework 제공
> * Spring MVC는 Model2 Architecture와 Front Controller Pattern을 Framework 차원에서 제공
> * Spring MVC Framework는 Spring을 기반으로 하고 있기 때문에 Spring이 제공하는 Transaction 처리나 DI 및 AOP 등을 손쉽게 사용
>
> ​         
>
> \- 장점
>
> * 화면과 비즈니스 로직을 분리해서 작업 가능
> * 영역별 개발로 인하여 확장성이 뛰어남
> * 표준화된 코드를 사용하므로 공동작업이 용이하고 유지보수성이 좋음
>
> ​           
>
> \- 단점
>
> *  개발과정이 복잡해 초기 개발속도가 늦음
> * 초보자가 이해하고 개발하기에 다소 어려움
>
> ​         

* **MVC(Model-View-Controller) Pattern**
  * Model
    * 어플리케이션 상태의 캡슐화
    * 상태 쿼리에 대한 응답
    * 어플리케이션의 기능 표현
    * 변경을 view에 통지
  * View
    * 모델을 화면에 시각적으로 표현
    * 모델에게 업데이트 요청
    * 사용자의 입력을 컨트롤러에게 전달
    * 컨트롤러가 view를 선택하도록 허용
  * Controller
    * 어플리케이션의 행위 정의
    * 사용자 액션을 모델 업데이트와 mapping
    * 응답에 대한 view 선택

​            

* **Spring MVC 구성요소**

  ![img](https://velog.velcdn.com/images%2Fjakezo%2Fpost%2F0fbb145d-b52a-46ed-a042-c3ec76ff7225%2F%EA%B8%B02.png)

  * DispatcherServlet(Front Controller)
    * 모든 클라이언트의 요청을 전달받음
    * Controller에게 클라이언트의 요청을 전달하고 Controller가 리턴한 결과값을 View에게 전달하여 알맞은 응답 생성
  * HandlerMapping
    * 클라이언트의 요청 URL을 어떤 Controller가 처리할지를 결정
    * URL과 요청 정보를 기준으로 어떤 핸들러 객체를 사용할지 결정하는 객체이며 DispatcherServlet은 하나 이상의 핸들러 매핑을 가질 수 있음.
  * Controller
    * 클라이언트의 요청을 처리한 뒤 Model을 호출하고 그 결과를 DispatcherServlet에 알려준다.
  * ModelAndView
    * Controller가 처리한 데이터 및 화면에 대한 정보를 보유한 객체
  * ViewResolver
    * Controller가 리턴한 뷰 이름을 기반으로 Controller의 처리 결과를 보여줄 View 결정
  * View
    * Controller의 처리결과를 보여줄 응답화면을 생성

​       

* **Spring MVC 실행순서**
  1. DispatcherServlet이 요청을 수신	
     * 단일 Front Controller Servlet
     * 요청을 수신하여 처리를 다른 컴포넌트에 위임
     * 어느 Controller에 요청을 전송할지 결정
  2. DispatcherServlet은 Handler Mapping에 어느 Controller를 사용할 것인지 문의
     * URL과 Mapping
  3. DispatcherServlet은 요청은 Controller에게 전송하고 Controller는 요청을 처리한 후 리턴.
     * Business Logic 수행 후 결과 정보(Model)가 생성되어 JSP와 같은 View에서 사용됨
  4. ModelAndView Object에 수행결과가 포함되어 DispatcherServlet에 리턴
  5. ModelAndView는 실제 JSP정보를 갖고 있지 않으며 ViewResolver가 논리적 이름을 실제 JSP이름으로 변환
  6. View는 결과정보를 사용하여 화면을 표현

​          

* **Spring MVC 구현**

  * Spring MVC를 이용한 Application 구현 Step

    * web.xml 에 DispatcherServlet 등록 및 Spring 설정파일 등록

      > * <init-param\>을 설정하지 않으면 <servlet-name\>-servlet.xml 파일에서 applicationContext의 정보를 load
      > * Spring Container는 설정파일의 내용을 읽고 ApplicationContext 객체를 생성
      > * <url-pattern\>은 DispatcherServlet이 처리하는 URL Mapping pattern 정의
      > * Servlet이므로 1개 이상의 DispatcherServlet 설정 가능
      > * <load-on-startup\>1<load-on-startup\>설정 시 WAS startup 시 초기화 작업 진행

    * 설정파일에 HandlerMapping 설정

    * Controller 구현 및 Context 설정 파일(servlet-context.xml)에 등록

    * Controller와 JSP의 연결을 위해 View Resolver 설정

    * JSP 코드 작성

  * **좋은 디자인**

    * Controller가 많은 일을 하지 않고 Service에 처리를 위임
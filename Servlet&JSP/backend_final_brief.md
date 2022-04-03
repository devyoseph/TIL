## Backend 요약

​        

#### 1. Web Architecture = Client & Server

* Client = Web Browser : data 발생, Server로 request
* Server = WAS(Web Server + Application Server) + RDBMS
  * Application Server에서 Bussiness / Persistence Logic 처리 및 Presentation 수행
  * 요청한 결과를 Client에게 response

​         

#### 2. Servlet(서블릿)

* java를 이용해 웹페이지를 동적으로 생성하는 서버측 프로그램
* 자바코드 안에 HTML 코드를 포함하는 형태
* 상속형태
  * Servlet(interface) / ServletRequest, ServletResponse (interface)
  * GenericServlet(class) / HttpServletRequest, HttpServletResponse (interface)
  * HttpServlet(class) 을 구현 = 현재 서블릿

​             

#### 3. Servlet Life-Cycle

* Servlet class는 main method가 없다.

* 객체의 생성과 사용의 주체는 Servlet Container가 담당한다.

  * 그래서 Container가 생성, 삭제할 때 메소드를 이용해 기능을 수행할 수 있다.

  | method            | description                                   |
  | ----------------- | --------------------------------------------- |
  | init()            | 서블릿이 메모리에 로드(Constructor)될 때 호출 |
  | service()         | doGet(), doPost() 로 이동하기 전 실행         |
  | doGet(), doPost() | GET/POST 방식으로 data 전송시 호출            |
  | destroy()         | 서블릿이 메모리에 해제될 때 호출              |

  ​          

#### 4. Parameter 전송방식

|      | GET                                                          | POST                                                         |
| ---- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 특징 | 전송되는 데이터가 URL 뒤에 Query String 으로 전달<br />입력 값이 적은 경우나 데이터가 노출되어도 문제가 없는 경우 사용 | URL과 별도로 전송<br />HTTP header 뒤 body에 입력 스트림 데이터로 전달 |
| 장점 | 간단한 데이터를 빠르게 전송<br />form 태그 뿐 아니라 직접 URL에서 입력해 전송할 수 있다. | 데이터의 제한이 없다<br />최소한의 보안 유지 효과를 볼 수 있다. |
| 단점 | 데이터 양에 제한이 있다.<br />location bar(URL + parameter)의 최대 데이터 사이즈는 2kb(2048kb)로 제한된다. | 전달 데이터 양이 같은 경우 GET방식보다 느리다.(전송 패킷을 body에 데이터로 구성해야한다.) |

​           

#### 5. JSP(Java Server Page)

* 자바 서버 페이지는 HTML 내에 자바 코드를 삽입해 동적으로 웹페이지를 구성하게 해주는 언어이다.
* 실행시 **자바 서블릿**으로 변환된다.
* 최초 jsp 요청시 servlet class로 컴파일 된 후 메모리에 적재된다.

​            

#### 6. JSP Scriptlet

1. 선언(Declaration): 멤버변수 선언이나 메소드를 선언

   ```jsp
   <%!
     String name;
   public void init(){
     name = "홍길동";
   }
   %>
   ```

2. 스크립트릿(Sciptlet): Client 요청 시 매번 호출하는 영역

   ```jsp
   <% java code %>
   ```

3. 표현식(Expression): 데이터를 브라우저에 출력

   ```jsp
   <%= 문자열 %>
   ```

   ```jsp
   <% out.print("문자열"); %>
   ```

4. 주석(Comment)

   ```jsp
   <%-- 주석 할 code --%>
   ```

   * HTML 주석과 달리 client에게 전송이 안된다.

​           

#### 7. JSP Directive(지시자)

1. page Directive: 현재 페이지를 어떻게 할 것인가 정보 제공

   ```jsp
   <%@ page attr1="val1" attr2="var2" %>
   ```

   * language = "java"
   * contentType = "text/html; charset=ISO-8859-1" [브라우저로 보내는 내용의 MIME 형식 지정, 문자 집합 지정]
   * import = "" [현재 jsp 페이지에서 사용할 JAVA 패키지나 클래스 지정]
   * session = "true" [세션의 사용 유무 설정]
   * errorPage = "" [에러가 발생할 때 페이지 지정]
   * isErrorPage = "false" [현재 JSP 페이지가 에러 핸들링하는 페이지인지 지정하는 요소]
   * buffer: 버퍼의 크기
   * autoflash = "true" [버퍼의 크기를 자동으로 브라우저로 보낼지 설정]
   * isThreadsafe = "true" [멀티 쓰레드로 동작해도 안전한지 여부 설정]
   * Extends = "" [현재 JSP 페이지를 다른 클래스로부터 상속하도록 변경] 

2. include Directive: 특정 jsp file을 페이지에 포함

   ```jsp
   <%@ include file="상대 경로 혹은 WebContent로부터 경로" %>
   ```

3. taglib Directive: JSTL 또는 사용자에 의해 만든 커스텀 태그를 이용할 때 사용

   ```jsp
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   ```

​        

#### 8. JSP 기본 객체

> 함수가 아니라 객체로 생성되어있는 기본 객체이다.

| 기본 객체명 | 설명                                                         | Type                                   |
| ----------- | ------------------------------------------------------------ | -------------------------------------- |
| request     | HTML 폼 요소 등 사용자 입력 정보를 읽어올 때 사용            | javax.servlet.http.HttpServletRequest  |
| response    | 사용자 요청에 대한 응답을 처리하기 위해 사용                 | javax.servlet.http,HttpServletResponse |
| pageContext | 각종 기본 객체를 얻거나 forward 및 include 기능을 활용할 때 사용 | javax.servlet.jsp.PageContext          |
| session     | 클라이언트에  대한 세션 정보를 처리하기 위해 사용<br />page directive의 session 속성을 false로 하면 내장 객체 생성X | javax.servlet.http.HttpSession         |
| application | 웹 서버의 애플리케이션 처리와 관련된 정보를 레퍼런스하기 위해 사용 | javax.servlet.ServletContext           |
| out         | 사용자에게 전달하기 위한 output 스트림을 처리할 때 사용      | javax.servlet.jsp.JspWriter            |
| config      | 현재 JSP 페이지 대한 초기화 환경을 처리하기 위해 사용        | javax.servlet.ServletConfig            |
| page        | 현재 JSP 페이지에 대한 참조 변수                             | java.lang.Object                       |
| exception   | Error 를 처리하는 JSP의 isErrorPage 속성을 true로 설정하면 exception 내장 객체를 사용할 수 있다. 기본값은 false. 전달된 오류 정보를 담고있는 객체 | java.lang.Exception                    |

​         

#### 9. JSP Scope

| 기본객체    | 설명                                                         |
| ----------- | ------------------------------------------------------------ |
| application | 하나의 웹 어플리케이션과 관련된 영역<br />웹 어플리케이션 당 1개가 생성<br />같은 웹 어플리케이션에서 요청되는 페이지들은 같은 application 객체를 공유 |
| session     | 하나의 웹 브라우저와 관련된 영역<br />같은 웹 브라우저 내에서 요청되는 페이지들은 같은 session을 공유한다.<br />- 로그인 정보 등을 저장 |
| request     | 하나의 HTTP 요청을 처리할 때 사용되는 영역<br />웹 브라우저가 요청을 할 때마다 새로운 request객체가 생성<br />request영역에 저장한 속성은 그 요청에 대한 응답이 완료되면 사라진다. |
| pageContext | 하나의 JSP 페이지를 처리할 때 사용되는 영역<br />한번의 클라이언트 요청에 대해 하나의 JSP 가 호출<br />이 때 한 개의 page 객체가 대응된다.<br />페이지에 저장한 값은 페이지를 벗어나면 사라진다. |

​         

#### 10. JSP 공통 메서드

| method                                       | 설명                                                         |
| -------------------------------------------- | ------------------------------------------------------------ |
| void setAttribute(String name, Object value) | 문자열 name의 이름으로 객체를 저장                           |
| Object getAttribute(String name)             | 문자열 name에 해당하는 속성 값이 있다면 Object 형태로 가져오고 없다면 null을 리턴 |
| Enumeration getAttributeNames( )             | 현재 객체에 저장된 속성들의 이름들을 가져온다.               |
| void removeAttribute(String name)            | 문자열 name에 해당하는 속성을 지운다.                        |

​           

#### 11. WEB Page 이동

|              | forward(request, response)                                   | sendRedirect(location)                                      |
| ------------ | ------------------------------------------------------------ | ----------------------------------------------------------- |
| 사용 방법    | RequestDispatcher dispatcher = request.getRequestDispatcher(path);<br />dispatcher.forward(request, response); | response.sendRedirect(location);                            |
| 이동 범위    | 동일 서버 내 경로                                            | 동일 서버 포함 타 URL 이동 가능                             |
| location bar | 기존 URL 유지<br />실제 이동 주소 확인 불가                  | 이동하는 page로 변경                                        |
| 객체         | 기존의 request, response가 전달                              | 기존의 request, response가 소멸 후 새로 생성                |
| 속도         | 비교적 빠름                                                  | forward()에 비해 느림                                       |
| 데이터 유지  | request의 setAttribute(name, value)를 통해 전달              | request로는 데이터 저장 불가능<br />session이나 cookie 사용 |

​         

#### 12. Web Application Architecture

* Model1: client 요청에 대해 JSP가 Logic 처리와 response page 처리 모두 기능
  * Client: request - Server(JSP: Controller + view + model)
* Model2: response page에 대한 처리만 기능(=MVC: Model-View-Controller)
  * client 의 요청: Servlet = Controller
    * Client의 요청을 분석해 Logic 처리를 위한 Model 단을 호출한다.
    * return 받은 결과 data를 필요에 따라 request, session에 저장하고
    * redirect 나 forward 방식으로 jsp 페이지를 이용해 출력한다.
  * logic 처리: java class(Service, Dao, Dto) = Model
    * Logic을 처리하는 모든 것
    * controller에 넘어온 data를 이용해 이를 수행하고 그에 대한 결과를 controller에 리턴한다.
  * Response page: JSP = View
    * 모든 화면 처리를 담당, Client의 요청에 대한 결과 뿐 아니라 controller에 요청을 보내는 화면단도 jsp에서 처리
    * Logic 처리를 위한 java code는 사라지고 결과 출력만을 위한 code 존재

​         

#### 13. Http Protocol

* Client의 request를 Server 가 response
* 요청할 때만 연결하는 stateless 한 성질
* HTTP protocol의 단점을 보완하기 위해 Cookie와 Session을 사용한다.

​       

#### 14. Cookie

> 자동 전송이 default
> 요청시 서버가 먼저 만들고 client에게 그 내용을 전달한다.

* 서버에서 사용자의 컴퓨터에 저장하는 정보파일
* 사용자가 별도로 요청하지 않아도 브라우저는 request시 Request Header를 넣어 자동으로 서버에 전송
* key와 value로 구성 & **String** 형태
* Browser마다 저장되는 쿠키는 다르다.

**목적**

* 세션관리: 사용자의 아이디, 접속시간, 장바구니 등의 서버가 알아야 할 정보 저장
* 개인화: 개인마다 그 사람에 적절한 페이지 구현
* 트래킹: 사용자의 행동과 패턴을 분석하고 기록

#### 구성요소

* 이름, 값, 유효기간, 도메인(쿠키를 전송할 도메인), 경로(path: 쿠키를 전송할 요청 경로)

#### 동작순서

1. client가 페이지 요청
2. WAS가 cookie 생성
3. HTTP Header에 Cookie를 넣어 응답(response의 header)
4. Browser는 넘겨받은 Cookie를 PC에 저장하고 WAS가 요청할 때 Cookie 전송
5. Browser가 종료되어도 유효기간이 남아있다면 Client는 계속 보관
6. 동일 사이트 재방문시 PC에 client가 있다면 request Header에 Cookie를 같이 전송

#### Cookie의 특징

* 이름, 값, 유효기간, 도메인, path로 구성되어있다.
* 클라이언트에 300개의 쿠키를 저장 가능
* 하나의 도메인 당 20개의 쿠키 가능
* 하나의 쿠키 = 4KB(4096byte)까지 저장 가능

#### Cookie 메서드

* 생성

  ```java
  Cookie cookie = new Cookie(String name, String value);
  ```

* 값/도메인/범위 변경

  ```java
  cookie.setValue(String value);
  cookie.setDomain(String domain);
  cookie.setPath(String path);
  
  cookie.getValue();
  cookie.getDomain();
  cookie.getPath();
  ```

* 유효기간 설정

  ```java
  cookie.setMaxAge(60*60*24); //초단위
  cookie.setMaxAge(0); //쿠키 삭제
  ```

* client에 전송

  ```java
  response.addCookie(cookie);
  ```

* client에서 쿠키 얻기

  ```java
  Cookie cookies[] = request.getCookies();
  ```

​         

#### 15. Session

* 방문자가 서버에 접속해 있는 상태를 하나의 단위로 보고 그것을 세션이라고 한다.
* WAS memory에 Object 형태로 저장
* memory가 허용하는 용량까지 제한 없이 사용가능

#### 동작 순서

* 클라이언트가 페이지 요청
* 서버는 접근한 클라이언트의 Reqeust-Header의 Cookie를 확인해 클라이언트가 session-id를 보냈는지 확인
* 만약 session-id가 없다면 서버는 새로 생성해서 클라이언트에게 돌려준다.
* 서버에서 클라이언트로 돌려준 session-id를 쿠키를 이용해 서버에 저장한다. (톰캣: 쿠키 이름 JSESSIONID)
* 클라이언트는 재접속시 이 쿠키(JSESSIONID)를 이용해 session-id를 서버로 전달한다.

#### session의 특징

* 웹 서버에 웹 컨테이너 상태를 유지하기 위한 정보 저장
* 웹 서버에 저장되는 쿠키(=세션 쿠키)
* 브라우저를 닫거나 서버에서 세션을 삭제했을 때 삭제가 되므로 쿠키보다 보안이 좋다.
* 저장 데이터 제한이 없다.
* 각 클라이언트 고유 Session ID 부여한다.
* Session ID로 클라이언트를 분류하여 각 요구에 맞는 서비스를 제공한다.

#### HttpSession의 주요 기능

| 기능             | method                                                       |
| ---------------- | ------------------------------------------------------------ |
| 생성             | HttpSession session = request.getSession();<br />HttpSession session = request.getSession(false); // 없으면 굳이 생성하지 않는 것 |
| 저장             | session.setAttribute(String name, Object value)              |
| 얻기             | session.getAttribute(String name)                            |
| 제거             | session.removeAttribute(String name);<br />session.invalidate(); |
| 생성시간         | session.getCreationTime();                                   |
| 마지막 접근 시간 | session.getLastAccessedTime();                               |

​          

#### 16. Session & Cookie

|           | Session                                                      | Cookie                             |
| --------- | ------------------------------------------------------------ | ---------------------------------- |
| Type      | javax.servlet.http.HttpSession (interface)                   | javax.servlet.http.Cookie (Class)  |
| 저장 위치 | 서버 memory에 오브젝트로 저장                                | Client 각 PC에 file로 저장         |
| 저장 형식 | Objects 모두 가능                                            | file에 저장되기 때문에 String      |
| 사용 예   | 로그인, 장바구니                                             | 아이디 저장, 오늘은 그만 열기 등   |
| 용량제한  | 없음(메모리가 허락하는한 가능)                               | 4KB(4096bytes), 도메인당 20개      |
| 만료시점  | Web.xml 서버측의 설정에 따라 결정                            | 쿠키 저장시 설정된 만료기간에 따라 |
| 공통      | 프로젝트 내 모든 JSP에서 사용 가능<br />Map 형식으로 관리하기 때문에 key값의 중복X |                                    |

​            

#### 16. Expression Language

> dot 표기법(.)과 [ ] 연산자 표기법이 존재한다.

* 왼쪽: Java.util.Map 객체 또는 Java Bean 객체

* 오른쪽: 맵의 키 또는 Bean의 프로퍼티

  ```jsp
  ${Map.Map의 키}
  ${Java Bean.Bean 프로퍼티}
  ```

* [] 표기법

  ```java
  ${userinfo["name"]} // [ ] 표기법
  ```

  ```java
  ${userinfo.name} // dot
  ```

​         

#### 17. EL 내장객체

> JSP의 pageContext의 반환값 Java Bean을 제외하고 모두 리턴 값은 Map이다.

* scope

  * 같은 저장된 객체가 겹칠 수 있으므로 해당 스코프 내의 객체를 딱 가져올 수 있다.
    * pageScope / requestScope / sessionScope / applicationScope

* param / paramValues

  ```jsp
  ${param.id}
  ${paramValues.id[0]}
  ${paramValues.id[1]}
  ```

* cookie = HttpServletRequest.getCookies()의 줄임으로 **배열을 리턴**함에 주의한다.

  * 오히려 이를 활용해 원하는 cookie 만 꺼내올 수 있다.

    ```java
    ${cookie.userId.value} // request.getCookies() + getName() + getValue()
    ```

    

​       

#### 18. EL 이름만 사용

* 이름만 사용하는 경우 자동으로 pageScope -> requestScope -> sessionScope -> applicationScope를 찾는다.

* 이름이 특이하면 []표현식 사용

  ```jsp
  ${requestScope["ssafy.user"].name}
  ```

​       

### 19. EL operator

* 산술: + - / %

* 관계형: ==(eq) !=(ne) <(lt) >(gt) <=(le) >=(ge)

* 3항 연산: 조건? 값1: 값2

* 논리: || && !

* 타당성 검사 empty

  * 비어있다는 판단

    * "", 빈 배열, null, 빈 Map, 빈 Collection

     

#### 20. JSTL (Java Standard Tag Library)

* Custom tag 중 많이 사용되는 것들을 모아서 JSTL 규약을 만들었다.
* c / x / fmt / sql

​         

#### 21. Core tag

* set: 변수 설정 = jsp 페이지에서 사용할 변수

  * value(내부 body태그 안에 값을 그냥 넣을 수도 있다.)
    * var - scope - value
    * property - target - value
  * var은 변수 이름 설정이고 property는 프로퍼티 이름 설정이므로 둘 중 하나만 설정해주어야 한다.
  * target은 property와 같이 지정되어야 하며 어느 객체에 설정한 프로퍼티인지 적어주는 곳이다.
    * EL문 등 사용

* if = 조건에 따른 코드 실행: **var** = test의 결과값을 담을 변수명

  ```jsp
  <c:if test="${}" var="accessible">
  </c:if>
  ```

* choose, when, otherwise

  ```jsp
  <c:choose>
  	<c:when test=" "> </c:when>
    <c:when test=" "> </c:when>
    <c:otherwise> </c:otherwise>
  </c:choose>
  ```

* forEach: var / items

* catch: var로 오류를 받아준다

  ```jsp
  <c:catch var = "ex">
  </c:catch>
  
  <c:if test="${ex != null}">
  	예외가 발생했습니다. ${ex.message}
  </c:if>
  ```

  
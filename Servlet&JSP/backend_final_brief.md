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

#### 12. 
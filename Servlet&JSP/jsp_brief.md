## JSP 요약

​          

### 1. import 3가지 방법

1. `,`로 나열하는 방법: 세미콜론을 사용하지 않음에 주의한다.

   ```jsp
   <% page import = "java.util.*, java.sql.*" %>
   ```

2. 각각 import가 가능하다

   * `<% 실행문 %>` 내부에서 클래스명을 자동완성 클릭하면 자동으로 import 해준다. 

   ```jsp
   <% page import = "java.util.*" %>
   <% page import = "java.sql.*" %>
   ```

3. 실행문 내부에서 패키지 풀네임으로 import가 가능하다

   ```jsp
   <%
   	java.util.Calendar now;
   %>
   ```

​          

### 2. 실행문에서 선언시 에러가 발생하는 이유

* 지시자(Directive), 선언문(Declaration), Scriptlet(실행문)의 차이는 **컴파일 이후의 위치**이다.

1. `<%@ %>` 는 지시자로 변환된 Servlet문서 최상단에 위치한다.

2. `<%! %>` 는 선언문으로 service 외부 위에 위치한다.

   * 변수를 선언할 경우 service 메서드 내에서 자유롭게 변수로 활용 가능
   * 메서드 외부 공간: 함수 선언이 가능하다.
   * `out.println`과 같은 메서드 정의 이전이기 때문에 사용시 오류가 발생한다.
   * 현업에서 잘 사용하지 않는다.

3. `<% %>` 는 Scriptlet(let 영역)으로 service 내부에 위치한다.

   ```jsp
   <% out.println("클라이언트로 보냄") %>
   ```

   * `out.println` 사용이 가능하다.
   * 변수를 선언할 경우 지역 변수로 활용한다.
   * 메서드 내부 공간: 함수 선언이 불가능하다.

|                           | Directive   | Declaration        | Scriptlet           |
| ------------------------- | ----------- | ------------------ | ------------------- |
| 문법                      | `<%@` `%>`  | `<%!` `%>`         | `<%` `%>`           |
| **Servlet  변환 후 위치** | 문서 최상단 | service 외부 맨 위 | service 메서드 내부 |
| 변수 선언                 | X           | O                  | O                   |
| 함수 선언                 | X           | O                  | X                   |
| `out.println()`           | X           | X                  | O                   |

4. `<%= %>` 는 표현식(Expression)으로 간단히 변수를 출력할 수 있다.

   ```jsp
   <%= %>
   <% out.print() %>
   <% out.write() %>
   ```

​         

### 3. parameter 형식에 맞지 않을 때 error 발생에 대처(500)

* try~catch 를 활용한다.

```jsp
<%
	String age = request.getParameter("age");
	int nage = 0;
	
	try{
    	nage = Integer.parseInt(age);
	}catch(NumberFormatException e){
    	nage = 10; //default 나이
	}
	
	out.print(nage);
%>
```

​        

### 4. Directive page

* contentType: **브라우저**에게 보내는 문자 형식 (서버 -> 클라이언트)
* autoflush: `out.flush()`를 활용한다.

​         

​      

### 5. 웹 페이지 이동

* 클라이언트에서 서버에 접속하면 무슨 메소드를 호출하는가?
  * doPost(X), doGet(X)
  * service()가 가장 먼저 호출되고 `request.getMethod()`메서드를 통해 method 값을 구하고 switch 문을 사용해 그 값에 따라 `doGet()`과 `doPost()`를 선택하여 호출한다.

* `response.sendRedirect( "경로 ");`
  * URL: `https://`를 붙이지 않으면 이동X
  * 상대경로: 로컬의 jsp로 이동

​          

### 6. Get 방식에서 주의할 점

* `/`는 서버를 기준으로 이동하기 때문에 아래와 같은 코드에서는 문제가 발생한다.

```html
<form action = "/sam" method = "get">
    <input type = "submit">
</form>
```

* 또한 `root명/sam`이렇게 하더라도 `root`명에서 다시 찾으려고 하기 때문에 `/root명/sam` 으로 명확하게 정의해준다.

```html
<form action = "/jtest/sam" method = "get">
    <input type = "submit">
</form>
```

​            

### 7. JSP의 Scope

> 범위: application > session > request > pageContext
>
> * application은 생성시 전체에서 하나 만들어진다. request가 생성될 때 이미 application은 생성되므로 새로 생성하는 것이 아니라 request를 통해 불러오는 것이다.
>
>   ```java
>   ServletContext context = request.getServletContext();            
>   ```

​            

### 8. setAttribute(), getAttribute()

> forward 등으로 이동할 때 Object로 감싸서 특정 값을 보낼 수 있다.
> 공통 메서드이므로 `request` 뿐 아니라 `session`,` application`, `pageContext`에서도 메서드를 사용할 수 있다.

#### - request

* 보내는 쪽: `setAttribute()`를 통해  `request`에 특정 값을 `Object`로 포장해서 묶어 보낸다.

  ```java
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      // 서블릿에서 jsp로 포워딩하기
      // 서블릿에서 직접 출력하는 구문은 없어야 한다.
      String path="d.jsp";
      String sam = "setAttribute 값";
      request.setAttribute("algo", sam);
      RequestDispatcher dispatcher = request.getRequestDispatcher(path);
      dispatcher.forward(request, response);
  }
  ```

* 받는 쪽: 받은 `request` 안에 묶여있는 값을 `getAttribute()`로 빼주고 `Object`로 포장된 값을 형변환해서 가져온다.

  ```jsp
  <%@ page language="java" contentType="text/html; charset=UTF-8"
      pageEncoding="UTF-8"%>
  
  <%
      String sam = null;
  
      if(request.getAttribute("algo") instanceof String){
          sam = (String) request.getAttribute("algo");
      }
  %>
  <!DOCTYPE html>
  
  <html>
  <head>
  <meta charset="UTF-8">
  <title>Insert title here</title>
  </head>
  <body>
  서블릿에서 forward되어 보이는 페이지
  <%= sam %>
  </body>
  </html>
  ```

  ​       

#### - application

* 어느 페이지에서 저장

  ```java
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      // 서블릿에서 jsp로 포워딩하기
      // 서블릿에서 직접 출력하는 구문은 없어야 한다.
      String path="d.jsp";
      
      ServletContext context = request.getServletContext();
      context.setAttribute("app_var", "어플리케이션 변수");
      RequestDispatcher dispatcher = request.getRequestDispatcher(path);
      dispatcher.forward(request, response);
  }
  ```

* 여러 페이지에서 꺼내어 사용 가능

  ```jsp
  <%
      String app_var = null;
      if(application.getAttribute("app_var") instanceof String){
          app_var = (String) application.getAttribute("app_var");
      }
  %>
  ```

  ​         

### 9. Session

> 하나의 웹 브라우저 영역에서 session이 공유된다.
> request는 요청마다 생성되므로 특정 속성값을 저장하는데 한계가 있다.(로그인 유무 등)

* Directive에서 `<%@ session=true %>` 설정이 되어있어야 session 객체를 사용할 수 있으며 default는 true이다.

  ```jsp
  <%@ page language="java" contentType="text/html; charset=UTF-8"
      pageEncoding="UTF-8" session="true" %>
  ```

* 1번 페이지에서 `session` 내부에 `setAttribute()`를 이용해 값을 넣을 수 있다.

  ```jsp
  <%
      String data = request.getParameter("share");
  
      session.setAttribute("data", data); // Directive에서 session이 true이기에 사용할 수 있다.
  %>  
  ```

* 2번 페이지에서 session은 유지되며 내부 속성값 또한 유지된다.

  ```jsp
  <%= (String) session.getAttribute("data") %>
  ```

* 이 때 session을 사용하는 1번, 2번 페이지 모두 `session=true`여야 한다.

​          

### 10.  include

> 1. include는 Directive 에서 사용할 수 있다.
> 2. include 내부에서 선언된 변수가 부모 문서에서 변수로 연결되어 영향을 준다.

* `header.jsp`

  ```jsp
  <%@ page language="java" contentType="text/html; charset=UTF-8"
      pageEncoding="UTF-8"%>
  이 부분은 모든 파일마다 항상 같이 출력됩니다.
  
  <%!
    String s = ""; // s라는 이름의 변수 설정
  %>
  ```

* `include`를 통해 가져온 다음 변수 선언

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%!
    String s = "123"; // s를 다시 외부에서 선언하면 500 오류 발생
%>

<%@ include file="footer.jsp" %>
</body>
</html>
```

* 해결: include를 닫아서 문서 내에서만 사용하는 변수로 한정해준다.

​          

### 11. 실행순서

> JSP 에 의해 Java 코드가 먼저 실행되고 Javascript가 실행되므로 오류가 발생할 수 있다.

* 오류 예시

  ```java
  <% String name = "홍길동"; %> // 변수를 미리 선언
  
  <script type="text/javascript">
      let num = prompt("숫자를 입력하세요");
      let name = <%= name %>;
  // 여기서 name은 java 코드이므로 javascript가 실행되지 않은 상태에서 실행되어 변수가 저장되지 않음
  
      if(num > 20){
          alert(name + "님은 어른입니다. "+num);
      }else{
          alert(name + "님은 어립니다. "+num);
      }
  
  </script>
  ```


​       

### 12. 보안 페이지

* Web-INF 폴더는 Client에서 접근이 불가능한 폴더이다. 그래서 이 안에 문서를 넣고 server 측에서 실행하면 URL이 아닌 서버를 통해 이동할 수 있다.

<img src="jsp_brief.assets/image-20220324131229584.png" alt="image-20220324131229584" style="zoom:50%;" />

*  또는 로그인 상태를 확인할 수 있는 속성값을 가져와 검사해 if문을 통해 나타낼 수 있다.

  ```jsp
  <% 
  MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
  if(memberDto == null){
  %>
  	<script>
  		alert("로그인 사용자만 볼 수 있는 페이지 입니다.");
      location.herf("<%= root %>/user?act=mvlogin");
  	</script>
  <%
  }	else{
  %>  
    <!-- 게시판 내용 -->
  }
  ```

  

​         

### 13. Front-Control 디자인 패턴

```java
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
    String action = request.getParameter("action");
		
    // hidden으로 숨겨진 input 의 값을 통해 분기해서 메서드로 처리
		switch(action) {
      case "mvmember": //회원가입하는 페이지
        doMvmember(request,response);
        break;
      case "insert": //회원가입하는 페이지
        doMemberInsert(request,response);
        break;
      }
		}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("uft-8");
		doGet(request, response);
	}
```

​        

### 14. 세션 시간 설정

* `Servers`-`Tomcat`-`web.xml`문서에 있는 `<session-timeout>`태그를 설정

​       

### 15. 404 페이지 꾸미기

* `WebContent`-`error`-`404.jsp` 파일을 만든다.

* `Servers`-`Tomcat`-`web.xml`문서에

  ```xml
  <error-page>
  	<error-code>404</error-code>
  	<location>/error/404.jsp</location>
  </error-page>
  ```

  ​      

### 16. 로그인 성공시 아이디 저장 기능 구현

> 쿠키를 확인하는 법: 크롬 - 개발자 도구 - Application - Storage - Cookies

* Servlet 에서 처리

```java
if("saveok".equals(idsv)){
// Cookie Setting: 만약 라디오 박스를 체크해서 위 if문을 통과한다면...

  	Cookie cookie = new Cookie("loginid", id);
  	cookie.setMaxAge(60*60*24*365*20);
		cookie.setPath(request.getContextPath());
		
  	// 쿠키를 만들고 Cookie를 붙여서 response로 던져준다.
  	response.addCookie(cookie);
} else { //아이디 저장 체크X
  	Cookie[] cookies = request.getCookies();

  	if(cookies != null){
      for(int i=0; i < cookies.length; i++){
        if(cookies[i].getName().equals("loginid")){
           	cookies[i].setMaxAge(0); // 쿠키의 수명을 0으로 만들어 지운다.
          	response.addCookie(cookies[i]); // 변경사항을 꼭 response에 묶어준다.
        }
      }
    }
}
```

* JSP에서 처리
  * 서버에서 request에 묶어서 보내준 쿠키들을 불러와야한다.

```jsp
<%
	Cookie[] cookies = request.getCookies(); // 모든 쿠키를 배열로 받는다.
	
//변수를 만들어 관리
	String svid = ""; //save id
	String ckid - "";

	if(cookies != null){
		for(int i=0; i < cookies.length; i++){
      if(cookies[i].getName().equals("loginid")){
					svid = cookies[i].getValue();
        	ckid = "checked"; // 다음 번 로그인에도 계속 체크박스가 체크되도록 하는 변수
      }
    }
  }
%>
```

​        

### 17. 로그인 이후 회원 정보창을 계속 띄워놓기

* include로 가져와서 나타낸다.

```jsp
<%@ include file="" %> 
```

​      

### 18. 클라이언트가 제목에 HTML 태그 쓰는 것을 방지

* < 태그를 문자열로 바꿔준다.

```java
guestBookDto.setSubject(rs.getString("subject").replace("<", "&lt;"));
```

​       

### 19. 지시자 3개

* <%@ %>
* include, page, taglib

​       

### 20. 배열로 annotation

```java
@WebServlet({"/list", "/sss"})
```

​         

### 21. Redirect, forward

* 삭제나 수정처럼 중복했을 때 문제가 발생할 수 있는 것 = Redirect인 것을 주의

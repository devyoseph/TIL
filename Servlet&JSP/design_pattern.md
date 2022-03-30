## 디자인 패턴

​         

### 커맨드 디자인 패턴

`act`를 hidden으로 숨겨놓고 `form`으로 전송한 다음 `act`의 값에 따라 명령을 분배하는 작업

​         

### 프론트 컨트롤 디자인 패턴

> **장점: 서블릿을 수정하는 방식은 전체 서버를 내리고 적용해야하지만 프론트 컨트롤 디자인 패턴은 서버를 내리지 않고 수정이 가능한 방식이다.**
>
> 스프링 내부에서 작동하는 패턴 방식
> 면접: 프론트/프론트 컨트롤/프론트 커맨드 디자인 패턴을 설명해보시오
> 구현: dispatcher 클래스 내부에 Map을 이용해 컨트롤러들을 보관하고
> 키워드를 Map에서 검색해 해당 컨트롤러를 꺼내 path 를 얻어내는 방식

* Web Dynamic Project 생성시 맨 마지막에 XML 생성에 check 한다.

  >XML의 역할: 설정들을 넣을 수 있고 tomcat 에도 그 설정을 적용할 수 있다.

  ```xml
    <session-config>
   		<session-timeout>10</session-timeout>
    </session-config>	
  ```

  > 만약 Web-Content 안에 web.xml 에 위와 같은 태그 설정을 넣는다면?
  >
  > * 톰캣 내부에 설정이 없을 때 session 설정이 적용된다.

  ​          

* 서블릿을 한 개만 만든다.

* Servlet 에 기본적으로 설명되는 Annotation을 지운다.

```java
public class DispatcherServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().println("ok");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		doGet(request, response);
	}

}
```

* 이 서블렛을 실행하면 다음 주소로 이동한다.
  * 아래 경로를 보면 내부적으로 `ft`란 프로젝트 아래 `servlet` 폴더가 사용되었음을 알 수 있다. (com 이후는 패키지)

```java
http://localhost:8080/ft/servlet/com.sofia.front.controller.DispatcherServlet
```

​         

#### 서블릿의 등록

> Annotation을 삭제했으므로 web.xml을 이용해 서블릿을 등록해준다.

* `<servlet>`: 서블릿을 등록하는 태그

  * `<servlet-name>`: 별칭(Alias), 본인 마음대로 설정한다.
  * `<servlet-class>`: 클래스명을 적어준다. 패키지 포함 전체 경로를 적어주어야 한다.

  ```xml
  <servlet>
    <servlet-name>aaaaa</servlet-name>
    <servlet-class>com.sofia.front.controller.DispatcherServlet</servlet-class>
  </servlet>
  ```

* `<servlet-mapping>`

  * `<server-name>`: 매핑할 servlet name을 적어준다. (servlet 태그에서 등록한 이름)
  * `<url-pattern>`: `url` 분류를 해주는 역할

  ```xml
  <servlet-mapping>
  	<servlet-name>aaaaa</servlet-name>
  	<url-pattern>/test</url-pattern>
  	<url-pattern>/sam</url-pattern>
  </servlet-mapping>
  ```

* 실행

  * 등록과 매핑이 완료되었다면 서블릿을 실행한다.

  ```java
  http://localhost:8080/ft/sam
  ```

  ```java
  http://localhost:8080/ft/test
  ```

  * 위의 경로로 잘 적용됨을 확인할 수 있다.

* 모든 주소 경로 설정: `.`을 통해 확장자로 묶어서 표현하면 `login.do`, `logout.do` 등 모든 확장자를 처리할 수 있다.

  ```xml
  <servlet-mapping>
  	<servlet-name>dispatcher</servlet-name>
  	<url-pattern>*.do</url-pattern>
  </servlet-mapping>
  ```

​              

#### 세부주소 가져오기

* 만약 `http://localhost:8080/ft/sam/article/login.do`로 입력한다면 마지막에 접속하고자하는 주소만 가져올 수 있다.
  * `/login.do`를 최종적으로 가져온다.
  * 뒤에 `?age=30`등 파라미터가 들어가도 상관없다.

```java
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      String uri = request.getRequestURI();
      int start = uri.lastIndexOf("/");
      String path = uri.substring(start); //request에 저장된 URI를 가져와 substring으로 잘라냄
      System.out.println("path : "+ path);
	}
```

​          

### HandlerMapping 클래스 생성

* 커맨드 디자인 패턴처럼 `act`의 값에 따라 메서드를 분류해주는 작업을 해야한다.

  * **클래스**를 생성해 작업한다. (Servlet 아님)

* **Controller 인터페이스**를 만들어 관리하고 구현한 class를 HandlerMapping 내부 Map에 넣는다.

  ```java
  public interface Controller {
  	String process(HttpServletRequest request, HttpServletResponse response)
  			throws ServletException, IOException;
  }
  ```

* Controller 를 구현한 클래스

  ```java
  import javax.servlet.http.HttpServletRequest;
  import javax.servlet.http.HttpServletResponse;
  
  public class HelloController implements Controller {
  
  	@Override
  	public String process(HttpServletRequest request, HttpServletResponse response) {
  	String path = "/hello.jsp";
  	String name = request.getParameter("name");
  	//서비스 구현
  	request.setAttribute("msg",name);
  	return path;
  	}
  
  }
  ```

* **HandlerMapping class**를 구현

```java
package com.ssafy.guestbook.controller;

import java.util.HashMap;
import java.util.Map;


public class HandlerMapping {
	static Map<String, Controller> mapping = new HashMap<String, Controller>();
	static {
		mapping.put("/hello.do", new HelloController());
	}
	public static Controller getController(String path) {
     //Map을 이용한 값 기록: 각 컨트롤러는 내부에서 작업 후 주소를 던져준다
		return mapping.get(path);
	}
}

```

​         

* Servlet 내부에서 세부주소 가져오는 방법을 통해 호출

```java
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    
      String uri = request.getRequestURI();
      int start = uri.lastIndexOf("/");
      String path = uri.substring(start); //request에 저장된 URI를 가져와 substring으로 잘라냄
      System.out.println("path : "+ path); // dispatcher가 helloe.do를 뽑아낸다.
    
    Controller controller = HandlerMapping.getController(path);
    if(controller == null){
			//만약 null이면 기본주소 반환
    }
		String returnURL = "/WEB-INF"+ controller.process(request, response);
    //view Resolver: 클라이언트가 URL로 접근하지 못하게 하기 위해 WEB-INF에 hello.jsp를 넣어서 관리
		request.getRequestDispatcher(returnURL).forward(request, response);
	}
```

* `/WEB-INF` 에 문서를 넣어 관리

<img src="design_pattern.assets/image-20220330140004153.png" alt="image-20220330140004153" style="zoom:50%;" />
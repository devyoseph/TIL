## 디자인 패턴

​         

### 커맨드 디자인 패턴

`act`를 hidden으로 숨겨놓고 `form`으로 전송한 다음 `act`의 값에 따라 명령을 분배하는 작업

​         

### 프론트 컨트롤 디자인 패턴

> GET 방식으로 파라미터를 넘겨주          

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


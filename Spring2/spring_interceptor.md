# Listener와 Filter 사용하기

> 면접용: Java 응용 프로그램은 Servlet, Listener, Filter가 있고 Filter를 Interceptor로 대체 가능하다.

​           

## 실습1: Listener 사용하기

* eclipse - Dynamic Web Project로 생성
  * 생성시 xml 파일 생성에 check 표시

​          

### web.xml

* servlet을 수동 생성 후 매핑: `/`를 안붙이면 오류가 발생하므로 주의
* url-pattern을 여러개 등록해서 사용할 수 있음

```xml
  <servlet>
	  <servlet-name>aaa</servlet-name>
	  <servlet-class>com.sofia.hello.AServlet</servlet-class>
  </servlet>
  
  <servlet-mapping>
  	<servlet-name>aaa</servlet-name>
  	<url-pattern>/aaa</url-pattern>
  	<url-pattern>/bbb</url-pattern>
  	<url-pattern>/ccc</url-pattern>
  </servlet-mapping>
```

​           

### Servlet 여러개 생성

* xml 매핑한 Servlet의 내용

```java
package com.sofia.hello;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class AServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		doGet(request, response);
	}

}

```

* 2번째 서블릿 생성: xml 등록하지 않고 `@WebServlet`으로 등록 

```java
package com.sofia.hello;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ddd")
public class BServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ddd").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		doGet(request, response);
	}

}

```

​           

### Listener

> Annotation이 아닌 xml 방식으로 Listener를 사용해본다.
> **request / session / application** Listener가 존재한다.

* Listener를 생성한다.

<img src="spring_interceptor.assets/image-20220420094502760.png" alt="image-20220420094502760" style="zoom:50%;" />

* Life Cycle, attributes에 대한 변화 등을 리스너로 관리할 수 있다.(예제는 Life Cycle만 다룬다.)

```java
package com.ssafy.hello;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

//@WebListener
public class AListener implements HttpSessionListener {

    public AListener() {
    }

    public void sessionCreated(HttpSessionEvent se)  {
    	System.out.println("세션이 생성");
    }

    public void sessionDestroyed(HttpSessionEvent se)  {
    	System.out.println("세션이 소멸");
    }
	
}

```

* xml 파일에 연결

  ```xml
  <listener>
  	<listener-class>com.sofia.hello.AListener</listener-class>
  </listener>
  
  <!-- 세션 종료를 보기 위해 세션 만료 시간을 1분으로 설정-->
  <session-config>
  	<session-timeout>1</session-timeout>
  </session-config>
  ```

​                        

#### \- 리스너 작동

* 서블릿 소스파일에서 우클릭 - Run on Server

<img src="spring_interceptor.assets/image-20220420095508983.png" alt="image-20220420095508983" style="zoom:50%;" />

* 정보가 안뜬다면 세션을 자동 생성하도록 jsp 설정

  ```jsp
  <%@ page language="java" contentType="text/html; charset=UTF-8"
      pageEncoding="UTF-8" session="true"%>
  ```

  <img src="spring_interceptor.assets/image-20220420100419400.png" alt="image-20220420100419400" style="zoom: 33%;" />

​             

​                  

## 실습2: Filter 사용하기

​          

### Filter 생성

<img src="spring_interceptor.assets/image-20220420100935326.png" alt="image-20220420100935326" style="zoom:50%;" />

```java
package com.sofia.hello;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//@WebFilter("/AFilter")
public class AFilter implements Filter {

	public void destroy() {
	}
	
	//자세히보면 인자의 타입이 HttpServletRequest의 부모임을 알 수 있다.
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		System.out.println("AFilter 사전 작업");
    //부모 타입이지만 다른 작업도 가능
		HttpServletRequest req = (HttpServletRequest)request;
		HttpSession session = req.getSession(false);
		//getSession() 메서드를 적용할 때 default로 세션이 생성됨을 주의
		
    //xml 설정에서는 aaa에 매핑된 filter로 등록한다.
    //aaa에 들어가기 전 session이 없다면 hello.jsp로 바로 보내는 기능도 할 수 있다.
		if(session == null) {
			HttpServletResponse res = (HttpServletResponse) response;
			res.sendRedirect("hello.jsp");
			return;
		}
		
		//return; 을 이용해 사전 작업만 가능
		chain.doFilter(request, response);
		System.out.println("AFilter 사후 작업");
	}

	public void init(FilterConfig fConfig) throws ServletException {
	}

}
```

​           

### xml 등록

> servlet 등록 방식과 같다

```xml
<filter>
	<filter-name>afilter</filter-name>
	<filter-class>com.sofia.hello.AFilter</filter-class>
</filter>

<filter-mapping>
	<filter-name>afilter</filter-name>
	<url-pattern>/aaa</url-pattern>
</filter-mapping>
```

​           


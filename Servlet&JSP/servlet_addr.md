### Servlet 접속시 각 주소의 값

```java
public class DispatcherServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String contextPath = request.getContextPath();
		String uri = request.getRequestURI();
		String url = request.getRequestURL().toString();
		String host = request.getRemoteHost();
		int port = request.getRemotePort();
		String queryString = request.getQueryString();
		
		System.out.println("contextPath : " + contextPath);
		System.out.println(" uri : " + uri);
		System.out.println(" url : " + url);
		System.out.println(" host : " + host);
		System.out.println(" port : " + port);
		System.out.println(" queryString : " + queryString);
		response.getWriter().println("ok");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		doGet(request, response);
	}

}
```

```java
contextPath : /ft
 uri : /ft/book/sam/article.do
 url : http://localhost:8080/ft/book/sam/article.do
 host : 0:0:0:0:0:0:0:1
 port : 50557
 queryString : age=30
```

* contextPath: root 의 주소
* uri: ip포트를 뺀 주소, java에서의 uri는 context부터의 주소이다.
* url: 전체주소

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


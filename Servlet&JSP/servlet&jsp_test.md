## Servlet / JSP for Test

> getContextPath? 

​       

### 1. Servlet 을 구현하는 방식 3가지

* Servlet 을 상속해 구현
* GenericServlet을 상속해 구현
* HttpServlet 을 상속해 구현

​         

### 2. Servlet 에서의 Parameter

```
http://www.google.com/good.jsp?parameter1=value1&parameter2=value2
```

​       

### 3. Servletd의 Life Cycle

* Life Cycle은 Container가 관리 WEB(WAS) => Tomcat 

```java
@WebServlet("/lifecycle")
public class LifeCycle extends HttpServlet {
	@Override
	public void init() throws ServletException {
		System.out.println("init() method call!!!!");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doGet method call!!!! ");
	}

	@Override
	public void destroy() {
		System.out.println("destroy() method call!!!!");
	} 
}
```


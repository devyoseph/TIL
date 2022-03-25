# JSTL

> JSP Standard Tag Library(자바서버 페이지 표준 태그 라이브러리)
>
> Java EE 기반의 웹 애플리케이션 개발 플랫폼을 위한 컴포넌트 모음이다.
> JSTL은 XML 데이터 처리와 조건문, 반복문, 국제화와 지역화와 같은 일을
> 처리하기 위한 JSP 태그 라이브러리를 추가해 JSP 사양을 확장했다.
>
> JSTL은 JSP 페이지 내에서 자바 코드를 바로 사용하지 않고 로직을 내장하는 효율적인 방법을 제공한다.
> 표준화된 태그 셋을 사용하여 자바 코드가 들락거리는 것보다 더 코드의 유지보수와 **응용 소프트웨어 코드**와 **사용자 인터페이스** 간의 **관심사의 분리**로 이어지게 한다.

​      

## JSTL

* custom tag: 개발자가 직접 태그를 작성할 수 있는 기능을 제공
  * custom tag 중에서 많이 사용되는 것들을 모아 JSTL 규약을 만듦
* 논리적인 판단, 반복문의 처리, 데이터베이스 등의 처리를 할 수 있다.
* EL 코드와 함께 간결하게 처리할 수 있다.

​         

### JSTL Tag

* directive 선언 형식

  ```jsp
  <%@ taglib prefix="prefix" uri="uri" %>
  ```

| library  | prefix | function                             | URI                                    |
| -------- | ------ | ------------------------------------ | -------------------------------------- |
| core     | c      | 변수 지원, 흐름제어, URL 처리        | http://java.sun.com/jsp/jstl/core      |
| XML      | x      | XML 코어, 흐름제어, XML 변환         | http://java.sun.com/jsp/jstl/xml       |
| 국제화   | fmt    | 지역, 메시지 형식, 숫자 및 날짜 형식 | http://java.sun.com/jsp/jstl/fmt       |
| database | sql    | SQL                                  | http://java.sun.com/jsp/jstl/sql       |
| 함수     |        | Collection, String 처리              | http://java.sun.com/jsp/jstl/functions |

* core가 제일 중요: https://mvnrepository.com/ 안되면 이쪽으로 가서 `jstl` 검색 

  * https://mvnrepository.com/artifact/javax.servlet.jsp.jstl/jstl-api

  * 여러 방식이 있지만 `.jar`로 받고 임포트

    <img src="jstl_basic.assets/image-20220325125738851.png" alt="image-20220325125738851" style="zoom:50%;" />

  * Import 하기: 입력마다 자동완성시 알아서 주소를 검색 가능

  ```jsp
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
  ```

  * prefix 값으로 자기만의 커스텀을 할 수 있지만 관례적으로 `c`를 사용

​        

​         

## JSTL - core tag

* XML 형식을 따르기 때문에 무조건 태그를 닫아준다.

```jsp
<c:set></c:set>
```

* 하지만 바로 닫기로 여는 태그만 사용할 수 있다.

```jsp
<c:set />
```

* 예시: `setAttribute`를 scope까지 설정해서 정의할 수 있다.

```jsp
<c:set var="name" value="sofia" scope="session"/>
출력하기 ${name}
```

| function | tag                         | description                                                  |
| -------- | --------------------------- | ------------------------------------------------------------ |
| 변수지원 | **set***                    | jsp page에서 사용할 변수 설정                                |
|          | **remove***                 | 설정한 변수 제거                                             |
|          | **if***                     | 조건에 따른 코드 실행                                        |
| 흐름제어 | **choose, when, oherwise*** | 다중 조건을 처리할 때 사용 (if~else if~else)                 |
|          | **forEach***                | array나 collection의 각 항목을 처리할 때 사용                |
|          | forTokens                   | 구분자로 분리된 각각의 토큰을 처리할 때 사용 (StringTokenizer) |
| URL처리  | import                      | URL을 사용하여 다른 자원의 결과를 삽입                       |
|          | redirect                    | 지정한 경로로 redirect                                       |
|          | url                         | URL 작성                                                     |
| 기타태그 | catch                       | Exception 처리에 사용                                        |
|          | out                         | JspWriter에 내용을 처리한 후 출력                            |

​      

#### - `<c:set />`

* **scope**의 속성 값은 선택이다

```jsp
<c:set value="value" var="varName" scope="page/request/session/application" />
```

* **property**의 값 또한 선택이다.

```jsp
<c:set target="target" property="propertyName">
```

* **EL문법**과 혼용해서 사용할 수 있다.

```jsp
<c:set value="${param.age}" var="varName" scope="page/request/session/application" />
```

​                 

#### - `<c:catch />`

* 기본적으로 JSP 페이지는 예외가 발생하면 지정된 오류페이지를 통해 처리한다.
* `<c:catch>` 액션은 JSP 페이지에서 예외가 발생할 만한 코드를 오류페이지로 넘기지 않고 직접 처리할 때 사용
* var 속성에는 발생한 예외를 담을 page 생존범위 변수를 지정
* `<c:catch>`와 `<c:if>` 액션을 함께 사용하여 java 코드의 try~catch 와 같은 기능을 구현할 수 있다.

​         

* try-catch 구문

```java
try {
	String str = null;
	out.println("Length of String :  " + str.length());
} catch(Throwable ex){
	out.print(ex.getMessage());
}
```

* `<c:catch>`와 `<c:if>` 사용하기

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

<c:catch var="ex">
<%
  String str = null;
  out.println("Length of String :  " + str.length()); //예외 발생
%>  
</c:catch>

<c:if test="${ex != null}">
	예외가 발생했습니다. ${ex.message}
</c:if>
```

​             

### 조건문

* `<c:if/choose/when/otherwise>`

* **`<c:if/>`**

  * test 속성에 지정된 표현식을 평가하여 결과가 true인 경우 액션의 Body 컨텐츠를 수행 

    ```jsp
    <c:if test="${userType eq 'admin'}">
    	<jsp:include page="admin.jsp" />
    </c:if>
    ```

  * var 속성은 표현식의 평가 결과인 Boolean 값을 담을 변수를 나타내며 변수의 생존범위는 scope 속성으로 설정

    ```jsp
    <c:if test="${userType eq 'admin'}" var="accessible">
    	<jsp:inclue page="admin.jsp" />
    </c:if>
    ```

* **`<c:choose />`**, **`<c:when />`**, **`<c:otherwise />`**

  * if, else if, else와 같이 처리할 수 있다.
  * 이를 사용하는 이유는 if 설정에 else if 기능이 없기 때문이다.

  ```jsp
  <c:choose>
  
    <c:when test="${userType} == 'admin'}">
      관리자 화면
    </c:when>
  
    <c:when test="${userType} == 'member'}">
      회원 화면
    </c:when>
  
    <c:otherwise>
      일반 사용자 화면
    </c:otherwise>
  
  
  </c:choose>
  ```

​         

​           

### 반복문 : `<c:forEach>`

* 컬렉션에 있는 항목들에 대하여 액션의 Body 컨텐츠를 반복해 수행
* 컬렉션에는 Array, Collection, Map 또는 콤마로 분리된 문자열이 올 수 있다.
* var 속성에는 반복에 대한 현재 항목을 담는 변수를 지정하고 **items 속성**은 반복할 항목들을 갖는 컬렉션을 지정
* varStatus 속성에 지정한 변수를 통해 현재 반복의 상태를 알 수 있다.

#### Servlet 코드

```java
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Member> list = new ArrayList<Member>();
		
		list.add(new Member("홍길동1",30));
		list.add(new Member("홍길동2",20));
		list.add(new Member("홍길동3",50));
		list.add(new Member("홍길동4",70));
		list.add(new Member("홍길동5",90));
		
		request.setAttribute("list", list);
		request.getRequestDispatcher("/list.jsp").forward(request, response);
	}
```

​         

#### JSP 코드

* var 속성: forEach 구문에서 각 원소를 지칭할 이름을 정해준다
* items: 가져올 리스트 등을 불러온다.
* varStatus: 반복문이 돌아가는 동안 인덱스 번호 등을 사용할 수 있다.

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
목록<br>
<table>
	<thead>
		<tr>
			<th>번호</th>
			<th>이름</th>
			<th>나이</th>
		</tr>
	</thead>
	
	<tbody>
	<c:forEach var="mem" items="${list}" varStatus="status">
		<tr>
			<td>${status.count}</td>
			<td>${mem.name}</td>
			<td>${mem.age}</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
</body>
</html>
```



​	
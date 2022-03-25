## EL

> Expression Language

### EL 문법

* Map 사용시

  ```jsp
  ${ Map . Map의 키 }
  ```

* Java Bean 사용

  ```jsp
  ${ Java Bean . Bean 프로퍼티 }
  ```

  ​          

#### - 스크립트릿(Scriptlet) 변환 예시

```jsp
<%= (com.google.model.MemberDto)
request.getAttribute("userinfo").getZipDto.getAdderss() %>
```

* Expression Language

```jsp
${userindo.zipDto.address}
```

​          

### [ ] 연산자

* EL에는 Dot 표기법 외에 [ ] 연산자를 사용하여 객체의 값에 접근할 수 있다.
* `[ ]`연산자 안의 값이 문자열인 경우 이것은 맵 키가 될 수 있고, Bean 프로퍼티나 리스트 및 배열의 인덱스가 될 수 있다.
* 배열과 리스트인 경우, 문자로 된 인덱스 값은 숫자로 변경하여 처리합니다.

​             

* `[ ]` 연산자를 이용한 객체 프로퍼티 접근

  ```jsp
  ${userinfo["name"]}
  ```

* `Dot` 표기법을 이용한 객체 프로퍼티 접근

  ```jsp
  ${userinfo.name}
  ```

* 리스트나 배열 요소에 접근

  ```java
  //Servlet
  String[] names = {"홍길동", "이순신"};
  request.setAttribute("userNames",names);
  
  //JSP
  ${userNames[0]}
  ${userNames["1"]}
  ```

​        

​      

## EL 내장객체

* `pageContext`를 제외한 모든 EL의 내장 객체는 Map이다
  * 즉, key와 value값을 저장하고 있다.

| category        | identifier       | Type      | description                                                  |
| --------------- | ---------------- | --------- | ------------------------------------------------------------ |
| JSP             | pageContext      | Java Bean | 현재 페이지의 프로세싱과 상응하는 PageContext instance       |
| Scope           | pageScope        | Map       | page scope에 저장된 객체 추출                                |
| Scope           | requestScope     | Map       | request scope에 저장된 객체 추출                             |
| Scope           | sessionScope     | Map       | session scope에 저장된 객체 추출                             |
| Scope           | applicationScope | Map       | application scope에 저장된 객체 추출                         |
| 요청 매개변수   | param            | Map       | `ServletRequest.getParameter(String)`을 통한 정보추출        |
| 요청 매개변수   | paramValues      | Map       | `ServletRequest.getParameterValues(String)`을 통한 정보추출  |
| 요청 헤더       | header           | Map       | `HttpServletRequest.getHeader(String)`을 통한 정보추출       |
| 요청 헤더       | headerValues()   | Map       | `HttpServletRequest.getHeaders(String)`을 통한 정보추출      |
| 쿠키            | cookie           | Map       | `HttpServletRequest.getCookies()`을 통한 정보추출            |
| 초기화 매개변수 | initParam        | Map       | `ServletContext.getInitParameter(String)`를 통해 초기화 파라미터를 추출 |

​        

* EL에서 객체 접근

  ```java
  request.setAttribute("userinfo", "홍길동");
   1. ${requestScope.userinfo}
   2. ${pageContext.request.userinfo}, ${userinfo}
  
  url?name="홍길동"&fruit=사과&fruit=바나나
   1. ${param.name}
   2. ${paramValues.fruit[0]}, ${paramValues.fruit[1]}
  ```

* 객체 접근 주의

  > `.`이 붙은 경우 잘못 검색할 수 있다.

  ```java
  // Servlet
  request.setAttribute("sofia.user", memberDto);
  
  // Case #1 : 에러
  ${sofia.user.name} // sofia라는 속성은 존재하지 않음
  
  // Case #2 : request 내장객체에서 [ ]연산자를 통해 속성 접근
  ${requestScope["sofia.user"].name}
  ```

* EL에서 쿠키 접근

  ```java
  ${cookie.id.value}
  ```

  1. Cookie가 null이라면 null return
  2. null이 아니라면 id 검사 후 null이라면 null return
  3. null이 아니라면 value 값 검사
     * EL은 값이 null이라도 null을 출력하지 않는다. (공백)

  * 스크립틀릿을 통한 쿠키 출력

  ```java
  Cookie[] cookies = request.getCookies();
  for(Cookie cookie : cookies){
  	if(cookie.getName().equals("userId")){
  		out.println(cookie.getValue());
  	}
  }
  ```

  * EL 내장객체를 통한 쿠키 값 출력

  ```java
  ${cookie.userId.value}
  ```

* EL에서 객체 method 호출

  ```jsp
  <%
  List<MemberDto> list = dao.getMembers();
  request.setAttribute("users", list);
  %>
  ```

  * 회원 수: `${requestScope.users.size()}`, `${users.size()}`
  * 주의: `${user.size}` == `<%= request.getAttribute("users").getSize() %>`
    * 그냥 `.size`를 입력하면 `getSize`가 되므로 **주의**한다.



​                  

### EL Operator(연산자)

* 대부분 java와 동일

| 종류       | description          |
| ---------- | -------------------- |
| 산술       | +,-,*,/,%            |
| 관계형     | ==, !=, <, >, <=, >= |
| 3항 연산   | 조건 ? 값1 : 값2     |
| 논리       | &&, \|\|, !          |
| 타당성검사 | empty                |

* **empty 연산자에서 true를 return하는 경우** >> `${empty var}`

  1. 값이 nulld이면 true
  2. 값이 빈 문자열("")이면 true
  3. 길이가 0인 배열([])이면 true
  4. 빈 Map 객체는 true
  5. 빈 Collection 객체이면 true

* ```jsp
  ${empty cookie.id.value}
  ${empty session.loginUser}
  ```

  * null 검사 등으로 이용한다.
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

  
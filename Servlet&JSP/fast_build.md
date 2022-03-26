>jsp -> controller -> service -> dao(dto사용) -> service -> controller -> jsp
>
>어떤 곳에서 인스턴스를 만들고 주며 생성자를 private로 막는지 외운다 그냥
>
>jsp 문서내에서는 ${root } 경로가 생활화
>
>servlet 내부에서는 그냥 webcontent 내부에서 이동

1. inc 폴더 만들고 header와 footer.jsp 생성

2. 모든 문서에 jstl import

   * jstl/core의 종류가 두가지 있는데 jsp가 들어간 더 긴 core를 import하지 않으면 오류가 발생한다. 

   ```jsp
   <%@ taglib prefix="c" uri="http://java.sum.com/jsp/jstl/core"
   ```

3. header 에 root 값 설정

```jsp
<c:set var="root" value="${pageContext.request.contextPath}"
```

4. 제출에서 form-action과 input-hidden-name="act"의 값을 둘다 만드는 것을 늘 주의한다.

```jsp
<form action="${root}/user" method="post">
	<input type="hidden" name="act" value="login">
```

5. servlet에서 post >> get 방식으로 넘길 때 uff-8을 명심한다.

```java
request.setCharacterEncoding("UTF-8")
```

​         

### 페이지 이동

* servlet에서

  ```
  path
  ```

* 파라미터 받아주기

  * form 내부 값들을 받아주기 위해서

  ```java
  request.getParameter("파라미터명");
  ```

  

### 서비스 만들기

* UserService, MemberService 등 인터페이스로 먼저 구현해야한다.

* 반환 타입을 결정해야한다.

* 인터페이스를 구현한 Impl 클래스를 만드는데 Add를 통해 추가한다.

* static으로 instance를 만들고 호출할 수 있는 메서드를 getInstance로 만들어준다.

* **service 안에다 dao의 인스턴스를 가져와야만한다.**

  ```java
  private Userdao dao = new UserdaoImpl.getInstance();
  ```

  

​       

### dto 만들기

* 서비스를 만들면 그 서비스를 제공하기 위해 정보를 담는 객체를 만들어주어야 한다.



### 로그인 페이지

* 로그인하고 새로고침해도 주소가 남아있도록 하기 위해서는 forward를 사용해야한다.
* 하지만 단순 이동이라면 redirect를 사용한다.
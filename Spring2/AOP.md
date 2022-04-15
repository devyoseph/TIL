# AOP

> 관점 지향 프로그래밍(Aspect of Programming) 
>
> DI 개념으로 생각할 수도 있다. 메서드를 강제 주입할 수 있다.       
>
> 핵심관리기능: 게시글 등록, 수정, 삭제 등등
>
> 공통관심기능: 로그처리, 트랜잭션, 인증 등 
>
> 프록시 서버를 두는 이유는 AOP가 주된 이유이다: 메서드 실행 전에 해당 메서드를 실행하고 그 후에 메서드를 실행할 수 있도록 하는 것이다.

## AOP 개념

* OOP를 더 OOP 답게...

* 관심의 분리(Separation of Concerns)

  * 문제 영역을 독립적인 모듈로 분해
  * 핵심 관심(Core Concerns)
    * 객체지향 분석/설계 과정을 통해 쉽게 모듈화/추상화가 가능함.
  * 횡단관심(CrossCutting Concerns)
    * 객체지향의 기본 원칙을 지키면서 이를 분리해 모듈화하는 것은 매우 어려움
    * 횡단관심 모듈들은 여러개의 또는 많은 핵심 관심 모듈들과 긴밀하게 결합
    * 따라서 기존 OOP 개념으로는 뾰족한 답이 없다

  ​      

## OOP의 문제점

* 횡단 관심: 예) 로깅, 인증, 리소스 풀링, 에러 검사 등
* 이러한 관심은 핵심 관심과 다른 형태로 존재한다.
* 아래와 같은 방식은 핵심관심 모듈에 객체 생성, 메서드 호출 코드가 모두 포함되어야 함
* **한계점 정리**
  * 중복되는 코드
  * 지저분한 코드: 가독성 저하, 실수나 버그 유발, 유지보수에 어려움 가증
  * 생산성 저하: 핵심관심과 횡단 관심을 함께 구현해야 하므로 개발의 집중력을 떨어뜨리고 결과적으로 생산성 저하 초래
  * 재활용성 저하
  * 변경의 어려움
    * 새로운 요구사항이 많은 부분에 영향을 미치는 경우 적용이 힘들어짐
    * 새로운 관심영역의 등장시에 적용을 어렵게 함
    * 틀의 도움없이 리팩토링도 어려움

​         

### EJB에서의 AOP

* 현재의 AOP 이전의 방식
* 두가지 방법
  * EJB와 같은 컨테이너 또는 서버를 이용한 방법
    * 횡단관심 기능을 컨테이너 상에서 작동하는 EJB 모듈에 적용
    * 일종의 엔터프라이즈 서비스
    * POJO 지원하지 않음
  * Dynamic Proxy를 이용한 인터셉터 체인 방식
    * JDK 1.3부터 지원
    * 컨테이너 개발자들을 통해 많이 사용된 방식
    * 복잡한 프레임워크 또는 컨테이너의 도움이 필요

​          

### Aspect J

* Java VM과 호환되는 최초의 AOP
* AspectJ과 별도의 컴파일러나 위빙에 의존하지 않고 Spring에 적용됨
  * **위빙(Weaving)**: CrossCutting이라고도 함. AOP가 핵심 관심 모듈의 코드를 직접 건드리지 않고 필요한 기능이 작동하도록 함
  * 조인포인트(Joinpoint)
    * 횡단 관심 모듈인 Advice가 삽입되어 동작할 수 있는 실행가능한 위치로서 포인트컷(Pointcut)후보 위치
    * 메서드 호출 시점, 메서드가 리턴되는 시점 등이 조인포인트가 될 수 있음
  * 포인트컷(Pointcut)
    * 어떤 클래스의 어느 조인포인트를 사용할 것인지 결정하는 선택기능
    * AOP가 항상 모든 모듈의 모든 조인포인트를 사용하는 것이 아니기에 필요에 따라 사용해야할 특정 조인포인트를 지정할 필요가 있음
  * 어드바이스(Advice)
    * 각 조인포인트에 삽입되어 동작할 수 있는 코드
    * 주로 메서드 단위로 구성됨
    * 포인트컷에 의해 결정된 모듈의 조인포인트에서 호출되어 사용됨
    * 동작 시점은 AOP 기술마다 조금씩 다름
      * before, after, after-returning(return 성공적으로 완료 후), after-throwing(예외발생), around(실행자체를 가로챔)
  * Target: 공통기능이 적용될 대상 클래스 객체
  * Aspect: 여러 클래스나 기능에 사용되는 관심사를 모듈화함(포인트컷과 어드바이스를 합쳐놓은 것) 예) 트랜잭션 관리 기능

​               

## Advice 종류

| 이름            | 설명                                                         |
| --------------- | ------------------------------------------------------------ |
| @Before         | 미리 정의한 Pointcout 진입 전에 수행                         |
| @AfterReturning | 미리 정의한 Pointcut에서 return이 발생한 후에 수행           |
| @AfterThrowing  | 미리 정의한 Pointcut에서 예외가 발생할 경우 수행             |
| @After          | 미리 정의한 Pointcut에서 예외 발생 여부와 상관없이 무조건 수행 |
| @Around         | 미리 정의한 Pointcut의 전, 후에 필요한 동작을 수행           |

​           

### AOP 설정을 위한 Annotation

| Annotation | 설명                           |
| ---------- | ------------------------------ |
| @Aspect    | Aspect를 정의할 때 사용한다.   |
| @Pointcut  | Pointcut을 정의할 때 사용한다. |

​             

### 명시자: execution

* execution(AspectJ 표현식)

  * execution(접근 제한자, 리턴타입, **이름패턴**)
    * 접근제한자와 리턴타입은 생략 가능

* AspectJ 표현식

  | 와일드카드 | 연산자                                                       |
  | ---------- | ------------------------------------------------------------ |
  | *          | 1개의 모든 값을 표현<br />매개변수 사용(1개 파라미터)<br />패키지 사용(1개의 패키지) |
  | ..         | 0개 이상의 값을 표현<br />하위의 모든 패키지                 |
  | +          | 주어진 타입의 자식 클래스나 인터페이스 표현                  |

* AspectJ 표현 적용 예시

  | 사용                                              | 설명                                            |
  | ------------------------------------------------- | ----------------------------------------------- |
  | execution(public * *(..))                         | public 메서드 선택                              |
  | execution(* set*(..))                             | 이름이 set으로 시작하는 모든 메서드             |
  | execution(* get*(..))                             | 이름이 get으로 시작하는 모든 메서드             |
  | execution(* main(..))                             | 이름이 main인 메서드                            |
  | execution(* com.sofia..(..))                      | com.sofia 패키지에 있는 클래스의 모든 메서드    |
  | execution(* com.sofia.prj.model.UserService(..))  | UserService의 모든 메서드                       |
  | execution(* com.sofia.prj.model.UserService+(..)) | UserService를 상속받은 모든 클래스              |
  | execution(* com.sofia.prj.model.service..(..))    | Service 패키지와 하위 패키지의 모든 메서드 실행 |

​         

### API 클래스

| 사용                 | 주요 메서드                                                  |
| -------------------- | ------------------------------------------------------------ |
| JoinPoint            | Object getTarget()<br />핵심기능 클래스 객체<br />Signature getSignature()<br />핵심 기능 클래스의 메서드 |
| ProceedingJointPoint | Signature getSignature()<br />핵심기능 클래스의 메서드<br />proceed()<br />핵심기능 클래스의 메서드 실행 |

​                 

​                    

## 실습 예제

​         

### xml 형식

* AOP를 xml 형식으로 사용하기 전에 maven 형식으로 라이브러리를 추가해주어야 한다.

  ```xml
  <!-- pom.xml -->
  <dependency>
      <groupId>org.aspectj</groupId>
      <artifactId>aspectjweaver</artifactId>
      <version>1.9.5</version>
  </dependency>
  
  
  <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-aop</artifactId>
      <version>5.3.18</version>
  </dependency>
  ```

​        

* AOP를 적용할 클래스를 만든다. 
  * bean으로 연결해주기 때문에 어떤 작업도 필요없이 만들면 된다.

```java
package com.sofia.model.aop;


//횡단 클래스(부가적인 기능을 가지고 있는 클래스)
public class AOPAspect {
	
	public void printA() {
		System.out.println("부가기능 호출");
	}
}
```

​           

* application.xml 로 가서 bean을 추가하고 AOP 또한 설정해준다.
  * config/pointcut/aspect/before/**method**

```xml
	<bean id="logAdvice" class="com.sofia.model.aop.AOPAspect"></bean> <!--class를 등록-->
	<aop:config>
		<aop:pointcut expression="execution(* com.sofia.model.service.GuestBookServiceImpl.writeArticle(..))" id="pt1"/> 
		<aop:aspect id="log1" ref="logAdvice"> 
			<aop:before pointcut-ref="pt1" method="printA"/>
		</aop:aspect>
	</aop:config>
```

* JointPoint의 .getSigniture() 메서드를 통해 어떤 메서드에 적용되었는지 가져올 수 있다.

```java
package com.sofia.model.aop;

import org.aspectj.lang.JoinPoint;

//횡단 클래스(부가적인 기능을 가지고 있는 클래스)
public class AOPAspect {
	
	public void printA(JoinPoint jpoint) {
		System.out.println("부가기능 호출" + point.getSignature().getName());
	}
}
```

​           

* 인자값으로 **JoinPoint가 먼저**왔다는 가정하에 반환값을 검색할 수도 있다.

```java
package com.sofia.model.aop;

import org.aspectj.lang.JoinPoint;

//횡단 클래스(부가적인 기능을 가지고 있는 클래스)
public class AOPAspect {
	// 메서드 리턴값이 존재해야하는 등 제약이 존재한다.
	public void printA(JoinPoint jpoint, Object returnValue) {
		System.out.println("부가기능 호출" + jpoint.getSignature().getName());
		System.out.println("반환값: "+returnValue);
	}
}
```

​           

* around 사용: around는 Jointpoint를 인자로 사용할 수 없다.

```xml
<aop:aspect id="log1" ref="logAdvice">
			<aop:around pointcut-ref="pt1" method="printA"/>
</aop:aspect>
```

* void를 사용할 수 없다: 반드시 return 값을 설정해주어야 한다.

```java
package com.sofia.model.aop;

import org.aspectj.lang.ProceedingJoinPoint;

//횡단 클래스(부가적인 기능을 가지고 있는 클래스)
public class AOPAspect {
	
  //return값이 Object: void면 안된다!
	public Object printA(ProceedingJoinPoint jpoint) throws Throwable {
		//사전 작업
		System.out.println("사전작업");
		Object obj = jpoint.proceed();
		//사후 작업
		System.out.println("사후작업");
		
		
		return obj;
	}
}
```

​                                 

​               

### annotation 형식

* pom.xml에 dependencies 를 추가하고 application.xml에 aop추가

  ```xml
  <aop:aspectj-autoproxy />
  ```

  ​        

* AOP 클래스에 적용하기

  ```java
  package com.sofia.model.aop;
  
  import org.aspectj.lang.ProceedingJoinPoint;
  import org.aspectj.lang.annotation.Around;
  import org.aspectj.lang.annotation.Aspect;
  import org.aspectj.lang.annotation.Pointcut;
  import org.springframework.stereotype.Component;
  
  @Component
  @Aspect
  public class AOPAspect {
  	
  	@Pointcut("execution(* com.sofia.model.service.GuestBookServiceImpl.*Article(..))")
  	public void pt1() {}
  	
  	@Around("pt1()")
  	public Object printA(ProceedingJoinPoint jpoint) throws Throwable {
  		//사전 작업
  		System.out.println("사전작업");
  		Object obj = jpoint.proceed();
  		//사후 작업
  		System.out.println("사후작업");
  		
  		return obj;
  	}
  }
  ```

​          

* AOP는 프록시 서버를 사용하며 **인터페이스를 구현했다**라는 전제를 두고 있다.

  ```java
  GuestBookService guestBookService = context.getBean("gbService", GuestBookServiceImpl.class);
  ```

  * 그래서 위와 같이 구현체 Impl 클래스로 가져오면 에러가 발생한다.

​                

* **해결 방법 2가지**(프록시 서버 관련 오류 해결)

  * 애초에 Impl을 사용하지 않고 Interface 형으로 호출

    ```java
    GuestBookService guestBookService = context.getBean("gbService", GuestBookService.class);
    ```

  * **application aop 설정**

    ```xml
    <aop:aspectj-autoproxy proxy-target-class="true"/>
    ```

    
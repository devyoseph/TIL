# Filter, Interceptor, AOP 의 차이점

>세션체크, 페이지 인코딩 변환, 트래킹, 인증 등 공통적으로 처리해야할 업무들이 존재한다.
>이 기능을 위 3개로 수행할 수 있다.

​            

## 차이점

<img src="https://t1.daumcdn.net/cfile/tistory/9983FB455BB4E5D30C" alt="img" style="zoom:67%;" />

* Filter / Interceptor : Servlet 단위에서 실행된다.
* AOP: 메서드 앞에서 proxy 서버를 만들어 적용한다.
* 실행 순서: Filter → Interceptor → AOP → Interceptor → Filter
  * Filter: xml 등록, DispatcherServlet 이전에 실행(요청내용 변경, 체크 수행)
  * Interceptor: xml 등록, Dispatcher 이후 Controller 작동 전 후로 실행(Controller 요청 내용에 관여, Spring 객체 접근 가능)
  * AOP: OOP를 보완하기 위한 개념, 모든 메서드에 적용 가능(트랜잭션, 로깅, 에러 처리 등), 비즈니스단 메서드의 세밀한 조정
* 매핑 방식 / 활용
  * Filter, Interceptor: 주소로 대상을 구분해야한다.
    * HttpServletRequest, HttpServletResponse 등 활용
  * AOP: 주소, 파라미터, 어노테이션 등 다양한 방식으로 지정 가능
    * JoinPoint, ProceedingJoinPoint 활용
    * PointCut에 적용할 수 있는 종류가 다양하다.(before, after, after-throwing 등)

​                 

### 표 정리

|                            | Filter                                                       | Interceptor                                                  | AOP                                                          |
| -------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 관여                       | Servlet 전                                                   | Servlet 후                                                   | 모든 메서드에 **proxy 패턴**의 형태                          |
| 주소 등록                  | xml, Annotation                                              | xml                                                          | xml, Annotation, 파라미터, 자식관계 등                       |
| 활용 객체                  | Servlet Request/Response                                     | HttpServlet Request/Response                                 | JoinPoint, ProceedingJoinPoint                               |
| 스프링 자원 사용 가능 여부 | X                                                            | O                                                            | O                                                            |
| 실제 사용                  | 인코딩 변환, XSS 방어 등 요청                                | 로그인 체크, 권한 체크, 프로그램 실행시간                    | 로깅, 트랜잭션, 에러 처리 등 비즈니스단 메소드 조정          |
| 메서드                     | **init():** 필터 인스턴스 초기화<br />**doFilter():** 전/후 처리<br />**destroy():** 필터 인스턴스 종료 | **preHandler():** 컨트롤러 메소드가 실행되기 전<br />**postHanler():** 컨트롤러 메소드 실행직 후 view 페이지 렌더링 되기 전<br />**afterCompletion():** view 페이지가 렌더링 되고 난 후 | **@Before:** 대상 메소드의 수행 전<br />**@After:** 대상 메소드의 수행 후<br />**@After-returning:** 대상 메소드의 정상적인 수행 후<br />**@After-throwing:** 예외발생 후<br />**@Around:** 대상 메소드의 수행 전, 후 |


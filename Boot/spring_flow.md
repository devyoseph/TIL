# 필수 요약

​                     

### 1. 스프링의 삼각형

1. POJO: Plain(인터페이스 상속X) Old(Java class) Java

   1. 특정 환경이나 기술에 종속X

   2. 객체 지향 원리 충실, 설계를 자유롭게 적용 가능

   3. 테스트 용이

2. PSA(Portable Service Abstraction)
   1. 환경과 세부기술 변경과 관계업이 일관된 방식으로 기술 접근하게 하는 설계 원칙
   2. 트랜잭션 추상화. OPX 추상화, 데이터 액세스의 Exception 변환 기능 등 기술 구현부와 기술 사용부를 분리
      * ex) 데이터베이스 관계없이 트랜잭션 처리 등 가능

3. IoC/DI (Inversion of Control - 제어의 반전, Dependency Injection - 의존성 주입)

   > Bean(빈)
   >
   > * 스프링이 IoC 방식으로 관리하는 오브젝트
   > * 스프링이 직접 그 생성과 제어를 담당하는 오브젝트
   >
   > BeanFactory
   >
   > * 스프링이 IoC를 담당하는 핵심 컨테이너
   > * Bean을 등록, 생성, 조회, 반환하는 기능
   > * 일반적으로 BeanFactory를 사용하지 않고 이를 확장한 ApplicationContext 사용
   > * BeanFactory vs ApplicationContext
   >   * 빈의 생성과 제어의 관점 vs 스프링이 제공하는 어플리케이션 지원 기능을 모두 포함

   * IoC는 Servlet, EJB에 대한 제어권을 가짐, 객체에 대한 생명주기 관리 기능(Container)

     1. Dependency Lookup: JNDI Lookup

        * lookup context를 통해 필요한 Resource나 Object를 얻는다
        * Lookup 한 Object를 필요한 타입으로 Casting

        ```java
        ApplicationContext context = new ClassPathXmlApplicationContext("com/site/configuration/applicationContext.xml");
        		
        		GuestBookService guestBookService = context.getBean("gbService", GuestBookService.class); //가져올 때 Casting 타입 명시(Dependency Lookup), getBean()메서드 사용
        ```

     2. Dependency Injection: Setter / Constuctor / Method

        * DI는 유연하게 확장 가능한 객체를 만들어 두고 객체 간 의존관계는 외부에서 다이나믹하게 설정

        * Loose coupling(느슨한 연결): 객체 간의 관계를 느슨하게 연결

          * Assembler가 실행시점(Runtime)에 클래스 간의 관계를 형성해줌

            ```xml
            <bean id="lgDao" class="com.site.model.dao.LoginDaoImpl">
            		<property name="dataSource" ref="ds"></property>
            	</bean>
            	
            	<bean id="lgService" class="com.site.model.service.LoginServiceImpl">
            		<property name="loginDao" ref="lgDao"></property>
            	</bean>
            ```

        * 강한 결합: 클래스 직접 호출 방식, 인터페이스로 구현해서 결합도를 떨어뜨린다.

          ```java
          //강한 결합: 인터페이스를 이용해 결합도를 떨어뜨린다.
          private CommonService memberService = new MemberServiceImpl();
          private CommonService adminService = new AdminServiceImpl();
          //CommonService로 사용한 모습
          ```

          ```java
          //강한 결합의 대표적인 예: 팩토리 호출 방식
          private static final Logger logger = LoggerFactory.getLogger(GuestBookController.class);
          ```

   * Container

     * 객체의 생성(init), 사용(service), 소멸(destroy)에 해당하는 라이프 사이클 담당

     * 컨테이너가 코드 대신 오브젝트에 대한 제어권을 가지고 있으므로 IoC라고 부른다.(=Spring Container)

       * Ex) BeanFactory, ApplicationContext

         

         

4. AOP(Aspect Oriented Programming)
   * 관심사의 분리를 통해 소프트웨어 모듈성 향상
     * 공통 모듈을 여러 코드에 적용: 트랜잭션, 보안, 로깅

​             

### 2. Bean

> 빈은 생성될 때 기본적으로 싱글톤으로 만들어진다.
> scope를 통해 컨테이너가 매번 새로운 인스턴스를 반환하도록 할 수 있다(prototype).

1. Annotation ver.

```java
@Component("memberService")
@Scope("singleton")
```

2. xml ver.

```xml
<bean id="memberService" class="com.test.service.MemberServiceImpl" scope="singleton">
```

​               

#### 스프링 빈 설정 방식 3가지

* XML 방식

  ```xml
  <bean id="Dao" class="com.site.model.dao" />
  
  <bean id="Service" class="com.site.model.service.ServiceImpl" scope="singleton">
  	<property name="dao" ref="Dao"/>
  </bean>
  ```

* Annotation 방식: xml 파일에 `<bean>`코드가 사라진 대신 component 스캔을 해주어서 인식시켜주어야 한다.

  ```xml
  <context:component-scan base-package="com.site.model"/>
  ```

  * 빈에 인스턴스로 생성해주었지만 메인으로 실행할 java 파일에서  ApplicationContext로 설정파일을 불러와야한다.

    ```java
    ApplicationContext context = new ClassPathXmlApplicationContext("com/site/configuration/applicationContext.xml");
    		GuestBookService guestBookService = context.getBean("myService", Service.class);
    ```

    ```java
    @Service("myService")
    // 위처럼 이름으로 구분해서 불러오기 때문에 bean으로 주입할 때 이름을 명시해줘서 다른 java파일에서 읽을 수 있도록 만든다.
    public class ServiceImpl implements Service {
    	@Autowired
      private Dao dao;
    }
    ```

  

* Java Code 방식

  > main java 파일에서 xml을 가져오는 것이 아니라 java 파일을 가져온다.
  > java의 package 경로로 미리 import하므로 클래스 이름만 써도 된다.
  > 설정파일에 Annotation을 통해 component-scan할 장소를 적어준다.

  * 실행할 Main java class

  ```java
  ApplicationContext context = new AnnotationConfigApplicationContext(ApplicationConfig.class);
  
  GuestBookService guestBookService = context.getBean("Service", GuestBookServiceImpl.class);
  ```

  * Configuration.java

  ```java
  @Configuration
  @ComponentScan
  ```

​             

#### 스프링 빈의 생명 주기(Life Cycle)

* 빈 생성 - 의존성 주입 - init-method 실행 - 빈 사용 - destroy-method 실행 - 빈 소멸

​                  

### 3. Spring Web MVC

> 장점: 화면과 비즈니스 로직을 분리해서 작업 가능, 영역별 개발로 인해 확장성 뛰어남, 공동작업 용이, 유지보수성 좋음
> 단점: 개발과정이 복잡해 초기 개발속도가 늦음, 초보자가 이해하고 개발하기 다소 어려움

* DispatcherServlet(Front Controller)
  * 모든 클라이언트의 요청을 받음
  * Controller에게 클라이언트 요청을 전달, Controller가 리턴한 값을 View에게 전달해 알맞은 응답 생성
* HandlerMapping
  * 클라이언트 요청 URL을 어떤 Controller가 처리할지 결정
  * URL과 요청 정보를 기준으로 어떤 핸들러 객체를 사용할지 결정하는 객체, DispatcherServlet은 하나 이상의 핸들러 매핑을 가질 수 있음
* Controller
  * 클라이언트의 요청을 처리한 뒤 Model을 호출하고 그 결과를 DispatcherServlet에 알려준다.
* ModelAndView
  * Controller가 처리한 데이터 및 화면에 대한 정보를 보유한 객체
* ViewResolver
  * Controller가 리턴한 뷰 이름을 기반으로 Controller의 처리 결과를 보여줄 View 결정
* View
  * Controller의 처리결과를 보여줄 응답화면 생성

​              

### 4. 실행순서 정리

1. 웹 어플리케이션 실행시 Tomcat(WAS)에 의해 web.xml loading

2. Web.xml에 등록된 ContextLoaderListener 생성

   * ApplicationContext를 생성하는 역할

   ```xml
   <listener>
   		<listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
   	</listener>
   ```

3. ContextLoaderListener가 root-context.xml 로딩

   * contextConfigLocation를 통해 경로 지정 가능

   ```xml
   <context-param>
   		<param-name>contextConfigLocation</param-name>
   		<param-value>/WEB-INF/spring/root-context.xml</param-value>
   </context-param>
   ```

4. root-context.xml 등록된 설정에 따라 Spring Container 가동

   * non-web 관련 객체들 생성
   * aop 설정
   * Datasource
   * My-batis mapper 위치
   * Transaction 등록: 등록시 Datasource가 필요하다.

   ```xml
   <context:component-scan base-package="model, aop" />
   <aop:aspectj-autoproxy></aop:aspectj-autoproxy>
   ```

   ```xml
   <bean id="dataSource" class="org.springframework.jndi.JndiObjectFactoryBean">
   		<property name="jndiName" value="java:comp/env/jdbc/site"></property>
   </bean>
   
   <bean id="sqlSessionFactoryBean" class="org.mybatis.spring.SqlSessionFactoryBean">
   		<property name="dataSource" ref="dataSource"/>
   		<property name="typeAliasesPackage" value="com.site.method.model"/>
   		<property name="mapperLocations" value="classpath:mapper/*.xml"/>
   </bean>
   
   <mybatis-spring:scan base-package="com.site.method.model.mapper"/>
   ```

   ```xml
   <bean id="transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
   		<property name="dataSource" ref="dataSource" />
   </bean>
   	
   <tx:annotation-driven transaction-manager="transactionManager"/>
   ```

5. Client 요청에 의해 Dispatcher Servlet 생성

   ```xml
   <servlet>
   		<servlet-name>appServlet</servlet-name>
   		<servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
   		<init-param>
   			<param-name>contextConfigLocation</param-name>
   			<param-value>/WEB-INF/spring/appServlet/servlet-context.xml</param-value>
   		</init-param>
   		<!-- DispatcherServlet이 해당 mapping을 찾지 못할 경우 NoHandlerFoundException를 throw하게 설정 -->
   		<init-param>
   			<param-name>throwExceptionIfNoHandlerFound</param-name>
   			<param-value>true</param-value>
   		</init-param>
   		<load-on-startup>1</load-on-startup>
   	</servlet>
   		
   	<servlet-mapping>
   		<servlet-name>appServlet</servlet-name>
   		<url-pattern>/</url-pattern>
   	</servlet-mapping>
   ```

6. DispatcherServlet은 servlet-context.xml을 loading

   * web 관련: viewResolver, controller load, resources mapping, interceptors, file 관련

   ```xml
   <resources mapping="/resources/**" location="/resources/" />
   
   <beans:bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
     <beans:property name="prefix" value="/WEB-INF/views/" />
     <beans:property name="suffix" value=".jsp" />
   </beans:bean>
   
   <context:component-scan base-package="com.ssafy.webmvc" />
   ```

   * Interceptors 관련
   
   ```xml
   <bean id="confirm" class="com.site.interceptor.ConfirmInterceptor"/>
   
   <interceptors>
   	<interceptor>
     	<mapping path="URL1"/>
       <mapping path="URL2"/>
       <mapping paht="URL3"/>
       
       <beans:ref bean="confirm"/>
     </interceptor>
   
   </interceptors>
   ```
   
   * File 관련: Download는 java 파일을 대입해서 사용한다.
   
   ```xml
   <beans:bean id="multipartResolver" class="org.springframework.web.multipart.commons.CommonsMultipartResolver">
   	<beans:property name="defaultEncoding" value="UTF-8"/>
     <beans:property name="maxUploadSize" value="52429900"/>
     <beans:property name="maxInMemorySize" value="1048576"/>
   </beans:bean>
   
   <beans:bean id="fileDownLoadView" class="com.site.home.view.FileDownLoadView"/>
   <beans:bean id="fileViewResolver" class="org.springframework.web.servlet.view.BeanNameViewResolver">
     <beans:property name="order" value="0"/>
   </beans:bean>
   ```
   
   
   
   

#### - form 태그의 파라미터들을 리스트로 받아주기

* name을 DTO(서버단) 내부에 있는 List 인스턴스 이름에 맞춰서 넣어준다.

```html
<input type="text" name="userList[0].name">
<input type="text" name="userList[1].age">
```

​                      

### 5. SpringBoot

> 이전 Spring Legacy와 차이점
>
> 1. 내부에 내장서버를 이미 포함하고 있다.
> 2. WAS에 배포하지 않고 JAR 파일로 생성해 배포할 수 있다.

​               



#### - application.properties

```
#server setting [tomcat: server.xml]: localhost
server.port=80

#JSP Setting [view resolver: servlet-context.xml]
spring.mvc.view.prefix=/WEB-INF/views/
spring.mvc.view.suffix=.jsp

#DataBase Setting [DataSource: root-context.xml]
spring.datasource.driver-class=com.mysql.cj.jdbc.Driver
spring.datasource.url=jdbc:mysql://127.0.0.1:3306/ssafyweb?serverTimezone=UTC&useUniCode=yes&characterEncoding=UTF-8
spring.datasource.username=ssafy
spring.datasource.password=ssafy1234

#MyBatis Setting [DataSource: root-context.xml]
mybatis.type-aliases-package=com.ssafy.guestbook.model
mybatis.mapper-locations=mapper/**/*.xml

#File Upload size Setting [Servlet: servlet-context.xml]
spring.servlet.multipart.max-file-size=5MB
spring.servlet.multipart.max-request-size=5MB

#log level Setting [Every Method: src/main/resources/log4j.xml]
logging.level.root=info
logging.level.com.ssafy.guestbook.controller=debug

#Failed to start bean 'documentationPluginsBootstrapper'; error
spring.mvc.pathmatch.matching-strategy=ant-path-matcher

#Filter: UTF = Auto So don't need
```

* 바뀐점들
  * File 부분
    * multipartResolver: multipart
    * maxUploadSize: max-file-size
    * maxInMemorySize: max-request-size
  * log4j = logging.level.root / logging.level.com.site.home.controller 

​             



### Annotation 정리

| Annotation 명     | 예시                                                         | 설명                                                         |
| ----------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| @Component        | `@Component("memberService")`                                |                                                              |
| @Scope            | `@Scope("singleton")`<br />`@Scope("prototype")`<br />`@Scope("request")`<br />`@Scope("response")` | 스프링 컨테이너당 하나의 인스턴스 빈 생성<br />컨테이너에 빈을 요청할 때마다 새로 생성<br />HTTP Request별로 새로운 인스턴스 생성<br />HTTP Session별로 새로운 인스턴스 생성 |
| @Controller       | @Controller                                                  | DefaultAnnotationHandlerMapping과 <br />AnnotationHandlerAdapter를 사용 |
| @RequestMapping   | @RequestMapping("/user")<br />@RequestMapping(value="/index" method=RequestMethod.GET) | URL을 매핑해주는 역할<br />Ant 스타일의 URI 패턴 지원: ? / * / ** |
| @CrossOrigin      | @CrossOrigin(origins = "*", methods = {RequestMethod.GET , RequestMethod.POST, RequestMethod.PUT, RequestMethod.DELETE}) | Ajax의 크로스 도메인 문제를 해결                             |
| @PathVariable     | @RequestMapping("/user/{value}")<br />@PathVariable String value, | URI 템플릿 변수에 접근할 때 사용<br />@RequestMapping에서 감싸준 {템플릿 변수}와 같은 이름이어야 한다. |
| @RequestParam     | @RequestParam("userId") String userId<br />@RequestParam(value="userId", defaultValue="none")<br />@RequestParam(value="name", required=false) | 메서드 인자값으로 들어온 Http 요청 파라미터를 수동으로 매핑시켜준다.<br />defaultValue: 기본값<br />required: 필수 여부 |
| @RequestHeader    | @RequestHeader(value="Accept")<br />@RequestHeader(value="Accept-Language")<br />@RequestHeader(value="Host") | value 속성을 이용해 Http 요청 헤더값을 컨트롤러 내부에 파라미터 형식으로 전달해준다. |
| @RequestBody      | @ReqeustBody                                                 | HTTP 요청의 body 내용에 접근할 때 사용, JSON 데이터를 원하는 타입으로 바인딩 |
| @CookieValue      | @CookieValue(value="auth", defaultValue="none" required=false) | HTTP Header 내부에 저장된 쿠키를 메서드의 인자 안에서 Annotation을 통해 잡아줄 수 있다. |
| @ModelAttribute   | @ModelAttribute("myDto") MemberDto memberDto                 | Controller에서 파라미터를 인자와 자동매핑한다면 다시 자동으로 Model에 이 값이 담겨서 jsp에서 EL 문법으로 바로 사용할 수 있다(${memberDto.name}). 이 때 @ModelAttribute를 사용해 view로 보낼 객체 이름을 바꿀 수 있다(${myDto.name}). |
| @RestController   | @RestController                                              | 일반적인 Controller는 문자열을 반환하면 View Resolver가 주소형식으로 만들어 보내주지만<br />RestController는 @ResponseBody 를 자동으로 붙여주어 데이터를 손쉽게 반환하도록 해준다. |
| @ResponseBody     | @ResponseBody                                                | Http Body의 내용을 객체로 전달한다(비동기 처리).             |
| @Service          | @Service("myService")                                        | Service Layer의 클래스에 사용                                |
| @Repository       | @Repository                                                  | Data Access Layer의 DAO 또는 Repository 클래스에 사용<br />DataAccessException 자동변환과 같은 AOP의 적용 대상을 선정하기 위해 사용한다. |
| @Component        | @Component                                                   | 위의 Layer 구분을 적용하기 어려운 일반적인 경우에 설정       |
| @Autowired        | @Autowired(required=false)<br />@Qualifier("methodName")<br />@Qualifier("argName") | 멤버변수, setter, constructor, 일반 method에 사용 가능<br />required 속성을 이용해 주입하지 않고도 bean으로 생성하도록 한다.<br />@Autowired가 여러 개인 경우 @Qualifier를 통해 구분<br />@Qualifier는 생성 / 주입시 모든 경우에 사용한다<br />**타입**에 맞춰서 연결 |
| @Resource         | @Resource(name="myDao")                                      | 멤버변수, setter에 사용 가능<br />특정 Bean이 JNDI 리소스에 대한 Injection을 필요로 하는 경우 사용권장<br />**타입**에 맞춰서 연결 |
| @Inject           | @Inject                                                      | Spring 3.0부터 지원(@Autowired, @Resource는 2.0)<br />framework 에 종속적이지 않음<br />멤버변수, setter, constructor, 일반 method에 사용 가능<br />javax.inject-x.x.x.jar 파일 추가 필수<br />**이름**으로 연결 |
| @Configuration    | @Configuration                                               | 초기 Spring의 java 설정 파일<br />스프링 부트의 Interceptor 설정 등을 위한 WebMvcConfiguration<br />Swagger Configuration |
| @ControllerAdvice | @ControllerAdvice                                            | Exception이 발생했을 때 발동하는 컨트롤러                    |
| @ExceptionHandler | @ExceptionHandler(NoHandlerFoundException.class)             | 특정 예외를 잡아서 메서드와 매핑                             |
| @ResponseStatus   | @ResponseStatus(value= HttpStatus.NOT_FOUND)                 | 특정 HTTP 응답 신호를 보낼 수 있다.                          |
| @Mapper           | @Mapper                                                      | Mapper 역할을 하는 클래스 지정                               |
| @Transactional    | @Transactional(rollbackFor = Exception.class)                | DB 상으로 begin, commit을 자동으로 수행해준다.<br />예외 발생시 rollback 처리를 자동으로 해준다.<br />@Transaction으로 지정된 메서드 내부에서 하나라도 실패한 경우 실패로 간주한다.(원자성)<br />대표적 속성: rollbackFor / noRollbackFor |
| @EnableSwagger2   |                                                              | Swagger를 사용하기 위해 설정파일에 적용                      |
| @Api              | @Api(value="Swagger Name")                                   | Controller의 이름 명시                                       |
| @ApiOperation     | @ApiOperation(value="설명", response=User.class)             | 설명과 반환값을 적어줄 수 있다.                              |
| @ApiModel         | @ApiModel(value="설명", description = "xx의 정보를 나타낸다.") | DTO 등 객체에 swagger 등록                                   |
| @ApiModelProperty | @ApiModelProperty(value="유저 이름")                         | 내부 변수 설명                                               |

​                   

​                     

### xml 정리

1. **bean** - id, class

   ```xml
   <bean id="dao" class="com.site.model.dao">
   ```

2. **bean** > **property** - name / ref

   ```xml
   <bean id="service" class="com.site.model.service">
   	<property name="dao" ref="dao"/>
   </bean>
   ```

3. **bean Constructor 주입**: constructor-arg

   * Service 등에 의존성 주입

   ```xml
   <bean id="service" class="com.site.model.service">
   	<constructor-arg ref="dao"/>
   </bean>
   ```

   * Dto 등 객체에 값 주입: **constructor-arg** - name, type, index > value

     > 각각의 타입이 다른 경우 자동으로 매칭시켜주지만 만약 같다면 인자이름(name), 인자순서(index), 데이터타입(type) 등을 사용해서 명시해주어야 한다.

   ```xml
   <bean id="dto" class="com.site.model.dto">
     
     <constructor-arg name="age" value="31" />
     <constructor-arg name="name" value="홍길동">
     
   </bean>
   ```

   
# Spring Boot Setting

* application.property
* config 패키지 내부 java 파일

​                       

### 0. Spring Boot URL

> 만약 URL 로 `/admin/user` 을 검색하면 `@Controller`를 먼저 찾는 것이 아니라 resources/static 하위에 admin 폴더가 있는지 먼저 찾아보기 때문에 url 경로와 동일한 이름으로 static 내부에 폴더를 만들지 않도록 주의한다. 이후 static에 해당 파일이 없다면 `@Controller`를 찾아본다. Client 입장에서 static 내부의 자원은 url로 접근할 수 있다.

​                  

### 1. Application.property

> 서버 관련한 세팅을 해준다. web.xml에서의 세팅 내용과 비슷한 맥락.
> 원래 어디서 사용했던 것인지 [ ]안에 명시했다.
> **문자열** 관련한 설정들을 넣어준다.

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

​              

### 2. java 설정 파일

> interceptors 의 순서 같은 설정은 자동으로 해 줄 수 없으므로 java 설정파일을 통해 설정해준다.
> interceptor를 인스턴스로 생성해서 사용한다.
>
> * xml파일에 namespace로는 인터페이스의 위치를 알 수 없으므로 scan을 한 번 해주었다.
>
>   ```xml
>   <mybatis-spring:scan base-package="com.site.home.model.mapper"/>
>   ```
>
>   * 이 스캔을 자바 단계에서 Annotation으로 수행한다.
>
>     ```java
>     @MapperScan(basePackages = {"com.site.**.mapper"})
>     ```
>
> * 스프링에서 `<bean>`으로 주입해주었던 것들을 JAVA로 다시 인스턴스로 만들어 주입한다.
>
>   ​         

* `implements` 구현을 통해 설정파일을 만들 수 있다.

  ```java
  import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
  
  public class WebMvcConfiguration implements WebMvcConfigurer{
  ```

* Opt+Cmd+S 를 눌러 Override 할 메서드를 추가한다.

  ```java
  	@Override
  	public void addInterceptors(InterceptorRegistry registry) {
  		
  	}
  ```

* Annotation을 추가한다.

  ```java
  @Configuration //설정 파일임을 알려준다.
  @EnableAspectJAutoProxy //AOP 설정: aop:auto-proxy를 대신함
  @MapperScan(basePackages = {"com.site.**.mapper"})
  //application.property에서 xml 경로 설정은 해주었지만 Mapper.java 들은 따로 연결시켜주어야함
  public class WebMvcConfiguration implements WebMvcConfigurer{
  	
  	
    //아래 interceptors 순서 설정을 위해 필요한 자원들 자동 주입
  	@Autowired
  	private ConfirmInterceptor confirm; //인스턴스로 interceptors 생성
  	
  	private final List<String> patterns = Arrays.asList("/home/*","/admin/*", "/user/list" );
  	
  	@Override
  	public void addInterceptors(InterceptorRegistry registry) {
  		registry.addInterceptor(confirm).addPathPatterns(patterns);
  	}
  ```

  






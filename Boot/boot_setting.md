# Spring Boot Setting

* application.property
* config 패키지 내부 java 파일

​                       

### 1. Application.property

> 서버 관련한 세팅을 해준다. web.xml에서의 세팅 내용과 비슷한 맥락.

```
#server setting
server.port=80

#JSP Setting
spring.mvc.view.prefix=/WEB-INF/views/
spring.mvc.view.suffix=.jsp

#DataBase Setting
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.datasource.url=jdbc:mysql://127.0.0.1:3306/ssafyweb?serverTimezone=UTC&amp;useUniCode=yes&amp;characterEncoding=UTF-8
spring.datasource.username=ssafy
spring.datasource.password=ssafy1234

#MyBatis Setting: /**/ = 중간 경로 모두 포함
mybatis.type-aliases-package=com.site.home.model
mybatis.mapper-locations=mapper/**/*.xml 

#File Upload size Setting
spring.servlet.multipart.max-file-size=5MB
spring.servlet.multipart.max-request-size=5MB

#log level Setting
logging.level.root=info
logging.level.com.site.home.controller=debug

#Failed to start bean 'documentationPluginsBootstrapper'; error
spring.mvc.pathmatch.matching-strategy = ANT_PATH_MATCHER
```

​             

### 2. java 설정 파일

> interceptors 의 순서 같은 설정은 자동으로 해 줄 수 없으므로 java 설정파일을 통해 설정해준다.

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
  	private ConfirmInterceptor confirm; 
  	
  	private final List<String> patterns = Arrays.asList("/home/*","/admin/*", "/user/list" );
  	
  	@Override
  	public void addInterceptors(InterceptorRegistry registry) {
  		registry.addInterceptor(confirm).addPathPatterns(patterns);
  	}
  ```

  






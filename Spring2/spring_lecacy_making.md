# Spring MVC Legacy Annotation 방식

> * xml 내부에서는 & 을 `&amp;` 로 표현함에 주의한다.             
>
> 1. DB 관련 업무
> 2. Web 설정
>    * pom.xml: Dependencies
>    * context.xml: 파일에 db 접속 정보관리
>    * root-context.xml 파일
>      * MyBatis 설정
>    * servlet-context.xml 파일
>    * Controller, Service, Mapper 클래스 생성
>    * 응용 업무 구현

​                 

## 1. Spring legacy Project 로 생성

> 초기 설정에 주의한다.

* 3 depth 패키지 설정 및 폴더 구조 설계

  ​             

* 폴더 구조

  * model

    * repo: 이전 dao의 역할
    * service

  * controller

  * aop

  * dto: DB의 column 들을 확인

  * util: DB 접속 종료를 위한 틀

    ​        

* webapp 폴더 아래 폴더 추가

  * META-INF: context.xml 추가

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <Context>
    	<Resource name="jdbc/sofia" auth="Container" type="javax.sql.DataSource" 
    			maxTotal="100" maxIdle="30" maxWaitMillis="10000" 
    			username="sofia" password="sofia1234" driverClassName="com.mysql.cj.jdbc.Driver" 	
    			url="jdbc:mysql://localhost:3306/sofiaweb?serverTimezone=UTC&amp;useUniCode=yes&amp;characterEncoding=UTF-8"/> 
        <WatchedResource>WEB-INF/web.xml</WatchedResource>
    </Context>
    ```

  * resources: 이미지 등 추가

    ​               

* 설정 파일

  * pom.xml: 최신 버전을 붙여넣기로 사용, 버전 확인/패키지명 확인: groupId / artifactId / properties 내부 필요한 부분 등

    ```xml
    	<groupId>com.sofia</groupId>
    	<artifactId>ws</artifactId>
    ```

    ​             

  * root-context(non-web): component-scan으로 Controller 인식(servlet)

    * Namespace에 context, aop 체크되어있는지 확인 이후 사용(자동완성)

    ```xml
    <context:component-scan base-package="com.sofia.ws.model, com.sofia.ws.aop, com.sofia.ws.util"/>
    ```

    ​          

  * root-context: DB Connection pool을 위한 dataSource 를 연결

    ```xml
    	<bean id="dataSource" class="org.springframework.jndi.JndiObjectFactoryBean">
    		<property name="jndiName" value="java:comp/env/jdbc/sofia"></property>
    	</bean>
    ```

    ​           

  * aop 설정

    * proxy-target-class 를 true 로 설정해서 인터페이스 만들 때 Impl 클래스를 getBean으로 사용할 수 있게 만들기

    ```xml
    <aop:aspectj-autoproxy proxy-target-class="true"/>
    ```

    ​          

  * util 패키지에 DB 연결 끊는 class 넣어주기

    ```java
    package com.sofia.ws.util;
    
    import org.springframework.stereotype.Component;
    
    @Component
    public class DBUtil {
    
    	public void close(AutoCloseable... closeables) {
    		for (AutoCloseable c : closeables) {
    			if (c != null) {
    				try {
    					c.close();
    				} catch (Exception e) {
    					e.printStackTrace();
    				}
    			}
    		}
    	}
    	
    }
    
    ```

    

​               

## 2. 구조 만들기

> 먼저 구조를 만족하도록 dto, service 등을 작성한다.
> 구현부터는 @Autowired로 연쇄적으로 연결되므로 만들어졌는지 확인하며 작성한다.

​           

#### DTO 만들기

* private 으로 변수 선언해주고 Getter & Setter 만들기

  ```java
  package com.sofia.ws.dto;
  
  public class UserDto {
  	private String id;
  	private String name;
  	private String pass;
  	private String rec_id;
  	
  	//Getter Setter 만들기 
  }
  ```

  ​               

#### Service Interface

* interface로 먼저 만들고 구현하도록 한다.

  ```java
  package com.sofia.ws.model.service;
  
  import com.sofia.ws.dto.UserDto;
  
  public interface MemberService { 
  	int register(UserDto user) throws Exception;
  	UserDto login(String id, String pass) throws Exception;
  	int logout() throws Exception;
  	int leave(UserDto user) throws Exception;
  }
  
  ```



#### Dao 인터페이스 및 구현하기

* Service를 복붙해서 Dao 인터페이스를 만들고 구현까지 해준다.

* DB와 연결할 코드를 써준다.

  ```java
  package com.sofia.ws.model.repo;
  
  import com.sofia.ws.dto.UserDto;
  
  public interface MemberDao {
  	int register(UserDto user) throws Exception;
  	UserDto login(String id, String pass) throws Exception;
  	int logout() throws Exception;
  	int leave(UserDto user) throws Exception;
  }
  
  ```

  * 구현이므로 컴포넌트 스캔을 위해 @Repository 를 잊지 않는다.
    * @Autowired를 통해 DBUtil 과 DataSource를 인스턴스로 생성한다.
    * private으로 접근제한자를 걸어준다.

  ```java
  package com.sofia.ws.model.repo;
  
  import javax.sql.DataSource;
  
  import org.springframework.beans.factory.annotation.Autowired;
  import org.springframework.stereotype.Repository;
  
  import com.sofia.ws.dto.UserDto;
  import com.sofia.ws.util.DBUtil;
  
  @Repository // 구현: component-scan을 위해 써준다.
  public class MemberDaoImpl implements MemberDao {
  	
  	@Autowired //생성해서 넣어준다.
  	private DBUtil dbUtil;
  	
  	@Autowired
  	private DataSource dataSource;
    
    
    ...
  ```

  ​             

### Service 구현하기

* DAO 를 만들었으므로 Service에서 이 인스턴스를 Autowired로 가져온다

  * 가져오기 전에 Component-scan을 위한 @Repository 설정을 한다.

  ```java
  package com.sofia.ws.model.service;
  
  import org.springframework.beans.factory.annotation.Autowired;
  import org.springframework.stereotype.Repository;
  
  import com.sofia.ws.dto.UserDto;
  import com.sofia.ws.model.repo.MemberDao;
  
  @Repository //Annotation 설정 
  public class MemberServiceImpl implements MemberService {
  	
  	@Autowired // 변수화
  	private MemberDao dao;
  ```

  ​            



#### Controller 틀

* @Controller 를 등록해준다.

* **ServletContext를 연결**한다

  ```java
  	@Autowired
  	private ServletContext servletContext;
  ```

* Logger를 import 한다: class를 잘 확인한다.

  ```java
  import org.slf4j.Logger;
  import org.slf4j.LoggerFactory;
  
  public class BookController {
  	private static final Logger logger = LoggerFactory.getLogger(BookController.class) 
  }
  ```

* 위에서 만든 Service 구현체를 연결한다.

  ```JAVA
  @Autowired
  private MemberService service;
  ```

* `@GetMapping("/")`과 `PostMapping("/")`를 이용해 html의 요청에 따른 작업들을 처리한다.

  ```java
  package com.sofia.ws.controller;
  
  import javax.servlet.ServletContext;
  import javax.servlet.http.HttpServletRequest;
  import javax.servlet.http.HttpServletResponse;
  import javax.servlet.http.HttpSession;
  
  import org.slf4j.Logger;
  import org.slf4j.LoggerFactory;
  import org.springframework.beans.factory.annotation.Autowired;
  import org.springframework.stereotype.Controller;
  import org.springframework.web.bind.annotation.GetMapping;
  import org.springframework.web.bind.annotation.PostMapping;
  import org.springframework.web.servlet.ModelAndView;
  
  import com.azul.tooling.in.Model;
  import com.sofia.ws.dto.UserDto;
  import com.sofia.ws.model.service.MemberService;
  
  @Controller
  public class BookController {
  	private static final Logger logger = LoggerFactory.getLogger(BookController.class); 
  			
  	@Autowired
  	private ServletContext servletContext;
  	
  	@Autowired
  	private MemberService service;
  	
  	@GetMapping("/")
  	public String index() {
  		return "index";
  	}
  	
  	@GetMapping("/regist")
  	public String regist() {
  		return "regist";
  	}
  	
  	@GetMapping("/logout")
  	public String logout(HttpServletRequest request) {
  		HttpSession session = request.getSession();
  		session.invalidate();
  		return "index";
  	}
  	
  	
  	@PostMapping("/regist")
  	public String regist(UserDto user) throws Exception {
  		service.register(user);
  		return "index";
  	}
  	
  	@PostMapping("/login")
  	public String login(UserDto user, HttpServletRequest request) throws Exception {
  		UserDto userinfo = null;
  		userinfo = service.login(user.getId(), user.getPass());
  		HttpSession session = request.getSession();
  		session.setAttribute("user", userinfo);
  		return "index";
  	}
  	
  	
  	
  }
  
  ```


​                      

​                          

## 3. CRUD 구현하기


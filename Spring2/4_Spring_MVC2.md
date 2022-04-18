## Spring MVC 구현

1. web.xml에 DispatcherServlet 등록
   * 원래 Servlet 등록 방식은 xml에서 등록하고 mapping을 수동으로 설정하는 것이다.
     * 이것에서 더 발전한 모습: Servlet에서의 `@WebServlet("/hs")`같은 annotation 형태이다.
2. Spring 설정파일 등록
   * DI, AOP와 같은 설정
   * web / non-web
     * web: controller
     * non - web: service, dao
3. web.xml: 최상위 Root ContextLoader 설정
   * Context 설정 파일들을 로드하기 위해 web.xml 파일에 리스너 설정(ContextLoaderListener)
   * 리스너 설정이 되면 /WEB-INF/spring/root-context.xml 파일을 읽어서 공통적으로 사용되는 최상위 Context 생성
   * 그 외 다른 컨텍스트 파일들을 최상위 어플리케이션 컨텍스트에 로드하도록 해보자.

​               

### 1) Controller Class 작성

* POJO: Annotation 말고 특별히 무언가 존재하는 것이 아니다.

* Context 설정 파일에 Controller 등록. (Servlet-context.xml)

  * 하지만 Annotation 방식을 사용할 것이므로 아래 설정은 지양한다.

  ```xml
  <beans:bean class="com.test.web.HomeController"/>
  ```

​             

### 2) Controller와 response page 연결을 위한 ViewResolver 설정

```xml
<beans:bean class="com.test.web.HomeController"/>

<beans:bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
	<beans:property name="prefix" value="/WEB-INF/views/"/>
  <beans:property name="suffix" value=".jsp"/>
</beans:bean>
```

​               

​                     

## < Controller >

##  
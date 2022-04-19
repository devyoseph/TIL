## Spring Controller / Model / View

​           

## Controller

> Client의 요청을 처리
> Class 타입에 적용
> Spring 3.0부터 @Controller 사용을 권장

### `@Controller` / `@RequestMapping` 선언

* method 단위의 mapping 가능

  ​           

* RequestMapping: 요청 URL mapping 정보 설정, **클래스와 메서드**에 적용 가능, **HTTP 요청을 한정**할 수 있다.

  * 이것을 다시 줄인 `GetMapping`과 `PostMapping`을 사용가능

  ```java
  @ReqeustMapping(value= "/index.do"), method = RequestMethod.GET)
  ```

  ```java
  @GetMapping("/index.do")
  ```

  ​            

* Spring 3.0 미만 버전에서는 DefaultAnnotationHandlerMapping과 AnnotationHandlerAdapter를 사용

```java
@Controller
@RequestMapping("/reboard")
public class ReboardController{

	@Autowired
	
	@RequestMapping
}
```

​         

### 등록 방법 2가지

* <bean> 등록

  ```xml
  <beans:bean id="reboardController" class="com.~">
  	<beans: property name="reboardService" ref="reboardService"/>
  </beans:bean>
  ```

* 자동 스캔

  ```xml
  <context:component-scan base-package="com.text.board.controller"/>
  ```

​             

### Parameter type

> Controller method의 parameter로 다양한 Object를 받을 수 있음

| Parameter Type                                               | 설명                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| HttpServletRequest<br />HttpServletResponse<br />HttpSession | 필요시 Servlet API 사용 가능                                 |
| Java.util.Locale                                             | 현재 요청에 대한 locale                                      |
| InputStream, Reader                                          | 요청 컨텐츠에 접근                                           |
| OutputStream, Writer                                         | 응답 컨텐츠 생성                                             |
| @PathVariable annotation 적용 파라미터                       | URI 템플릿 변수에 접근                                       |
| @RequestParam annotation 적용 파라미터                       | HTTP 요청 파라미터를 매핑                                    |
| @RequestHeader annotation 적용 파라미터                      | HTTP 요청 헤더 매핑                                          |
| @CookieValue annotation 적용 파라미터                        | HTTP 쿠키 매핑                                               |
| **@RequestBody** annotation 적용 파라미터                    | HTTP 요청의 body 내용에 접근                                 |
| Map, Model, ModelMap                                         | view에 전달할 model data를 설정                              |
| **커맨드 객체(DTO)**                                         | HTTP 요청 parameter를 저장한 객체<br />기본적으로 클래스 이름을 모델명으로 사용<br />@ModelAttribute annotation 설정으로 모델명 설정 가능 |
| SessionStatus                                                | 폼 처리를 완료 했음을 처리하기 위해 사용<br />@SessionAttributes annotation을 명시한 session 속성을 제거하도록 이벤트 발생 |

​            

### Parameter Mapping

* required: 받을 때 필수가 아닌 파라미터 설정 가능

  ```java
  @RequestMapping(value = "/index.do", method = ReqeustMethod.GET)
  public String home(@RequestParam(value="name", required=false) String name){
  
  }
  ```

* Command 객체를 List로 받기

  ```html
  <form method="post" action="${root}/~">
  	<input type ="test" name="productList[0].pnum">
    <input type ="test" name="productList[0].name">
    <input type ="test" name="productList[0].price">
  </form>
  ```

  * 만약 productList 란 변수명이 ArrayList이고 객체를 담고 있는데 그 객체 안에 변수가 3개 있다면?
    * 위와 같이 매핑 가능

​                   

* view에서 Controller의 파라미터 접근

  ```
  ${boardDto.subject}
  ```

  ​        

* **@CookieValue**를 이용한 쿠키 매핑

  ```java
  @Controller
  public class HomeController{
  
  		public String hello(@CookieValue("author") String authorValue){
  			return "ok";
      }
  }
  ```

* **@RequestHeader**를 이용한 매핑도 위와 비슷하다.

* **@RequestBody**를 통한 비동기 처리 = Converter가 자동으로 객체 변환을 시켜줌

* HttpSession을 직접 제어할 수 있다.

  * Controller가 Cookie 생성 등

  ```java
  @Controller
  public class HomeController{
  
  		public String hello(HttpServletRequest request, HttpServletResponse response){
  			return "ok";
      }
  }
  ```



​               

​                 

## View

* Controller에서 처리 결과를 보여줄 View 이름이나 객체를 리턴

* DispatcherServlet은 View 이름이나 View 객체를 이용해 view 생성

  * 명시적 지정
  * 자동 지정

  ​          

* ViewResolver: 논리적 view와 실제 JSP 파일 mapping

  * servlet-context.xml

  ```xml
  <beans:bean class="org.~.InternalResourceViewResolver">
  	<beans:property name="prefix" value="/WEB-INF/views/" />
    <beans:property name="suffix" value=".jsp" />
  </beans:bean>
  ```

  * 결과: prefix + 논리뷰 + suffix

  ​           

* 명시적 지정

  ```java
  @Controller
  public class HomeController{
  	
    	@RequestMapping("/hello.do")
  		public ModelAndView hello(){
  			ModelAndView mav = new ModelAndView("hello");
        //mav.setViewName("hello");
        return mav;
      }
  }
  ```

  ```java
  @Controller
  public class HomeController{
  	
    	@RequestMapping("/hello.do")
  		public String hello(){
        return "hello";
      }
  }
  ```

​         

* view 자동지정

  * RequestToViewNameTranslator를 이용해 URL로부터 view 이름 결정
  * 자동 지정 유형
    * Return type이 Model이나 Map인 경우
    * Return Type이 void면서 ServletResponse나 HttpServletResponse 타입의 parameter가 없는 경우

  ```java
  @Controller
  public class HomeController{
  	
    	@RequestMapping("/hello.do")
  		public Map<String, Object> hello(){
        Map<String, Object> model = new Map<String, Object>();
        return model;
      }
  }
  ```

  ​           

* **redirect** 방법: 접두어를 사용

  ```java
  return "redirect:board/list.html?pg=1";
  ```

* sendRedirect 시에 parameter 보내는 방식

  * RedirectAttributes 클래스 이용

  ```java
  public String delete(@RequestParam("articleno") int articleNo, Model model, RedirectAttributes redirectAttributes) {
  		try {
  		redirectAttributes.addAttribute("msg", "글 삭제 성공!!!");
      }catch{
  		}
  ```

  

​                   

## Model

* view에 전달하는 데이터

  * @RequestMapping annotation 이 적용된 메서드의 Map, Model, ModelMap

    ```java
    public String hello(Map model){}
    ```

    ```java
    public String hello(ModelMap model){}
    ```

    ```java
    public String hello(Model model){}
    ```

    ​         

  * @RequestMapping mehod가 리턴하는 ModelAndView

  * @RequestMapping annotation 이 적용된 메서드가 리턴한 객체

​                

### Model Interface 주요 method

* Model addAttribute(String name, Object value);
* Model addAttribute(Object value);
* Model addAllAttribute(Collection<?> values);
* Model addAllAttribute((Map<String, ?> attributes);
* Model mergeAttribute((Map<String, ?> attributes);
* boolean containsAttribute(String name);

```java
@Controller
public class HomeController{
	
  	@RequestMapping("/hello.do")
		public ModelAndView hello(){
      ModelAndView mav = new ModelAndView();
      mav.setViewName("hello");
      mav.addObject("message", "안녕하세요");
      return mav;
    }
}
```

```java
@Controller
public class HomeController{
		
  	@ModelAttribute("modelMSG")
		public String message(){
      return "bye bye";
    }
  
  	@RequestMapping("/hello.do")
		public ModelAndView hello(Model model){
    	model.addAttribute("msg", "안녕");
      return "index";
    }
}
```


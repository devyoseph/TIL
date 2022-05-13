# 유효성 검사

> 메서드의 값을 처리해주는 ArgumentResolver에 의해 @Valid가 처리된다.
> @RequestBody의 경우 RequestResponseBodyMethodProcessor가 처리한다.
> @Valid와 @Validated의 차이는 **그룹으로 나눠서 검증할 수 있는지**의 차이이다.

​             

* `@Valid`를 활용

  > 제약 조건이 부여된 객체에 대해 빈 검증기(Bean Validator)를 이용해 검증하도록 지시

  * 이전 방법: Bean의 property로 주입

  * 이 방법의 단점

    * `List<Dto>` 로 들어올 때는 다른 방식을 사용해야한다. 

    * **전체 객체를 검사**하기 때문에 부분 검증에서는 한계점이 존재한다.

    * 중간에 오류가 터지면 메서드 내부에 설정한 `Logger`가 발동하지 않기 때문에 무슨 값이 들어왔는지 확인이 안된다.

    * BindingResult 오류시 작동하는 `if(bindingResult.hasErrors())`안에서 logger를 써도 읽히지 않는다.

      ​          

* `@Validated` 활용

  > 파라미터 유효성 검증은 컨트롤러에서 처리하고 `@Service`나 `@Repository`로 가져가지 않는 것이 바람직하지만 이와 같은 경우를 대비해 Spring은 AOP 기반으로 메서드의 요청을 가로채서 Proxy 서버에서 검증하도록 @Validated를 제공한다.

  * JSR 표준 기술이 아닌 Spring 프레임워크에서 제공하는 어노테이션 기능이다.

  * 주의점: Validate는 특정 그룹에서만 유효성검증을 할 수 있는데 코드가 복잡해 자주 쓰이진 않는다.

    ```java
    @PostMapping("/user/add") public ResponseEntity<Void> addUser(@RequestBody @Validated(UserValidationGroup.class) UserRequestDto userRequestDto) { ... }
    ```

    ​                  

  ​             

* 스프링 부트 라이브러리에 있기 때문에 따로 dependency를 입력하지 않아도 된다.

* 스프링의 경우 다음 의존성을 추가한다.

  ```xml
  <dependency>
      <groupId>javax.validation</groupId>
      <artifactId>validation-api</artifactId>
      <version>2.0.1.Final</version>
  </dependency>
          
  <dependency>
      <groupId>org.hibernate.validator</groupId>
      <artifactId>hibernate-validator</artifactId>
      <version>6.0.1.Final</version>
  </dependency>
  ```

​               

## @Valid / @Validated

* @RequestBody를 통해 데이터를 바인딩하는 경우를 예시로 한다.



### 1. @Valid

​               

#### 1. BindingResult

* `@RequestBody` 옆에 `@Valid`를 추가한다.

  ```java
  @PostMapping("/register")
  	public ResponseEntity<?> register(@RequestBody @Valid MemberDto member, Model model) throws Exception{
      ....
  }  
  ```

* 데이터가 유효하지 않다면 `BindingResult`에 담기 때문에 객체를 생성해준다.

  ```java
  @PostMapping("/register")
  	public ResponseEntity<?> register(@RequestBody @Valid MemberDto member, Model model, BindingResult bindingResult) throws Exception{
      ....
  }  
  ```

* 오류가 터졌을 때 받아줘야하는데 여러 개의 오류 정보가 담긴다. 그 에러들의 타입은 `ObjectError`로   받아줄 수 있고 `pom.xml`에서 추가한 `validation`의존성에서 추가된 객체이다.

  ```java
  if(bindingResult.hasErrors()) {
  			List<ObjectError> errorList = bindingResult.getAllErrors();
  			for(ObjectError error: errorList) {
  				System.out.println(error.getDefaultMessage());
  			}
  }
  ```

  ​                 

#### 2. Dto에서 제한 조건 지정

| Annotation                                                   | 제약조건                                                     |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| @NotNull<br />@NotEmpty                                      | Null 불가<br />Null 불가 + "" 불가                           |
| @Size(min = 2, max = 4)                                      | 길이 검사, null 허용                                         |
| @Max(value = 100)<br />@Min(value = -100)<br />@DecimalMax(value ="5.5")<br />@DecimalMin(value = "-5.5") | 정수 최대/최소값 지정<br />null 허용<br />같은 값 허용<br />직관적인 표현식 가능(@MAX(12)) |
| @Digits(integer = 3, fraction = 2)                           | integer = 3에 의해 100자리까지 허용<br />fraction = 2에 의해 소수 2째자리까지 허용<br />null 허용 |
| @Pattern(regex = "")                                         | 정규식에 해당하는 것만 통과<br />(email 용인 @Email 이 있지만 @Pattern 사용 권장) |
| @Positive<br />@PositiveOrZero<br />@Negative<br />@NegativeOrZero | 양수만 허용(0 비허용, null 비허용)<br />양수와 0 허용(null 비허용)<br />음수만 허용(0 비허용, null 비허용)<br />음수와 0 허용(null 비허용) |
| @Future<br />@FutureOrPresent<br />@Past<br />@PastOrPresent | 특정 시간대만 허용 / <br />시간까지 체크는 안됨<br />멤버필드가 String이면 에러<br />LocalData 권장 |



​                    

​           

#### - email Pattern 예시

> 참고 https://www.baeldung.com/java-email-validation-regex 

```java
@Test
public void testUsingStrictRegex() {
    emailAddress = "username@domain.com";
    regexPattern = "^(?=.{1,64}@)[A-Za-z0-9_-]+(\\.[A-Za-z0-9_-]+)*@" 
        + "[^-][A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,})$";
    assertTrue(EmailValidation.patternMatches(emailAddress, regexPattern));
}
```

​                 

### 작동 확인

```
WARN : org.springframework.web.servlet.mvc.support.DefaultHandlerExceptionResolver - Resolved [org.springframework.web.bind.MethodArgumentNotValidException: Validation failed for argument [0] in public org.springframework.http.ResponseEntity<?> com.meedawn.flower.controller.MemberController.register(com.meedawn.flower.model.MemberDto,org.springframework.ui.Model,org.springframework.validation.BindingResult) throws java.lang.Exception: [Field error in object 'memberDto' on field 'userName': rejected value [12]; codes [Size.memberDto.userName,Size.userName,Size.java.lang.String,Size]; arguments [org.springframework.context.support.DefaultMessageSourceResolvable: codes [memberDto.userName,userName]; arguments []; default message [userName],20,4]; default message [반드시 최소값 4과(와) 최대값 20 사이의 크기이어야 합니다.]] ]
```

​                

​                   

### 2. @Validated

> @Valid: ArgumentResolver에 의해 유효성 검사
> @Validated: AOP 기반으로 메서드 요청 인터셉터 처리
>
> @Validated 클래스 레벨 선언 시: 해당 클래스에 인터셉터 등록
>
> * 이 때문에 스프링 빈이라면 유효성 검증을 진행할 수 있다.
> * 검증을 진행할 메서드에는 @Valid를 선언해준다.
>
> ​             
>
> 예외 클래스의 차이
> @Valid: MethodArgumentNotValidException
> @Validated: ConstraintViolationException


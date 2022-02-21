# 스프링 빈과 의존관계

> 컨트롤러가 특정 클래스(멤버 서비스 등)를 이용해 조회를 수행할 수 있는데 이를 의존관계라고 한다. 
>
> @~ (어노테이션)을 활용한다.

​         

## 스프링 빈을 등록하는 2가지 방법

​         

### 컴포넌트 스캔 방식

* 컴포넌트 스캔과 자동 의존관계 설정
  * 컴포넌트 스캔: `@Controller`, `@Repository`,` @Service`
    * 위 세 개 모두 `@Component`의 종류들이고 컴포넌트 스캔이라고 부름
  * 컴포넌트 스캔의 범위(한계점): **main 실행파일에 임포트 된 패키지 기준으로 하위 패키지들에만 적용, 그 외는 적용X**
* 자바 코드로 직접 스프링 빈 등록하기

* `@Controller` : 메인 컨트롤러와 현재 컨트롤러를 연결해주는 역할
* `@Autowired` : 현재 컨트롤러와 class를 연결하는 역할

```java
@Controller // 자바스크립트에서 컨트롤러와 비슷: 스프링 시작과 동시에 올라옴
public class MemberController{ //기능은 없지만 스프링 컨테이너가 처음 뜰 때 그 안에 컨트롤러를 넣어둠

    private final MemberService memberService = new MemberService();

  	//생성자에 Aurowired = MemberController가 생성될 때 작동 = 의존관계 주입
  
    @Autowired // 멤버서비스에 있는 스프링이랑 연결시켜줌: 그러나 memberService는 순수 클래스기 때문에
    public MemberController(MemberService memberService){ //스프링이 바로 인식을 못함
        this.memberService = memberService; // 인식을 위해 MemberService에 @Service 입력
        //MemberRepository는 가서 @Repository를 써주면 된다
    }
}
```

​                 

* 그러나 스프링이 java의 클래스를 바로 인식해서 연결할 수는 없다.

  ```java
  @Service
  public class MemberService {
  
      private final MemberRepository memberRepository;
  
      @Autowired
      public MemberService(MemberRepository memberRepository) {
          this.memberRepository = memberRepository; 
      }
  ....
  ```

  ```java
  @Repository
  public interface MemberRepository {
  ```

  * 정형화된 패턴 : 이 두 설정을 통해 인식시켜줄 수 있음

​            

### 직접 스프링 빈 등록하기: `@Bean`

* 컨트롤러(`@Controller`)를 제외한 `@Autowired`나 `@Service`, `Repository`는 사용하지 않는 방법
* main - java - service에 새로운 실행파일을 생성: `SpringConfig.java`

```java
@Configuration
public class SpringConfig{

    @Bean
    public MemberService memberService(){ //멤버 서비스로 등록해주고
        return new MemberService(memberRepository()); // 내부에 레파지토리를 넣어주어야함
    }

    @Bean
    public MemberRepository memberRepository(){ //넣어주기 위해 다시 Bean을 인식
        return new MemoryMemberRepository();
    }
}
```

#### XML로 설정하는 방식 : 최근에 잘 사용하지 않으므로 생략

​        

​        

## 주입(Injection) 방식에 따라

### 생성자 주입

* 생성자를 실행할 때 주입하는 방식

```java
@Controller
public class MemberController{
  
  @Autowired
  public MemberController(MemberService memberService){
		this.memberService = memberService;
  }
}
```

​         

### 필드 주입

* 인스턴스를 직접 엮는 방식 (좋은 방식은 아님)

```java
@Controller
public class MemberController{
  
  @Autowired private MemberService memberService;

}
```

​        

### Setter 주입

* Injection 이후에는 딱히 재설정을 해주지 않는데 Setter로 만들면 다른 개발자가 연속적으로 호출 가능하기 때문에 요즘 잘 쓰이지 않는 추세(실행 중에 동적으로 변하는 경우는 거의 없으므로 생성자 주입 권장)

```java
@Controller
public class MemberController{
  
  private MemberService memberService;
  
  @Autowired 
  public void setMemberService(MemberService memberService){
  	this.memberService = memberService;
  }

}
```




 

# 웹 MVC 개발

> 조회할 때 : `@GetMapping`
>
> 등록할 때: `@PostMapping`
>
> html에서 보낼 때 : `summit` + `label`
>
> spring에서 보낼 때 : model.attribute( );

​             

## 홈 화면 추가

* controller - `HomeController.java` 생성

<img src="/Users/yang-yoseb/Library/Application Support/typora-user-images/image-20220225000605201.png" alt="image-20220225000605201" style="zoom:67%;" />

```java
@Controller
public class HomeController{

    @GetMappint("/")
    public String home(){
        return "home"
    }
}
```

* templates 에 `home.html`생성

<img src="/Users/yang-yoseb/Library/Application Support/typora-user-images/image-20220225001115918.png" alt="image-20220225001115918" style="zoom:67%;" />

```html
 <!DOCTYPE HTML>
  <html xmlns:th="http://www.thymeleaf.org">
  <body>
  <div class="container">
      <div>
<h1>Hello Spring</h1> <p>회원 기능</p>
<p>
<a href="/members/new">회원 가입</a> <a href="/members">회원 목록</a>
</p> </div>
    
</div> <!-- /container -->
   </body>
</html>
```

​                

​                 

## 회원 웹 기능

> HomeController도 있고 ApplicationController도 있지만 **MemberController**에 `@Controller`만들어준다.

```java
@Controller // 자바스크립트에서 컨트롤러와 비슷: 스프링 시작과 동시에 올라옴
public class MemberController { //기능은 없지만 스프링 컨테이너가 처음 뜰 때 그 안에 컨트롤러를 넣어둠

    private final MemberService memberService = new MemberService();

    @Autowired // 멤버서비스에 있는 스프링이랑 연결시켜줌: 그러나 memberService는 순수 클래스기 때문에
    public MemberController(MemberService memberService) { //스프링이 바로 인식을 못함
        this.memberService = memberService; // 인식을 위해 MemberService에 @Service 입력
        //MemberRepository는 가서 @Repository를 써주면 된다
    }

  
  // 컨트롤러 추가 부분
    @GetMapping("/members/new")
    public String createForm(){
        retrun "members/createMemberForm"; // members 라는 폴더를 생성할 것임
    }
}
```

* 경로를 미리 생성해주었고 templates 안에 폴더를 만들어준다.
  * 그 내부에 html 파일 생성 : `createMemberForm.html`

```html
<!DOCTYPE HTML>
<html xmlns:th="http://www.thymeleaf.org">

<body>
<div class="container">
      <form action="/members/new" method="post">
          <div class="form-group">
<label for="name">이름</label>
<input type="text" id="name" name="name" placeholder="이름을
입력하세요"> </div>
<button type="submit">등록</button> </form>
  </div> <!-- /container -->
  </body>
</html>
```

* 회원 등록하는 껍데기를 연결해주었다

​          

### 회원 관리하는 폼 만들기

* 따로 컨트롤러를 생성해준다.
* html 에서 `summit`으로 보내는 값을 **label의 이름으로 넘겨주기 때문**에 그 값을 컨트롤러로 받아줄 수 있다.
* ApplicationController도 있고 HomeController도 있지만 회원 관리 부분이므로 `MemberController`에서 `@Controller`를 추가해준다

```java
    @PostMapping("members/new") // PostMapping: 같은 단이지만 뒷 단에서 이루어지는 작업
    public String create(MemberForm form){
        Member member = new Member(); // 객체 인스턴스가 만들어지고
        member.setName(form.getName()); // 입력값으로 멤버의 이름 설정

        memberService.join(member); // 멤버 서비스의 회원가입 메소드 실행을 위해 멤버를 넘김

        return "redirect:/"; // redirect를 사용해 다시 보냄:  /  = 홈의 위치 
    }
```

* 지금까지 html상 데이터를 넘겨 받아 입력받은 정보를 바탕으로 회원가입 메소드를 실행했다.

​         

​          

## 회원 웹 기능 - 조회

* 목록을 눌렀을 때 동작하도록 만든다.
* MemberController에 컨트롤러를 추가해준다

```java
@GetMapping("/members") //조회 기능이므로 GetMapping

public String list(Model model){
  List<Memeber> members = memberService.findMembers(); // 이미 구현했었던 메서드 사용
  model.addAttribute("members", members);
  return "members/memberList"; // members 폴더 내부 memberList.html
}
```

* memberList.html 파일을 생성

```html
<!DOCTYPE HTML>
  <html xmlns:th="http://www.thymeleaf.org">
  <body>
  <div class="container">
      <div>
          <table>
              <thead>
            <tr>
            <th>#</th>
									<th>이름</th> </tr>
                </thead>
                <tbody>
                <tr th:each="member : ${members}">
                    <td th:text="${member.id}"></td>
                    <td th:text="${member.name}"></td>
                </tr>
                </tbody>
            </table>
</div>
    </div> <!-- /container -->
    </body>
    </html>
```
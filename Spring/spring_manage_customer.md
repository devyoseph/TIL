# 회원 관리 예제

##            

### 비즈니스 요구사항 정리

* 데이터 : 회원 ID, 이름
* 기능 : 회원 등록, 조회
* 아직 데이터 저장소가 선정되지 않음(가상의 시나리오)

​             

<img src="spring_manage_customer.assets/image-20220211001952400.png" alt="image-20220211001952400" style="zoom:67%;" />

* 서비스 : 회원은 중복 가입이 안된다 등 서비스에 필요한 로직들이 존재 [ 핵심 비즈니스 로직 ]
* 도메인 : 회원, 주 쿠폰 등등 데이터베이스에서 관리하는 [ 비즈니스 도메인 객체 ]
* 리포지토리 : 데이터베이스에 접근, 도메인 객체를 DB에 저장하고 관리

​           

### < 실습 내용 >

<img src="spring_manage_customer.assets/image-20220211002424468.png" alt="image-20220211002424468" style="zoom:67%;" />

​              

​               

### 회원 도메인과 리포지토리 만들기

#### 1. domain 패키지 생성

* main - java - 프로젝트 파일에서 `domain` 패키지를 생성

<img src="spring_manage_customer.assets/image-20220211002653388.png" alt="image-20220211002653388" style="zoom:50%;" />

* 그리고 `Member` 클래스를 생성

  <img src="spring_manage_customer.assets/image-20220211003000455.png" alt="image-20220211003000455" style="zoom:50%;" />

* Member class 를 이용해 회원 정보를 관리하도록 코드 작성

  ```java
  package FirstProject.first.domain;
  
  public class Member {
      private Long id;
      private String name;
  
      public Long getId() {
          return id;
      }
  
      public void setId(Long id) {
          this.id = id;
      }
  
      public String getName() {
          return name;
      }
  
      public void setName(String name) {
          this.name = name;
      }
  }
  ```

  ​                   

#### 2. Repository 생성

* main - java - 프로젝트 파일에서 `repository` 패키지 생성

<img src="spring_manage_customer.assets/image-20220211003329020.png" alt="image-20220211003329020" style="zoom:50%;" />

* `MemberRepository` 이름으로 Interface 객체 생성

  ```java
  package FirstProject.first.repository;
  
  import FirstProject.first.domain.Member;
  
  import java.util.List;
  import java.util.Optional;
  
  public interface MemberRepository {
      Member save(Member member); // 인터페이스이므로 { } 블럭 X
      Optional<Member> findById(Long id); // java 8의 기능
      Optional<Member> findByName(String name); // 찾았을 때 null이면 Option으로 감싸서 반환
      List<Member> findAll();
  }
  ```

     

#### 3. 인터페이스 구현체 만들기

* main - java - `repository` - MemoryMemberRepository 클래스 생성

<img src="spring_manage_customer.assets/image-20220211004252328.png" alt="image-20220211004252328" style="zoom:50%;" />

```java
package FirstProject.first.repository;

public class MemoryMemberRepository implements MemberRepository { //이 상태에서 option + Enter
}
```

​            

* 메서드 구현

```java
package FirstProject.first.repository;

import FirstProject.first.domain.Member;

import java.util.*;

public class MemoryMemberRepository implements MemberRepository {

    private static Map<Long, Member> store = new HashMap<>();
    private static long sequence = 0L; // 실무에서는 동시성 문제로 어텀 롱을 해야함

    @Override
    public Member save(Member member) {
        member.setId(++sequence); // save 할 때마다 squence 증가시킨 후 넣어서 id 저장
        store.put(member.getId(), member);
        return member;
    }

    @Override
    public Optional<Member> findById(Long id) {
        return Optional.ofNullable(store.get(id)); // Optional을 이용하면 null이어도 감쌀 수 있다.
        //return store.get(id); // Map에서 찾아서 반환하는데 없으면 null 이 반환된다.
    }

    @Override
    public Optional<Member> findByName(String name) {
        return store.values().stream()  // values() 를 통해 키의 value 들 순회하면서
                 .filter(member -> member.getName().equals(name)) // 람다식
                    /// 멤버를 넣고 멤버의 이름을 반환해 같은지 확인 (equals 는 true, false)
                 .findAny(); //하나라도 찾는다
    }

    @Override
    public List<Member> findAll() {
        return new ArrayList<>(store.values()); // 실무에서는 ArrayList로 주로 반환
    }
}
```


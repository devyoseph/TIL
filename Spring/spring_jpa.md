# JPA

> JPA = 객체 + ORM 기술 (Object(객체) Relational(테이블) Mapping)
>
> SQL문도 알아서 짜주고 객체 지향도 실현해준다.
>
> JPA는 인터페이스이고 hibernate 같은 구현체를 이용해 사용한다.(보통 hibernate를 많이 사용)
>
> 구현은 보통 업체들이 한다.

* JPA는 기존의 반복 코드는 물론이고 **기본적인 SQL도 JPA가 직접 만들어서 실행**해준다.
* JPA를 사용하면 SQL과 데이터 중심의 설계에서 객체 중심의 설계로 패러다임을 전환할 수 있다.
  * 개발 생산성을 크게 높일 수 있다.

​              

### 설정

* `build.gradle`에서 `dependencies` 에 `jpa`관련 라이브러리 추가

```java
implementation 'org.springframework.boot:spring-boot-starter-data-jpa'
```

* resources - templates - application.properties 에 jpa 관련 설정 추가

```java
spring.datasource.url=jdbc:h2:tcp://localhost/~/test
spring.datasource.driver-class-name=org.h2.Driver
spring.datasource.username=sa

spring.jpa.show-sql=true   // jpa 가 보내는 sql을 볼 수 있도록 해줌
spring.jpa.hibernate.ddl-auto=none // jpa는 테이블을 자동으로 만들어주기 때문에 이를 해제해준다.
  //none이 아닌 create로 두면 만들어준다.
```

​        

​           

## 객체와 테이블 연결(매핑)을 위한 작업

* domain - Member.java 에서 `@Entity`를 추가한다. = JPA가 관리해준다는 뜻
* `@Id` `@GeneratedValue` : PK를 설정해준다 + 값 생성 규칙 설정
* `@Column(변수 = "칼럼명")` : DB의 칼럼값과 현재 변수를 연결

```java
package FirstProject.first.domain;

@Entity
public class Member {
  	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id; // @Id : PK 설정
  
  	@Column(name = "username") //DB의 column명이 `username`인 것과 매칭된다.
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

### 레파지토리 생성

* repository에 `JpaMemberRepository.java` 로 하나 만든다.

```java
package hello.hellospring.repository;
import hello.hellospring.domain.Member;
import javax.persistence.EntityManager;
import java.util.List;
import java.util.Optional;
public class JpaMemberRepository implements MemberRepository {
  
    private final EntityManager em; // JPA는 Entity 매니저로 모든 것이 동작한다.
  	
  	// build.gradle에서 라이브러리를 넣을 때 알아서 생성해주기에 Injection만 해주면 된다.
    public JpaMemberRepository(EntityManager em) {
        this.em = em;
    }
  
  	@Override
    public Member save(Member member) {
        em.persist(member); // persist: 영구저장하다 = DB에 내용을 저장해줌
        return member;
    }
  
    public Optional<Member> findById(Long id) {
        Member member = em.find(Member.class, id); // 조회하는 법 = find 메서드
        return Optional.ofNullable(member); // 값이 없을 수도 있기 때문에 Optional
    }
  
  	//특이하게 쿼리문을 사용: jpql이라는 언어
  	//원래는 DB에게 직접 쿼리문을 날리지만
  	//JPA는 객체를 대상으로 sql문을 날린다.
  	// "select m from Member m" : Member @Entity를 조회하고 m으로 인식해라(AS) -> 그걸 m으로 다시 조회
  	// 객체 자체를 조회할 수 있도록 서비스함  " m from Member m "
    public List<Member> findAll() {
        return em.createQuery("select m from Member m", Member.class)
                .getResultList();
    }
	
  	
    public Optional<Member> findByName(String name) {
				// :name으로 ?를 대신함
      	// 그것을 아래 setParameter에서 다시 잡아줌
        List<Member> result = em.createQuery("select m from Member m where m.name = :name", Member.class)
                .setParameter("name", name)
                .getResultList();
        return result.stream().findAny();
    } }
```

* DB를 사용해야하는 메소드마다 `Transactional` 붙이기

```java
@Transactional //회원가입 메서드는 DB를 사용하므로 현재 클래스나 해당 메서드에 써준다
public class MemberService {

    private final MemberRepository memberRepository;

    public MemberService(MemberRepository memberRepository) {
        this.memberRepository = memberRepository;
    }

    /**
    *  회원 가입
    */
    public Long join(Member member){
    }
```

* SpringConfig에서 리턴값 변경

```java
@Configuration
public class SpringConfig{

//    @Autowired
//    public SpringConfig(DataSource dataSource){
//        this.dataSource = dataSource;
//    }

    private EntityManager em;

    @Autowired
    public SpringConfig(EntityManager em){
        this.em = em;
    }


    @Bean
    public MemberService memberService(){
        return new MemberService(memberRepository());
    }

    @Bean
    public MemberRepository memberRepository(){
        //return new MemoryMemberRepository();
        //return new JdbcTemplateMemberRepository(dataSouce);
        return new JpaMemberRepository(em); //dataSource가 아닌 Entity Manager 사용
    }
}
```




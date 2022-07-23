# JPA

> **Java Persistence API**
> 기존 JDBC → MyBatis, JDBCTemplate 는 SQL문을 하나하나 작성해야하는 문제점이 있었다.
> 하지만 JPA를 사용하면 SQL문을 직접 작성할 필요가 없다.
> **개발 생산성**의 향상

```java
//JPA: SQL문을 대신해서 생성해준다.
public class MemberDAO {
  @PersistenceContext
  EntityManager jpa;
 	
  public void save(Member member){
		jpa.persist(member);
  }
  
  public Member findOne(Long id){
    return jpa.find(Member.class, id);
  }
}
```

​                   

## JPA 실무에서 어려운 이유

> 객체와 테이블 올바르게 **매핑**하고 설계하는 방법을 알아야 한다.

* 처음 JPA나 스프링 데이터 JPA를 만나면?
* SQL 자동화, 수십줄의 코드가 한 두줄로
* 실무에 바로 도입하면?
* 예제들은 보통 테이블이 한 두개로 단순함
* 실무는 수십 개 이상의 복잡한 객체와 테이블 사용

​                    

### 목표 1 - 객체와 테이블 설계 매핑

* 객체와 테이블을 제대로 설계하고 매핑하는 방법
* 기본 키와 외래 키 매핑
* 1:N, N:1, 1:1, N:M 매핑
* 실무 노하우 + 성능까지 고려
* 어떠한 복잡한 시스템도 JPA로 설계 가능

​                   

### 목표 2 - JPA 내부 동작 방식 이해

* JPA의 내부 동작 방식을 이해하지 못하고 사용
* JPA 내부 동작 방식을 그림과 코드로 자세히 설명
* JPA가 어떤 SQL을 만들어 내는지 이해
* JPA가 언제 SQL을 실행하는지 이해

​                        

​                     

## JPA 기본편 학습 방법

* JPA는 표준 스펙만 500 페이지로 방대함
* 혼자서 공부하기 쉽지 않음
* 강의는 이론 + 라이브 코딩
* 6단계의 실전 예제
* 강의를 메인으로 하고, 책은 참고서로 추천
* 총 16시간: 하루 1시간 반, 2주 완성

​                      

​                            

## JPA를 많이 사용하는가?

* 2015년부터 꾸준히 검색량이 증가하고 있다.
* 2~3년 이내에 JPA가 시장을 점유할 가능성이 높다.

​                   

### - JPA 적용 사례

* 우아한형제들, 쿠팡, 카카오, 네이버 등등
* 조 단위의 거래금액이 발생하는 다양한 서비스에서 사용, 검증
* 최신 스프링 예제는 JPA 기본 적용
* 자바 개발자에게 JPA는 기본 기술
* 토비의 스프링 이일민님도 JPA는 기본 적용

​                      

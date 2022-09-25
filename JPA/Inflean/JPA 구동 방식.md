# JPA 구동 방식

* `Maven`은 Persistence의 이름을 따로 로드해야하지만 `Gradle` 은 사전세팅없이 상속만 받으면 된다.  

![image-20220925180525134](JPA 구동 방식.assets/image-20220925180525134.png)

* `Persistence` 에서 설정 정보를 받아옴
* EntityManagerFactory에서 EntityManager를 찍어냄

​                

## 1. 객체와 테이블을 생성하고 매핑하기

* `@Entity` : JPA가 관리할 객체
* `@Id` : 데이터베이스 PK와 매핑

​                

### - INSERT

```java
// lombok을 활용한 객체 생성
private final EntityManager em;
Member member = new Member();
member.setId(1L);
member.setName("HelloA");
em.persist(member);
```

### - SELECT

```java
Member findMember = em.find(Member.class, 1L);
```

* 조건 검색 (JPQL)

  * 나이가 18세 이상인 회원을 모두 검색하고 싶다면?

    ```java
    em.createQuery("select m from Member as m where m.age >= 18", Member.class)
    ```

  * 가져올 때 `Member` 객체를 가져오고 `m`으로 별명을 짓는다.

  ```java
  List<Member> findMembers = em.createQuery("select m from Member as m", Member.class)
    
    // PageNation : 1~10번 가져오기
    .setFirstResult(1)
    .setMaxResult(10)
  	
    //
    
    .getResultList();
  ```

#### JPQL

* 검색 조건이 포함된 SQL이 필요하므로 JPQL이 생겨나게 되었다.

​               

### - UPDATE

* SELECT문으로 불러오면 JPA 객체가 매핑해주어 이후에 UPDATE를 해도 Transaction으로 변경 후 변경을 저장해줌

```java
Member findMember = em.find(Member.class, 1L);
findMember.setName("HelloJPA");
```

​                

## 주의

* 엔티티 매니저 팩토리는 하나만 생성해서 어플리케이션 전체 공유
* 엔티티 매니저는 쓰레드간 공유X => 사용하고 버려야 한다.
* JPA 모든 데이터 변경은 트랜잭션 안에서 실행

​               

​                

# 영속성 컨텍스트

![image-20220925201157573](JPA 구동 방식.assets/image-20220925201157573.png)

* JPA를 이해하는데 가장 중요한 언어
* `엔티티를 영구 저장하는 환경` : DB가 아닌 Context에 저장한다.

```java
EntityManager.persist(entity);
```

* 영속성 컨텍스트는 논리적인 개념
* 눈에 보이지 않는다.
* 엔티티 매니저를 통해 영속성 컨텍스트 접근

​               

### 1:1 매핑 / N:1 매핑

* JS2E : 엔티티 매니저와 영속성 컨텍스트가 1:1 매핑
* J2EE : 엔티티 매니저와 영속성 컨텍스트가 N:1

​             

## 엔티티의 생명주기

* Context와 같이 매핑 개념이 존재하기 때문에 생명주기도 존재한다.
* 영속과 연관있는지 없는지에 따라 달라진다.
  * 비영속: `Member member = new Member();`
  * 영속: `em.persist(member);` : 영속 엔티티에 등록된 시점이 아닌 `tx.commit` 시점에서 DB에 반영됨 

![image-20220925201355959](JPA 구동 방식.assets/image-20220925201355959.png)

​               

### - 영속성 컨텍스트의 이점

* 1차 캐시 : 중간에서 **캐싱**
* 동일성(identity) 보장 : `transaction 로드`를 중심으로
  * 트랜잭션 격리 수준을 어플리케이션 수준에서 제공
* `UPDATE` : 따로 쓰지 않는 이유는 영속성 컨텍스트에 매핑된 정보를 `flush()`를 통해 비교하고 `tx.commit()` 시점에서 바꿔주기 떄문이다.

​          

### - 플러시

* 영속성 컨텍스트 변경내용을 데이터베이스에 반영
  * 하지만 영속성 컨텍스트를 비우는 것은 아니다
* 변경 감지
* 수정된 엔티티 쓰기  지연 SQL 저장소에 등록
* 쓰기 지연 SQL ㅓ장소의 쿼리를 데이터베이스에 전송(등록, 수정, 삭제 쿼리)

* **방법**
  * `em.flush()` : 직접 호출
  * 트랜잭션 커밋 : 플러시 자동 호출
  * JPQL 쿼리 실행 : 플러시 자동 호출
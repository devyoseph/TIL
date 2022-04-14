# Spring

​         

## 등장배경

> **EJB**: Interface2 개를 만들면 반드시 클래스를 만들고 2개의 XML을 만든다음 jar로 만들어야 한다. 이것은 필수과정이며 다른 작업까지 수행했을 때 번거롭다는 단점이 있다.

* EJB를 사용하면 어플리케이션 작성을 쉽게 할 수 있다.
  * 코드 수정 후 반영하는 과정 자체가 거창해 기능은 좋지만 복잡한 스펙으로 인한 개발 효율성은 떨어진다.
  * 어플리케이션 테스트를 위해 반드시 EJB 서버가 필요하다.
* Low Level의 트랜잭션이나 상태관리, 멀티 쓰레딩, 리소스 풀링과 같은 복잡한 Low Level의 API를 이해하지 못해도 어플리케이션을 개발할 수 있다.
* 웹사이트가 점점 커지면서 엔터프라이즈급 서비스가 필요하게 됨.
  * 세션빈에서 Transaction 관리가 용이함
  * 로그인, 분산처리, 보안 등
* 자바진영에서는 EJB가 엔터프라이즈급 서비스로 각광 받게 됨.
  * EJB스펙에 정의된 인터페이스에 따라 코드를 작성함으로 기존에 작성된 POJO를 변경해야함
  * 컨테이너에 배포를 해야 테스트가 가능해 개발속도가 저하됨
  * 배우기 어렵고 설정해야할 부분이 많음
  * EJB는 RMI를 기반의 서버이므로 무거운 Container이다.
* Rod Johnson이 'Expert One-on-One J2EE Development without EJB'라는 저서에서 EJB를 사용하지 않고 엔터프라이즈급 어플리케이션을 개발하는 방법을 소개함(스프링의 모태)
  * AOP나 DI 같은 새로운 프로그래밍 방법론 가능
  * POJO로 전언적인 프로그래밍 모델이 가능해짐
* 점차 POJO + 경량 프레임워크를 사용하기 시작
* POJO(Plain Old Java Object)
  * 특정 프레임워크나 기술에 의존적이지 않은 자바 객체
  * 특정 기술에 종속적이지 않기 때문에 생산성, 이식성 향상
  * Plain: component interface를 상속받지 않는 특징
    * "특정 framework에 종속되지 않는"
  * Old: EJB 이전의 java class
* 경량 프레임워크
  * EJB가 제공하는 서비스를 지원해 줄 수 있는 프레임워크 등장
  * Hibernate, JDO, iBatis(MyBatis), Spring
* POJO + Framework
  * EJB서버와 같은 거창한 컨테이너가 필요없다.
  * 오픈소스 프레임워크라 사용이 무료
  * 각종 기업용 어플리케이션 개발에 필요한 상당히 많은 라이브러리 지원
  * 스프링 프레임워크는 모든 플랫폼에서 사용이 가능하다.
  * 스프링은 웹 분야 뿐만 아니라 어플리케이션 등 모든 분야에 적용이 가능한 다양한 라이브러리를 가지고 있다.

​                

## Spring Framework

* 엔터프라이즈급 어플리케이션을 만들기 위한 모든 기능을 종합적으로 제공하는 경량화된 솔루션
* JEE(Java Enterprise Edition)가 제공하는 다수의 기능을 지원하고 있기 때문에 JEE를 대체하는 Framework로 자리잡고 있다.
* SpringFramework는 JEE가 제공하는 다양한 기능을 제공하는 것 뿐만 아니라, DI(Dependency Injection)나 AOP(Aspect Oriented Programming)와 같은 기능도 지원한다.
* Spring Framework는 자바로 Enterprise Application을 만들 때 포괄적으로 사용하는 Programming 및 Configuration Model을 제공해주는 Framework로 Application 수준의 infra structure를 제공
* 개발자가 복잡하고 실수하기 쉬운 Low Level에 신경 쓰지 않고 Bussiness Logic개발에 전념할 수 있도록 해준다.

​            

​               

## SpringFramework의 구조

​            

### Spring 삼각형

<img src="1_Spring&개발환경.assets/image-20220414094554236.png" alt="image-20220414094554236" style="zoom:80%;" />

* Enterprise Application 개발 시 복잡함을 해결하는 Spring의 핵심
  1. POJO: Plain Old Java Object
     * 특정 환경이나 기술에 종속적이지 않은 객체지향 원리에 충실한 자바객체
     * 테스트하기 용이하며 객체지향 설계를 자유롭게 적용할 수 있다.
  2. PSA: Portable Service Abstraction
     * 환경과 세부기술의 변경과 관계없이 일관된 방식으로 기술에 접근할 수 있게 해주는 설계 원칙
     * 트랜잭션 추상화, OXM 추상화, 데이터 액세스의 Exception 변환기능 등 기술적인 복잡함은 추상화를 통해 Low Level의 기술 구현 부분과 기술을 사용하는 인터페이스로 분리
     * 예를 들어 데이터베이스 관계없이 동일하게 적용할 수 있는 트랜잭션 방식
  3. ioC/DI: Dependency Injection
     * DI는 유연하게 확장 가능한 객체를 만들어두고 객체 간의 의존관계는 외부에서 다이나믹하게 설정
  4. AOP: Aspect Oriented Programming
     * 관심사의 분리를 통해서 소프트웨어의 모듈성을 향상
     * 공통 모듈을 여러 코드에 쉽게 적용가능

​             

### SpringFramework의 특징

* 경량컨테이너
  * 스프링은 자바객체를 담고 있는 컨테이너이다.
  * 스프링 컨테이너는 이들 자바 객체의 생성과 소멸과 같은 라이프사이클을 관리
  * 언제든지 스프링 컨테이너로부터 필요한 객체를 가져와 사용할 수 있다.
* DI(Dependency Injection - 의존성 지원) 패턴 지원
  * 스프링은 설정 파일이나, 어노테이션을 통해서 객체 간의 의존관계를 설정할 수 있다.
  * 따라서, 객체는 의존하고 있는 객체를 직접 생성하거나 검색할 필요가 없다.
* AOP(Aspect Oriented Programming - 관점 지향 프로그래밍) 지원
  * AOP는 문제를 바라보는 관점을 기준으로 프로그래밍하는 기법이다.
  * 이는 문제를 해결하기 위한 핵심관심 사항과 전체에 적용되는 공통관심 사항을 기준으로 프로그맹함으로 공통 모듈을 여러 코드에 적용할 수 있도록한다.
  * 스프링은 자체적으로 프록시 기반의 AOP를 지원하므로 트랜잭션이나, 로깅, 보안과 같이 여러 모듈에서 공통으로 필요로 하지만 실제 모듈의 핵심이 아닌 기능들을 분리하여 각 묘듈에 적용이 가능하다.
* POJO(Plain Old Java Object) 지원
  * 특정 인터페이스를 구현하거나 또는 클래스를 상속하지 않는 일반 자바 객체 지원
  * 스프링 컨테이너에 저장되는 자바객체는 특정한 인터페이스를 구현하거나 클래스 상속 없이도 사용이 가능하다.
  * 일반적인 자바 객체를 칭하기 위한 별칭 개념이다.
* ioC(Inversion of Control - 제어의 반전)
  * IoC는 스프링이 갖고 있는 핵심적인 기능이다.
  * 자바의 객체 생성 및 의존관계에 있어 모든 제어권은 개발자에게 있었다.
  * Servlet과 EJB가 나타나면서 기존의 제어권이 Servlet Container 및 EJB Container에게 넘어가게 됐다.
  * 단, 모든 객체의 제어권이 넘어간 것은 아니고 Servlet, EJB에 대한 제어권을 제외한 나머지 객체 제어권은 개발자들이 담당하고 있다.
  * 스프링에서도 객체에 대한 생성과 생명주기를 관리할 수 있는 기능을 제공하고 있는데 이런 이유로 Spring Container 또는 IoC Container라고 부르기도 한다.
* 스프링은 트랜잭션 처리를 위한 일관된 방법을 제공
  * JDBC, JTA 또는 컨테이너가 제공하는 트랜잭션을 사용하든, 설정파일을 통해 트랜잭션 관련정보를 입력하기 때문에 트랜잭션 구현에 상관없이 동일한 코드를 여러 환경에서 사용이 가능하다.
* 스프링은 영속성과 관련된 다양한 API를 지원
  * 스프링은 JDBC를 비롯하여 iBatis, MyBatis, Hibernate, JPA등 DB 처리를 위해 널리 사용되는 라이브러리와 연동을 지원하고 있다.
* 스프링은 다양한 API에 대한 연동을 지원
  * 스프링은 JMS, 메일, 스케쥴링 등 엔터프라이즈 어플리케이션 개발에 필요한 다양한 API를 설정파일과 어노테이션을 통해 손쉽게 사용할 수 있도록 지원하고 있다.

​         

### SpringFramework Module

<img src="1_Spring&개발환경.assets/image-20220414100755395.png" alt="image-20220414100755395" style="zoom:80%;" />
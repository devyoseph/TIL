# 다형성

* Polymorphism: 하나의 객체가 많은 형(Type)을 가질 수 있는 성질
* 다형성의 정의: 상속 관계에 있을 때 조상 클래스의 타입으로 자식 클래스 객체를 참조할 수 있다.

> Venom → SpiderMan → Person → Object

```java
SpiderMan onlyOne = new SpiderMan();
```

* SpiderMan 타입으로 onlyOne을 참조할 수 있는가? = YES

  ```java
  SpiderMan sman = onlyOne;
  ```

* Person 타입으로 onlyOne을 참조할 수 있는가? = YES

  ```java
  Person person = onlyOne
  ```

* Object 타입으로 onlyOne을 참조할 수 있는가? = YES

  ```java
  Object obj = onlyOne
  ```

* onlyOne은 Venom 타입인가?

  ```java
  Venom venom = onlyOne
  ```

  ​	

​		

### JAVA: 다형성 vs 형 변환

​		

#### \- 형 변환

```java
int a = 3;
double b = a; // 큰 데이터 타입 = 작은 데이터 타입
```

​		

#### \- 다형성

#### <묵시적 케스팅>

```java
Person person = Man man; // 부모 객체(작은 데이터 타입) = 자식 객체(큰 데이터 타입)
// 상속 관계의 우위에 있는 클래스를 더 큰 데이터 타입으로 인식한다
```

* 제한: 메모리에 존재하지만 자식 클래스에만 있는 정보를 부모 클래스 객체로 저장하면 추가적인 내용은 **접근할 수 없다**.

* 활용: Object 객체로 배열을 생성하면 모든 객체를 집어넣어 관리할 수 있음

  ```java
  Object[] objs = new Object[5];
  objs[0] = onlyOne;
  ```

* Object 객체 배열 안에 기본형을 집어넣을 수 있는가?

  \- 원칙적으로 안되지만 **Auto Boxing**을 통해 Wrapper Class 로 감싼 다음 집어넣는다.

  ```java
  objs[4] = 3 //Integer로 감싸서 들어간다
  ```

* 활용2: 메소드를 정의할 때 **Object로 파라미터를 받아주면 모든 객체**를 받을 수 있게 된다.

  ​	\- 예) println 함수

​			

#### <명시적 케스팅>

```java
Phone phone = new SmartPhone();
SmartPhone sPhone = (SmartPhone)phone //데이터가 잘릴 수도 있음
```

* 조상 타입을 자손 타입으로 참조: 형변환 생략 불가

* **응용**: 원래 복잡한 클래스인데 Object 클래스로 저장해놨다가 다시 꺼낼 때 명시적 형 변환을 통해 재사용할 수 있다.

  ​	\- 즉 객체들의 관리가 용이해진다.

  * 문제점:

    * 위와 같은 경우가 아니라 그냥 자식 클래스에 부모클래스를 참조하는 식으로하면 데이터가 없는 상태로 인스턴스가 생성

    * 해결: instanceof 연산자 사용

      ```java
      //실제 메모리가 있는 객체가 특정 클래스 타입인지 boolean으로 리턴
      if (person instanceof SpiderMan){
      	SpiderMan sman = (SpiderMan) person;
      }
      ```

​		

​		

### 참조 변수의 레벨에 따른 객체의 멤버 연결

* 동적 바인딩: 변수의 경우 부모 클래스의 값을 유지한채, 기능적으로는 Override한 자식의 메서드를 실행한다.

```java
class SuperClass{
	String x = "super";
	
	public void method() {
		System.out.println("super class method");
	}
}
class SubClass extends SuperClass{
	String x = "sub";
	
	@Override
	public void method() {
		System.out.println("sub class method");
	}
}
public class Main {
	public static void main(String[] args) {
		SubClass subClass = new SubClass();
		subClass.method(); // sub class method
		SuperClass superClass = subClass; 
		System.out.println(superClass.x); // super: 변수는 덮어지지 않음
		superClass.method(); // sub class method
    /* 부모 클래스의 메서드가 자식 메서드 안에서 Override 됐다면
       부모 메서드를 실행해도 자식 메서드가 실행된다. = 최적의 기능을 사용
       관리는 편리하게 기능은 원하는대로 */
}}
```

* 이를 응용한 예: toString()을 Override 해서 자식에서 재정의한 예

  \- **만약 위와 같이 기능처럼 Override를 따라가 실행하지 않으면?**

  * 자식 데이터를 저장하고 있는 부모 인스턴스에서 toString을 실행할 경우 평생 "이름+hashCode"값만 받는다.

​		

​			

#### 용도에 따른 가장 적합한 메서드 구성은?

```java
class A{
	public void useJump(Object obj) { //모든 타입을 받아줄 수 있지만 조건문을 사용
		if(obj instanceof Person) {
			Person casted = (Person) obj;
			casted.jump();
		}
	}
	public void useJump2(Person person) { //
		person.jump();
	}
}
```

* 상위로 올라갈수록 활용도도 높아지지만 **코드의 복잡성도 증가**
* Java API처럼 공통 기능인 경우 Object를 파라미터로 쓴다
* 실무에서는 **비즈니스 로직 상 최상위 객체 사용 권장**


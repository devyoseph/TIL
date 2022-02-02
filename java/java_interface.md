# Interface

> Interface는 다형성을 좀 더 확장해주는 개념이다. 상속 수준에서도 다형성을 논할 수 있음에 주의한다.

### 인터페이스란?

> 서로 다른 두 시스템 장치, 소프트웨어 따위를 서로 이어 주는 부분, 또는 그런 접속 장치

* GUI - Graphic User Interface
  * 프로그램과 사용자 사이의 접점

​		    

### 인터페이스 작성

* 최고 수준의 추상화 단계: **모든 메서드**가 abstract 형태 = **interface**

  * JDK 8에서 ```default```와 `static` method 추가

* 형태

  * 클래스와 유사하게 interface 선언
  * 멤버 구성
    * 모든 멤버변수는 `public static final`이며 생략 가능
    * 모든 메서드는 `public abstract`이며 생략 가능

  ```java
  public interface MyInterface{
  	public static final int MEMBER1 = 10; // interface로 선언한 이상 기본 형식
  	int MEMBER2 = 10; // 이처럼 생략 가능
    
    public abstract void method1(int param);
    void method2(int param); // 앞에 생략되어있다고 해서 default가 아니다
    // interface에서는 public static이 생략되었기 때문에 public으로만 받아줄 수 있다.
  }
  ```

​		    

### 인터페이스 상속

* 클래스와 마찬가지로 인터페이스는 **extends**를 이용해 상속이 가능
* 클래스와 달리 **다중 상속**이 가능
* **일반 상속**과 달리 **구현**부분이 없기 때문에 저장된 메서드나 값이 겹칠 수 없다.
* **일반 상속**처럼 메서드를 Override해서 재정의할 필요없다

```java
interface Fightable{
	int fire();
}

interface Transformable{
	void changeShape(boolean isHeroMode);
}

public interface Heroable extends Fightable, Transformable{
	void upgrade();
}
```

​		    

### 인터페이스 구현과 객체 참조

* **implements** 키워드를 이용해 Interface 구현

* implements 한 클래스:

  * 모든 abstract 메서드를 override해서 구현
  * 구현하지 않는 경우 abstract 클래스로 표시

* 여러 개의 interface를 implements 가능

  ```java
  public class IronMan implements Heroable{
  	int weaponDamage = 100;
  	@Override
  	public int fire(){
  		System.out.printf("빔 발사: %d만큼의 데미지를 가함%n");
  		return this.weaponDamage;
  	}
  	
    @Override
  	public void chageShape(boolean isHeroMode){
  		String status = isHeroMode?"장착":"제거";
  		System.out.printf("장갑 %s%n", status);
  	}
    
    @Override
    public void upgrade(){
  		System.out.printf("무기 성능 개선");
    }
  }
  ```

  ​		     

* #### 다형성

  * 다형성은 조상 클래스 뿐 아니라 조상 인터페이스에도 적용

    ```java
    IronMan iman = new IronMan();
    Object obj = iman;
    Heroable hero = iman;
    Fightable fight = iman;
    Transformable trans = iman;
    ```

​		    

### 인터페이스의 필요성

* 구현의 **강제**로 **표준화** 처리

  * abstract 메서드 사용
  * Ex) JDBC 의 인터페이스 구현으로 DBMS들과의 손쉬운 연결

* 인터페이스를 통한 간접적인 클래스 사용 = 손쉬운 모듈 교체 지원

  ```java
  //보통 위에서 아래로의 구현을 생각하지만 인터페이스는 아래에서 위로도 구현된다
  //공통적인 부분만 따로 묶어 인터페이스로 구현한 뒤, 그 인터페이스로 묶어서 관리한다
  void goodCase(){
  	Chargeable[] objs = {
  											new HandPhone(),
  											new DigitalCamera()
  											};
  	for(Chargeable obj: objs){
  		obj.charge(); // Object라는 너무 큰 틀로 묶지 않고
  									// charge() 처럼 겹치는 메소드만으로 interface로 구현
  	}
  }
  ```

* 서로 상속의 관계가 없는 클래스들에게 **인터페이스를 통한 관계 부여**로 **다형성 확장**

  ```java
  public class DigitalCamera extends Camera implements Chargeable{
  }
  ```

* 모듈 간 독립적 프로그래밍 가능 = 개발 기간 단축

> 계산기를 구현할 때
>
> A 팀 - 클라이언트를 위한 UI
>
> B 팀 - 계산 로직의 구현
>
> 구현 내용을 협의하고 인터페이스로 구체화해서 개발 착수

​		    

#### default method

* 인터페이스에 선언된 구현부가 있는 일반 메서드

  * 메서드 선언부에 default modifier 추가 후 메서드 구현부 작성

    * 접근 제한자는 public으로 한정됨(생략 가능): **default로 구현했지만 public으로 아래에서 받아줘야한다.**

      ```java
      interface DefaultMethodInterface{
      	void abstractMethod();
      	
      	default void defaultMethod(){
      		System.out.println("이것은 기본 메서드입니다.");
      	}
      }
      ```

​		    

#### Static method

* Interface 내부에 static method 선언 가능

* 일반 static 메서드와 마찬가지로 별도의 객체 필요 없음

* 구현체 클래스 없이 바로 **인터페이스 이름으로 메서드에 접근해서 사용 가능**

  ```java
  interface StaticMethodInterface{
  	static void staticMethod(){
  		System.out.println("Static 메서드")
  	}
  }
  
  public class StaticMethodTest {
  	public static void main(String[] args) {
  		StaticMethodInterface.staticMethod();	
  	}
  }
  ```

  ​		      

* 필요성

  * 기존 interface 기반으로 동작하는 라이브러리의 필요한 부분만 구현하도록 설계

  * **default 메서드는 abstract가 아니므로 반드시 구현해야할 필요가 없어짐**

    * default method의 충돌

      * method의 우선순위

        * super class의 메서드 우선: super class가 구체적인 메서드를 가지는 경우 default 메서드는 무시

        * Interface 간의 충돌: 하나의 interface에서 default 메서드를 제공하고 다른 interface도 같은 이름의 메서드를 가지고 있을 때(**다중 상속의 문제점**) sub class는 반드시 override를 통해 충돌을 해결한다.

          ​			   

* 결론: 인터페이스는 "괴물"이다

  * 추상 메소드로 묶고 싶을 때 묶어버리고
  * 개발할 때 설계의 틀도 잡아주고
  * default를 이용해 공통적인 부분을 구현해준다.(**구현부분**)
  * static 메서드를 활용해 인터페이스 이름으로 접근해서 바로 사용 가능

  
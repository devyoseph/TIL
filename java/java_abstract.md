# Interface, Generic

* Abstract class
* Interface
* Generic

​		      				

## 추상 클래스

* 상속: 클래스들 간 중복되는 변수와 메소드가 존재할 때 **상속**을 사용했다

  * 하지만 **상속 후 Override 시 부모 클래스의 필요한 부분까지도 동적바인딩에 의해 사용할 수 없는 경우가 발생**

    ​		      

* #### 추상 클래스의 정의

  * 자손 클래스에서 **반드시** 정의해서 사용해야할 메서드들이 존재한다.

    > Ex) Vihecle의 addFuel 메서드: 모든 차는 연료를 충전해야하지만 그 종류가 다르다

  ```java
  abstract class Vehicle{
  	public abstract void addFuel(); // {중괄호}가 없다
  }
  ```

  ​     			

* ### 추상 클래스의 특징

  *  abstract 클래스는 상속 전용의 클래스

    ```java
    public abstract void addFuel();
    ```

    ​		    

    * 클래스에 구현부가 없는 메서드가 있으므로 **객체 생성 불가**

      ```java
      Vehicle v = new Vehicle(); // 생성 불가
      ```

    * 하지만 **상위 클래스 타입으로써 자식을 참조**할 수 있다.

      ```java
      Vehiclev = new DieselSUV();
      ```

    * 조상 클래스에서 상속 받은 **abstract 메서드는 반드시 재정의** 되어야 한다.

      ```java
      @Override
      public void addFuel(){
      	System.out.println("주유!");
      }
      ```

* ### 추상 클래스를 사용하는 이유

  * abstract 클래스는 **구현의 강제**를 통해 **프로그램의 안정성 향상**
    * 구현을 하지 않으면 컴파일 에러 발생
  * interface에 있는 메서드 중 구현할 수 있는 메서드를 구현해 **개발의 편의** 지원
# 상속과 다형성

​		

## 상속(Inheritance)

* 부모 클래스의 자산을 물려받아 자식을 정의함으로 코드의 재사용이 가능하다.

* 상속의 관계 = is a 관계 / 포함의 관계 = has a 관계

  | 부모 클래스 | 자식 클래스 |
  | ----------- | ----------- |
  | 조상 클래스 | 자손 클래스 |
  | 상위 클래스 | 하위 클래스 |
  | 슈퍼 클래스 | 서브 클래스 |

* 2개 이상의 클래스의 특성을 가져올 때: 하나는 상속 나머지는 멤버 변수로 처리

​		

## [WITH PYTHON]

| JAVA                                                   | PYTHON                                                    |
| ------------------------------------------------------ | --------------------------------------------------------- |
| ```class Child extends Parent(){ }```: extends 활용    | ```def child(parent):     pass```: 파라미터에 클래스 입력 |
| extends Object가 생략되어 있음(Object 메소드 사용가능) | 다중 상속이 가능                                          |
| 단일 상속만 가능: interface와 포함관계(has a)로 극복   | 변수나 메소드가 겹칠 때 먼저 상속한 객체로 사용           |
| hashCode( ), equals( ), toString( )                    |                                                           |

​					

## 메서드 재정의

### 메서드 오버라이딩(overriding)

* 조상 클래스에 정의된 메서드를 자식 클래스에서 적합하게 수정하는 것

​			

#### **오버라이딩의 조건**

1. 메서드의 이름이 같아야 한다.
2. 매개 변수의 개수, 타입, 순서가 같아야 한다.
3. 리턴 타입이 같아야 한다.
4. 접근 제한자는 부모보다 범위가 넓거나 같아야 한다.
5. 조상보다 더 큰 예외를 던질 수 없다.

​						

오버로딩이 가지는 차이점: 메서드의 이름이 같아야 한다, 리턴값은 상관없다, 매개변수 타입이나 순서가 모두 같으면 안된다.

​		

#### Annotation: 주석

* 컴파일러, JVM, 프레임워크 등이 보는 주석
* 소스코드에 메타 데이터를 삽입하는 형태
  * 코드에 대한 정보 추가 = 소스 코드의 구조 변경, 환경 설정 정보 추가 등의 작업 진행

| ANNOTATION        | 설명                                                         |
| ----------------- | ------------------------------------------------------------ |
| ```@Deprecated``` | 컴파일러에게 해당 메서드가 Deprecated 되었음을 알림(더 이상 지원하지 않는 버전의 클래스) |
| @Override         | 컴파일러에게 해당 메서드는 Override했음을 알림, 반드시 super class에 선언되어있어야 함 |
| @SuppressWarnings | 컴파일러에게 사소한 warning의 경우 신경 쓰지 말라고 알려줌   |

​		

### Object 클래스

* 가장 최상위 클래스로 모든 클래스의 조상
  * Object의 멤버는 모든 클래스의 멤버
* 대표적인 메서드: toString(), equals(), hashCode(), getClass()...

​		

* toStirng Override: to 만 치고 자동완성

  ```java
  	public String toString() {
  		// TODO Auto-generated method stub
  		return "오우버롸아이드";
  	}
  ```

* equals() 메서드: 주소값 비교(Stirng에서는 값비교까지 가능)

  ```java
  public boolean equals(Object obj){
  	return (this == obj); // this 는 객체 자신을 의미(주소값)
  }
  ```

* equals() 메서드 재정의: 두 객체의 내용을 비교할 수 있도록 재정의해서 사용

  ```java
  	public boolean equals(Object obj) {
  		// TODO Auto-generated method stub
  		return super.equals(obj);
  	}
  ```

* hashCode(): 시스템에서 객체를 구별하기 위해 사용되는 정수 값

  * equals를 재정의할 때 반드시 hashCode()도 재정의할 것

​		

### super 키워드

* this를 통해서 멤버에 접근했듯이 super()를 통해 부모 클래스 멤버에 접근

* super(): 조상 클래스의 생성자 호출(초기화가 이루어지므로 재활용)

* 결국 모든 클래스는 숨겨져 있는 super( )에 의해 맨 상단 Object 클래스의 생성자를 호출하게 된다.

* super(): 자식 클래스 생성자의 **첫째줄에서만 호출 가능**

  > super() 와 this() 모두 첫번째 줄에만 사용할 수 있으므로 같이 쓸 수 없다.
  >
  > 명시적으로 this() 또는 super()를 호출하지 않는 경우 컴파일러가 super() 삽입
  >
  > ```java
  > class Parent{ //extends Object가 숨어있다
  > 	String name;
  > 	
  >   //생성자를 만들지 않은 경우 아래 내용이 기본 설정이다
  > 	public Parent(String name){
  > 		super(); // Object의 기본 생성자 호출
  > 		this.name = name;
  > 	}
  > }
  > //하지만 파라미터가 있으므로 이 내용을 상속받는 클래스에 생성자를 만들어주지 않으면
  > // 매개변수가 없는 생성자를 기본 생성하고 super()로 가져오기 때문에 오류가 발생한다
  > //그래서 자식 메소드에 매개변수를 넣어준 생성자를 정의해주어야 한다
  > ```
  >
  > ​		

  ```java
  class Person{
  	void jump(){
  		System.out.println("점핑머신");
  	}
  }
  class walk extends Person{
  	int a = 5;
  	
  	void jump2() {
  		super.jump();
  	}
  }
  ```

* super() 사용할 때 상속이 단계 단계 있다면 어느 클래스 멤버로 가는가?

  ​		\- 한 단계씩 상위 클래스로 올라가면서 찾고 있으면 반환합니다.

  ```java
  class Parent{
  	String x = "parent";
  }
  class Child extends Parent{
  	String x = "child";
  	
  	void method() {
  		String x = "method";
  		System.out.println(x); //method
  		System.out.println(this.x); //child
  		System.out.println(super.x); //parent
  	}
  }	
  ```

​	

​	

### Package & Import

#### [package]

* PC의 많은 파일 관리 →  폴더 이용

  * 유사한 목적의 파일을 기준으로 작성
  * 이름은 의미 있는 이름으로, 계층적 접근
  * 물리적으로 패키지는 클래스 파일을 담고 있는 디렉토리

* package 선언

  ```java
  package package_name;
  ```

   \- 주석, 공백을 제외한 첫 번째 문장에 하나의 패키지만 선언

   \- 모든 클래스는 반드시 하나의 패키지에 속한다.

  		* 생략 시 default package
  		* default package는 사용하지 않는다. 

* Package Naming Rule
  * 소속.프로젝트.용도
  * com.회사명.Project.용도, com.회사.hrm.service, ...

​		

#### [import]

* 다른 패키지에 선언된 클래스를 사용하기 위한 키워드

  * 패키지와 클래스 선언 사이에 위치

  * 패키지와 달리 여러 번 선언 가능

    ```java
    import java.io.InputStream;
    import java.util.*;
    ```

  * 선언 방법

    ```java
    import 패키지명.클래스명;
    import 패키지명.*;
    ```

  * 명확히 구분해야할 때

    ```java
    java.util.List List = new java.util.ArrayList();
    ```

  * 디폴트 패키지

    ```java
    java.lang.*;
    ```

    *ctrl + shift + o: import시 사용

​			

​		

### 접근 제한자 및 데이터 은닉과 보호

#### 제한자(modifier)

* 클래스, 변수 , 메서드 선언부에 함께 사용되어 부가적인 의미 부여
* 종류: public, protected, default = package, private
* 그 외 제한자: final, static, abstract, synchronized(멀티스레드에서의 동기화 처리)
* 하나의 대상에 여러 제한자를 조합 가능하나 접근 제한자는 하나만 사용 가능
* 순서는 무관

​		

#### final

* 마지막, 더 이상 바뀔 수 없음

* 용도: 클래스, 메소드, 변수

  ```java
  final class 클래스명{} //더 이상 확장할 수 없음: 상속X, 오버라이드 방지
  //이미 완벽한 클래스들: String, Math
  ```

  ```java
  final void method{} //더 이상 재정의할 수 없음: overriding 금지
  ```

  ```javascript
  final variable; //더 이상 값을 바꿀 수 없음 = 상수화
  ```

​		

#### 접근 제한자(Access modifier)

* 멤버 등에 사용되며 해당 요소를 외부에서 사용할 수 있는지 설정

| 제한자           | 용도               | 접근 가능 범위                                |
| ---------------- | ------------------ | --------------------------------------------- |
| public           | 클래스/생성자/멤버 | 같은 클래스/같은 패키지/다른 패키지 자식/전체 |
| protected        | 생성자/멤버        | 같은 클래스/같은 패키지/다른 패키지 자식      |
| package(default) | 클래스/생성자/멤버 | 같은 클래스/같은 패키지                       |
| private          | 생성자/멤버        | 같은 클래스                                   |

* **메소드 Override 조건의 확인**

  * 부모의 제한자 범위와 같거나 넓은 범위로만 사용 가능

    > 부모의 메소드가 protected 인데 default인 method는 Override할 수 없다.

​	

### Encapsulation: 데이터 은닉과 보호

* 정보 보호: 외부에서 변수에 직접 접근하지 못하도록 함

* 대책

  1. 공개되는 메서드를 통해 접근 통로를 마련: getter/setter

     ```java
     public getName(){
     	return this.name;
     }
     ```

     ```java
     public void setName(String name){
     	if (name != null){ //조건을 걸어주어 이상한 값이 들어가지 않도록 하기
     		this.name = name;
     	}
     }
     ```

  2. private 사용

​		

#### 객체의 생성 제어와 Singleton 디자인 패턴

* 객체의 생성을 제한해야 한다면?
  * 여러 개의 객체가 필요 없는 경우
    * 객체를 구별할 필요가 없는 경우 = 수정 가능한 멤버 변수가 없고 기능만 있는 경우
    * 이런 객체를 stateless한 객체라고 한다
  * 객체를 계속 생성/삭제 하는데 많은 비용이 들어서 재사용이 유리한 경우

​		

* **Singleton 디자인 패턴**

  ```java
  class SingleMethod{
  	
  	public static SingleMethod sm = new SingleMethod(); // 내부에서 생성해버리기 + static으로 외부 접근 허용
  
  	private SingleMethod() { } //생성자를 private로 지정해 인스턴스 생성을 막기
  
  	public static SingleMethod getAccess() { //static으로 생성한 인스턴스를 반환하도록 함
  		return sm;
  	}
  	
  	void access() {
  		System.out.println("접근");
  	}
  }
  
  public class Main {
  	public static void main(String[] args) {
  		// SingleMethod sm = new SingleMethod(); 생성 불가
  		SingleMethod sm1 = SingleMethod.getAccess(); //static한 메소드에 접근해 가져온 내부 인스턴스
  		sm1.access();
  }}
  ```

  ​		

  * 외부에서 생성자에 접근 금지 = **생성자의 접근 제한자를 private으로 설정**
  * 내부에서는 private에 접근 가능하므로 직접 객체를 생성 = 멤버 변수이므로 private 설정
  * 외부에서 private member에 접근 가능한 getter 생성 = setter는 불필요
  * 객체 없이 외부에서 접근할 수 있도록 getter와 변수에 static 추가
  * 외부에서는 언제나 getter를 통해서 객체를 참조하므로 하나의 객체를 재사용할 수 있다.

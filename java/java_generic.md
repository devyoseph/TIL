# Generic

> 어떤 타입이든 담을 수 있는 박스

* 다양한 타입의 객체를 다루는 메서드, 컬렉션 클래스에서 컴파일 시에 타입 체크

  * 미리 사용할 타입을 명시해서 형 변환을 하지 않아도 되게 함

    * 객체 타입에 대한 안정성 향상 및 형 변환의 번거로움 감소

      > Instanceof 연산자는 런타임에서 검사하는 메소드

    * 본래의 시스템: Object로 묶은 다음 **꺼낼 때** instanceof로 **검사**하는 방식 = 넣을 때 편함

    * 꺼낼 때가 아니라 넣을 때부터 명시해준다 = 꺼낼 때 편함

​    

### 표현

* 클래스 또는 인터페이스 선언 시 <>에 타입 파라미터를 표시

  ```java
  public class Class_Name<T>{}
  public interface Interface_Name<T>{}
  ```

  * Class_Name: Raw Type
  * Class_Name\<T>: Generic Type 

* 타입 파라미터

  * 특별한 의미의 알파벳 보다는 단순히 **임의의 참조형 타입**을 말함

  * T: reference **T**ype, E: **E**lement, K: **K**ey, V: **V**alue

    ```java
    public class ArrayList<E> extends AbstractList<E> implements List<E>, RandomAccess{}
    public class HashMao<K,V> extends AbstractMap<K,V> implements Map<K,V>
    ```

    ​			    

* 객체 생성

  * 변수 쪽과 생성 쪽의 타입은 반드시 같아야 함

    ```java
    Class_Name<String> generic = new Class_Name<String>();
    Class_Name<String> generic2 = new Class_Name<>();
    Class_Name generic3 = new Class_Name();
    ```

* 예시

#### [Raw Type]

```java
class NormalBox{ //무엇이든지 담을 수 있는 박
	private Object some;

	public Object getSome() {
		return some;
	}

	public void setSome(Object some) {
		this.some = some;
	}
}

public class Main {
	public static void main(String[] args) {
		NormalBox nbox = new NormalBox();
		nbox.setSome("Hello");
		nbox.setSome(1); //사실 자동으로 출력해주지만
		
		Object some = nbox.getSome(); //절차적으로는 이렇다
		if(some instanceof Integer) {
			Integer val = (Integer) some;
			System.out.println(val.intValue());
		}
}}
```

​			    

#### [Generic Type]

```java
class GenericBox<T>{
	private T some;

	public T getSome() {
		return some;
	}

	public void setSome(T some) {
		this.some = some;
	}
}

public class Main {
	public static void main(String[] args) {
		GenericBox<String> gbox = new GenericBox<>(); //T를 fix 해준다
		gbox.setSome("Hello"); 
		System.out.println(gbox.getSome()); //이미 문자열인 것이 보장
		
}}
```

* \<Object> 라고 하면 결국 위의 예시와 똑같은 기능을 하는 클래스를 만들어 줄 수 있다. (제네릭의 확장성)

​    

### 사용

* 컴파일 타입에 타입 파라미터들이 대입된 타입으로 대체됨

* #### 타입을 제한할 수 있음

  ```java
  class NumberBox<T extends Number>{} //Number를 상속 받은 T만 사용할 수 있다
  ```

  * 인터페이스로 제한하는 경우도 extends 사용(implements X)

  * 클래스와 함께 제약조건 사용시 : &로 연결

    ```java
    class TypeRestrict<extends Number & Cloneable & Comparable<String>>{}
    ```

  * Generic Type 객체를 할당 받을 때 **와일드 카드(?)** 이용

    ```java
    Generic type<?> //타입 제한이 없음
    Generic type<? extends T> // T 또는 T를 상속받은 타입들만 사용 가능
    Generic type<? super T> // T 또는 T의 조상 타입만 가능
    ```

* 메서드에서도 사용 가능: Generic Method

  * 파라미터와 리턴타입으로 type parameter를 갖는 메서드
    * 메서드 리턴 타입 앞에 타입 파라미터 변수 선언

  ```java
  public <P> void method1(P p){ // 알파벳은 어떤 것을 사용하든 상관없다, 관례적으로 사용한다는 것을 명심
  	return p;
  }
  ```

  


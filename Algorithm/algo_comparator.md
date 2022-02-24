# Comparator

> **Array.sort( )**를 적용하기 전에 정렬 기준을 바꿔줄 수 있다

```java
Integer.MAX_VALUE - Integer.MIN_VALUE;// -1 로 결과값이 나오므로

Integer.compare(Integer.MAX_VALUE,Integer.MIN_VALUE); // Integer.compare() 메서드 활용
```



​             

## 객체 정렬

### * 객체 정렬은 Arrays.sort( 객체 )

> 정렬을 원하는 객체에 Comparable 인터페이스를 implements로 가져와 compareTo 메소드를 오버라이딩합니다.

```java
return this.속성 - o.속성; //오름차순
return o.속성 - this.속성; //내림차순
return -(this.속성 - o.속성); //내림차순
```

​         

### * List 컬렉션을 사용하는 경우

> 보통 객체는 Arrays.sort 지만 Collections 의 정렬은 내부 메소드 Collections.sort() 사용

	#### 1. Collections.sort( 컬렉션 ) 사용

> 내림차순을 설정하려면 보통 객체들처럼 implements Comparable 사용

​               

#### 2. Collections.sort( 컬렉션, Comparator 객체) 사용

1.  Comparator 인터페이스를 상속해 나만의 객체를 만들고  compare 메소드를 재정의(override) 해준다.

2. 굳이 클래스까지 만들지 않고 인자로 넘겨줄 때 생성해서 넣어준다.

   ```java
   Collections.sort(컬렉션, new Comparator(){
     @Override
     compare메소드 오버라이딩;
   })
   ```

   ​    

​                

## 정렬 기준 Customizing

* 정렬하고자 하는 객체에 대해서 **Comparable 인터페이스**를 implements로 끌어옵니다.

```java
class Data implements Comparable{ // 인터페이스 가져오기
	
}
```

​                

* **Override**: 정렬 기준 관련 메소드인 `compareTo( )` 를 가져와 기준을 바꿔줍니다.

​             

### 1. compareTo( )

```java
@Override
public int compareTo(Object o){ 
		Data other = (Data)o; // 내부 값을 사용하기 위해 형 변환
  
  	return this.jum == other.jum?(this.num - other.num):-(this.jum - other.jum);

}
```

​           

#### Object로 객체를 받아서 비교할 때 :  Generic 생략 가능

```java
// 상황 : 현재 객체를 배열할 때 내가 원하는 변수를 기준으로 정렬하고 싶다
class Data implements Comparable{ // 원래 Comparable<자료형> 이지만 Object로 받을 때는 생략 가능
	int num;  // 현재 객체의 정렬 기준될 변수들
	int jum;
  
	public Data(int num, int jum) { // 그냥 생성자
		super();
		this.num = num;
		this.jum = jum;
	}
  
  // 오버라이드 : 정렬 기준을 재정의
  
	@Override
	public int compareTo(Object o) { //일단 Object로 받은 다음
    
		Data other = (Data) o; // 내부 값을 사용하기 위해 형 변환
		
		return this.jum == other.jum?(this.num - other.num):-(this.jum - other.jum);
    
    // 현재 객체와 던져주는 객체를 비교: return 값이 0보다 크면 현재 객체가 더 크다는 뜻
    // jum이 서로 같다면 num으로 정렬: jum -> num 순으로 정렬
	}
	
}
```

​                

### 2. compare( )

* Comparator 객체를 가져와서 내부 compare( ) 메소드를 **Override** 한다.

```java
static Comparator comparator = new Comparator<Integer>(){
		@Override
		public int compare(Integer o1, Integer o2) {
			
			return -(o1 - o2); //Auto unBoxing : Wrapper 클래스지만 자동 언박싱
			//return o1.intValue() - o2.intValue(); //Auto unBoxing
		}
		
	};
```

​    

### 3. Comparator를 인자로 받는 자료구조인 경우

* PriorityQueue의 선언을 보면 생성자 단계에서 Comparator 객체를 받아준다.

  ```java
      public PriorityQueue(Comparator<? super E> comparator) {
          this(DEFAULT_INITIAL_CAPACITY, comparator);
      }
  ```

* 이를 이용해 Comparator를 바로 넣어 정렬 기준을 만족하는 최대 힙, 최소 힙을 만들 수 있다.

  ```java
  PriorityQueue pQ = new PriorityQueue<Integer>(new Comparator(){
  	@Override
    public int compare(Integer o1, Integer o2){
  		return o1-o2;
    }
  })
  ```

* 람다식을 활용해 더 간단히 표기할 수 있다.

  ```java
  PriorityQueue pQ = new PriorityQueue<Integer>((o1,o2)->-(o1-o2));
  ```

  

​             

### 4. 람다식을 사용하는 경우

```java
Collections.sort(list,(o1,o2)->-(o1.age-o2.age));
```

* #### 람다식 표현이 가능한 이유?

  * 람다식은 함수형 인터페이스에서 활용가능한데 Comparator 인터페이스의 경우 두 개의 인자를 받는 메서드가 compare 뿐이므로 가능한 방식이다.


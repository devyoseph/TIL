# Comparator

> **Array.sort( )**를 적용하기 전에 정렬 기준을 바꿔줄 수 있다

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

```java
// 상황 : 현재 객체를 배열할 때 내가 원하는 변수를 기준으로 정렬하고 싶다
class Data implements Comparable{
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


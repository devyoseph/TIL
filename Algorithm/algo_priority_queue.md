## [ JAVA ] 우선순위 큐

​         

#### java.util.PriorityQueue()

​            

#### < 사용법 >

```java
import java.util.PriorityQueue;

public class Main {
    public static void main(String[] args) {
    PriorityQueue<Integer> pQ = new PriorityQueue<Integer>();

}}
```

​            

#### < 예제 >

* 우선 순위 큐의 **default 값은 오름차순(최소 힙)정렬**이다.

```java
import java.util.PriorityQueue;

public class Main {
    public static void main(String[] args) {
    PriorityQueue<Integer> pQ = new PriorityQueue<Integer>();
    pQ.offer(10);
    pQ.offer(30);
    pQ.offer(5);
    pQ.offer(20);
    pQ.offer(20);
    for(int i=0; i<5; i++) {
    	System.out.println(pQ.poll());
    }
}}

5
10
20
20
30
```

​              

#### <최소 힙에서 최대 힙으로 바꾸기>

```java
PriorityQueue<Integer> priorityQueue = new PriorityQueue<>(Collections.reverseOrder());
```

​              

#### < Comparator > 의 적용

* PriorityQueue 의 메서드 Declaration 에 들어가면 다음과 같다.

  ```java
      public PriorityQueue(Comparator<? super E> comparator) {
          this(DEFAULT_INITIAL_CAPACITY, comparator);
      }
  ```

  > 생성자 단계에서 Comparator를 객체로 받아 정렬 기준을 바꿔줄 수 있다.

​            

* Comparator은 interface로 implements로 땡겨서 나만의 메서드로 재구현할 수 있다.

```java
class MyComparator implements Comparator<Integer>{ // Comparator을 가져와서 구현
		@Override
  	public int compare(Integer o1, Integer o2){
			
      	return o1 - o2; // Auto unBoxing : Wrapper Class 지만 자동으로 해줌
      	// return o1.intValue() - o2.intValue(); // Auto unboxing
    }

}
```

* 사용은 인스턴스로 만들 때 사용하면 된다.

```java
PriorityQueue<Integer> priorityQueue = new PriorityQueue<>(MyComparator);
```

​         

* 람다식을 사용한 구현: 인스턴스 단게에서 Comparator 구현 가능

```java
PriorityQueue<Integer> pQ = new PriorityQueue<>(
		(o1, o2) -> return -(o1 - o2);
);
```

​		\- 내부에서 compare을 구현해놔도 위처럼 덮어씌우면 덮어씌운 기준으로 정렬된다.

​       

* 람다식 2

```java
PriorityQueue<Integer> pQ = new PriorityQueue<>((o1, o2) -> -(o1 - o2));
```






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




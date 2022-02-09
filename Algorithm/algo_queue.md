# 큐

> **선입선출구조(FIFO)**
>
> ​	\- 큐에 삽입한 순서대로 원소가 저장되어 가장 먼저 삽입(First)된 원소는 가장 먼저 삭제(First Out) 된다.

​           

### 큐의 기본 연산

* 삽입: enQueue
* 삭제: deQueue

​      

> 배열을 이용하기 때문에 배열 공간 자체를 없애는 것이 아니라 index로만 표기해 front와 rear부분을 구분한다.

​           

## java.util.Queue

* 큐에 필요한 연산을 선언해 놓은 인터페이스
* LinkedList 클래스를 Queue 인터페이스 구현체로 많이 사용

​        

### 주요 메서드

* offer()
* poll()
* isEmpty()
* size()

​          

### 큐 활용 - 버퍼

* 데이터를 한 곳에서 다른 곳으로 전송하는 동안 일시적으로 그 데이터를 보관하는 메모리 영역
* 버퍼는 일반적으로 입출력 및 네트워크와 관련된 기능에서 이용된다.
* 순서대로 입력/출력/전달되어야 하므로 FIFO 방식의 자료구조인 큐가 활용

​       

### 리스트(List)

* 순서를 가진 데이터의 집합을 가리키는 추상 자료형(abstract data type)
* 동일한 데이터를 가지고 있어도 상관없다.

* 구현 방법에 따라 크게 두 가지로 나뉜다.

  1. **순차 리스트** : 배열을 기반으로 구현된 리스트

     ```java
     Queue<String> queue = new ArrayDeque<String>(); // 배열 => 중간에 배열 수정이 일어남
     // 변동이 없을 때 읽어오기가 빠르다.
     ```

  2. 연결 리스트 : 메모리의 동적할당을 기반으로 구현된 리스트

     ```java
     Queue<String> queue = new LinkedList<String>(); // 연결됨
     ```

     ​       

### 연결 리스트(Linked List)

> 자료의 논리적인 순서와 메모리 상의 물리적인 순서가 일치하지 않고 **개별적으로 위치하고 있는 각 원소를 연결해** 하나의 전체적인 자료구조를 이룬다.
>
> 때문에 배열처럼 물리적인 순서를 맞출 필요가 없고 자료의 크기를 동적으로 조정할 수 있어 메모리를 효율적으로 관리할 수 있다.

​        

#### 연결 리스트의 종류

1. 단순 연결 리스트

   > 노드(Node) 내부는 Head, Data, Link로 구성되며 Head는 시작점 노드의 주소를 가진 시작부이다.
   >
   > 각 노드마다 Data와 Link로 이루어져있으며 Link는 뒷 노드의 주소를 담고 있다.
   >
   > Data 부분에 데이터를 저장한다.Link가 Null이 된 노드가 마지막 노드이다.

2. 이중 연결 리스트

   > data와 link 부분에서 prev를 추가해 이전 노드의 순회도 가능하도록 만든 리스트이다.

3. 원형 연결 리스트

​         

### 만들기 예제

```java
public class Node{
	public String data; // data 필드
	public Node link; //link 필드
  
	public Node(String data, Node link){
			super();
    	this.data = data;
    	this.link = linkl
  }
  public Node(String data){
			super();
    	this.data = data;
  }
  
  @Override
  public String toString(){
			return "Node [data=" + data + ", link=" + link + "]";
  }

}
```

```java
public class Stack {
	private Node top;
	
	public void push(String data) {
		top = new Node(data,top);
	}
  public String pop(){
    	if(isEmpty()) return null;
    
    	// 첫번째 노드(top) 삭제
    	Node popNode = top;
    	top = popNode.link;
	}
 	public boolean isEmpty(){
			return top == null;
  }
  
  @Override
  public String toString(){
    	StringBuilder sb = new StringBuilder();
    	sb.append("[");
    for(Node currNode=top; currNode!=null; currNode=currNode.link){
					sb.append(currNode.data).append(",");
    }
    if(!isEmpty()) sb.setLength(sb.length()-1);
    
		sb.append("]");
    return super.toString();
  }
}
```


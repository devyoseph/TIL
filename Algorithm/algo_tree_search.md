# 비선형 자료구조 완전 탐색

* 비선형 구조인 트리, 그래프의 각 노드(정점)를 중복되지 않게 전부 방문(visit) 하는 것
  * 선후 연견 관계는 알 수 없기 때문에 특별한 탐색 방법이 필요하다.

​             

#### 두 가지 방법

* 너비 우선 탐색(Breadth First Search, BFS)
* 깊이 우선 탐색(Depth First Search, DFS)

​                

​              

## 트리 탐색 - BFS

> **너비 우선 탐색**
>
> * 너비우선 탐색은 루트 노드의 자식 노드들을 차례로 방문하고, 다시 방문했던 자식들의 자식들을 차례로 방문하는 방식
>   * 같은 레벨의 노드들을 순차적으로 탐색
> * **큐**를 활용

​            

### BFS 알고리즘

```java
BFS()
	큐 생성
	루트 v를 큐에 삽입
	while(큐가 비어있지 않은 경우){
			t 큐의 첫 번째 원소 반환(poll)
			t 방문
			for(t와 연결된 모든 간선에 대해){
					u ← t의 자식노드
					u를 큐에 삽입
			}
	}
end BFS()
```

​         

### < BFS 예 > 

```java
public void bfs2() { // 너비 단위 업무처리
        if(isEmpty()) {
            System.out.println("출력 정보 없음");
            return;
        }
        Queue<Integer> q = new LinkedList<>();
        q.offer(1);
        while(!q.isEmpty()) {

            //같은 너비들만 탐색(할일)처리== 같은 행에 처리
            int size = q.size();
            for(int i =0; i < size; i++) {
                int cur = q.poll();
                System.out.print(nodes[cur] + " ");


                //왼쪽 자식 있으면 추가
                if(cur2 <= lastIndex) {
                    q.offer(cur2);
                }
                //오른쪽 자식 있으면 추가
                if(cur2 + 1 <= lastIndex) {
                    q.offer(cur2 + 1);
                }
            }
            System.out.println();

        }

    }
```

​       

#### 1. 초기 상태

* 큐(Q)를 생성하고 루트노드 A를 큐 안에 집어넣기(enqueue)

​         

#### 2. 탐색 진행

* 큐에 있는 원소 A를 빼기
* 뺀 원소 A의 자식 노드들 B, C, D 를 큐에 넣기
* B를 빼고 B의 자식 노드들을 큐에 넣기
* C를 빼고 C의 자식 노드들을 큐에 넣기
* D를 빼고 D의 자식 노드들을 큐에 넣기

​          

#### 3. 탐색 종료

* 큐에 원소가 없는 경우 탐색 종료

​          

​                  

​               

## DFS(Depth First Search)

> **깊이 우선 탐색**
>
> * 루트에서 출발해 한 방향으로 갈 수 있는 경로까지 탐색한 다음 더 이상 갈 곳이 없다면 가장 마지막에 만났던 갈림길 간선이 있는 노드에서 다른 방향의 노드로 탐색을 반복해 모든 노드를 탐색한다.
> * **재귀**나 **스택**을 사용

​        

### DFS 알고리즘

```java
DFS(v)
	v 방문;
	for(v의 모든 자식노드 w){
			DFS(w);
	}
end DFS()
```

​         

### < DFS 예 >

​         

#### 1. 루트노드 A를 시작으로 깊이 우선 탐색 시작

````java
DFS(A)
	A 방문;
	
	//A의 자식노드(B,C,D) 모두에 대하여
	DFS(B)
	DFS(C)
	DFS(D)
````

​         

### 2. 자식노드들에서 깊이 우선 탐색을 처리

* 자식 노드에 대해서 깊이 우선 탐색하면 다시 자식 노드가 있는 재귀로 들어간다.

​          



​                   

​                            

## 이진트리 - 순회(traversal)

> 순회(traversal) : 트리의 노드들을 체계적으로 방문하는 것

​         

### 3가지의 기본 순회

> 전위순회, 중위순회, 후위순회

* #### 전위 순회(preorder traveral) : VLR

  ​	\- 부모노드 방문 후, 자식 노드를 좌,우 순서로 방문한다.

  ```java
  preorder_traverse(T)
  	if ( T is not null )
  	{
  		visit(T);  // V
  		preorder_traverse(T.left);  // L 
  		preorder_traverss(T.right); // R
  	}
  End preorder_traverse
  ```

  ​                       

* #### 중위 순회(inorder traversal) : LVR

  ​	\- 왼쪽 자식노드, 부모노드, 오른쪽 자식노드 순으로 방문한다.

  ```java
  inorder_traverse(T)
  	if ( T is not null )
  	{
  		inorder_traverse(T.left);  // L
      visit(T);  // V
  		inorder_traverss(T.right); // R
  	}
  End inorder_traverse
  ```

  ​               

* #### 후위순회(postorder traversal) : LRV

  ​	\- 자식노드를 좌우 순서로 방문한 후, 부모노드로 방문한다.

  ```java
  postorder_traverse(T)
  	if ( T is not null )
  	{
  		postorder_traverse(T.left);  // L
      postorder_traverss(T.right); // R
      visit(T);  // V
  	}
  End postorder_traverse
  ```

    

​            

​                 

## 수식 트리

> 수식을 표현하는 이진 트리, 수식 이진 트리(Expression Binary Tree)
>
> **연산자 노드** : 루트, 가지 노드
>
> **피연산자(operand)** :  모두 leaf 노드

​          

### 수식 트리의 순회

* 중위/후위/전위 순회 = 중위/후위/전위 표기법

​          

​               

​                  

## 힙(Heap)

> 완전 이진 트리에 있는 노드 중 키 값이 가장 큰 노드나 가장 작은 노드를 찾기 위해 만든 자료구조

* ### 최대 힙(max heap)

  * 키 값이 가장 큰 노드를 찾기 위한 **완전 이진 트리**

  * 부모 노드의 키 값 > 자식 노드의 키 값

  * 루트 : 키 값이 가장 큰 노드

    ​       

* ### 최소 힙(min heap)

  * 키 값이 가장 작은 노드를 찾기 위한 **완전 이진 트리**
  * 부모 노드의 키 값 < 자식 노드의 키 값
  * 루트 노드 : 키 값이 가장 작은 노드

​          

### 힙 연산

> N개의 노드 삽입과 N개의 노드 삭제 연산 = O(N*logN)

#### 1. 삽입

1) 완전 이진 트리를 유지하며 최하단 노드에 값을 삽입

​		\- 배열이라면 배열 size의 1을 더한 index에 값을 삽입

2. 현재 추가한 노드를 **부모와 계속 비교**하면서 자리 바꾸기 시행

​      

#### 2. 삭제

1. 루트 노드만 삭제 가능하다
2. 삭제한 후 루트가 사라지는데 현재 트리 기준 최하단 노드를 넣어준다
3. 현재 추가한 노드를 **자식과 비교**하며 자리 바꾸기 시행

​             

### 우선순위 큐 : java.util.PriorityQueue(Comparator comparator)

> 원소들의 natural Ordering을 따라 Heap 유지
>
> 반드시 모든 원소는 Comparable 인터페이스 구현

* Heap 자료구조
* 최대 Heap / 최소 Heap

​              

### java.lang.Comparable\<T\>

* Int compareTo(T other)
* 자신과 인자로 전달 받는 타 원소와 비교하여 정수 리턴
  * 음수 결과 : 타 원소가 크다
  * 0 결과 : 둘이 같다
  * 양수 결과 : 자신이 크다

```java
class Student implements Comparable<Student>{
	int no, score;
	
	public Student(int no, int score){
		super();
    this.no = no;
    this.score = score;
	}
	
  @Override
  public int compareTo(Student o){ //자신과 인자로 전달 받는 타 원소와 비교하여 정수 리턴
		return this.no - o.no;
  }

  @Override
  public int compare(Student o1, Student o2){ //두 원소를 비교하여 정수 리턴
		return o1.no - o2.no; // 음수 = o2가 크다, 양수 = o1이 크다
  }
}
```


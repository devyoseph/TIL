# 그래프

> 그래프는 아이템(사물 또는 추상적인 개념)들과 이들 사이의 연결관계를 표현한다.
>
> 선형 자료구조나 트리 자료구조로 표현하기 어려운 N:N 관계를 가지는 원소들을 표현하기에 용이하다.

​          

### 용어 정리

* 정점(Vertex) : 그래프의 구성요소로 하나의 연결점
* 간선(Edge) : 두 정점을 연결하는 선
* 차수(Degree) : 정점에 연결된 간선의 수
* 인접(Adjacency) : 두 개의 정점에 간선이 존재(연결됨)하면 서로 인접해 있다고 한다.
* 경로(Path) : 어떤 정점 A에서 시작해 다른 정점 B로 끝나는 순회로 두 정점 사이를 잇는 간선들을 순서대로 나열
  * 단순 경로 : 시작 정점과 끝 정점을 제외하고 중복된 정점이 없는 경로
  * **싸이클(Cycle)** : 경로의 시작 정점과 끝 정점이 같음
* 그래프는 정점(Vertex)들과 집합과 이들을 연결하는 간선(Edge)들의 집합으로 구성된 자료

​             

### 그래프 유형

* 무향 그래프(Undirected Graph)
* 유향 그래프(Directed Graph)
* 가중치 그래프(Weighted Graph)
* 사이클이 없는 방향 그래프(DAG, Directed Acyclic Graph)

​          

* 완전 그래프
  * 정점들에 대해 가능한 모든 간선들을 가진 그래프
* 부분 그래프
  * 원래 그래프에서 일부의 정점이나 간선을 제외한 그래프
  * 트리도 그래프이다.

​                

### 그래프 표현

> 간선의 정보를 저장하는 방식, 메모리나 성능을 고려해 결정
>
> 정점을 중심으로 하는 인접행렬, 인접리스트와 간선중심의 간선리스트로 나뉜다

* 인접 행렬(Adjacent matrix)
  * VxV 크기의 2차원 배열을 이용해서 간선 정보를 저장
  * 배열의 배열
* 인접 리스트(Adjacent List)
  * 각 정점마다 다른 정점으로 나가는 간선의 정보를 저장
* 간선 리스트(Edge List)
  * 간선(시작 정점, 끝 정점)의 정보를 객체로 표현하여 리스트에 저장

​               

​                   

## 인접 행렬

> 인접행렬은 완전 그래프에 가까운 그래프(밀집 그래프, Dense Graph)일수록 효율적이다.
>
> 희소그래프(Sparse Graph)인 경우 비효율적이다.

```java
// 무향 그래프
	static int N;
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		N = sc.nextInt();
		int C = sc.nextInt(); //간선 수
		
		int[][] adjMatrix = new int[N][N]; // 정점수 크기로 생성
		
		for(int i = 0; i < C; i++) {
			int from = sc.nextInt();
			int to = sc.nextInt();
			adjMatrix[from][to] = adjMatrix[to][from] = 1; //무향 그래프
		}
		for(int[] is : adjMatrix) {
			System.out.println(Arrays.toString(is));
		}
}
```

* VxV 정방 행렬
* 행 번호와 열 번호는 그래프의 정점에 대응
* 두 정점이 인접되어 있으면 1, 그렇지 않으면 0

* 무향 그래프
  * i 번째 행의 합 = i 번째 열의 합 = V의 차수
* 유향 그래프
  * 행 i의 합 = V의 진출 차수
  * 열 j의 합 = V의 진입 차수

​                   

​                     

## 인접 리스트

> 각 정점에 대한 인접 정점들을 순차적으로 표현한다.
>
> 하나의 정점에 대한 인접 정점들을 각각의 노드로 하는 연결 리스트로 저장한다.

```java
import java.util.*;

public class Main {
	static int N;
	static class Node{
		int vertex;
		Node link;
		
		public Node(int vertex, Node link) {
			this.vertex = vertex;
			this.link = link;
		}
		@Override
		public String toString() {
			return "Node [vertex= " + vertex + ", link= " + link +"]";
		}
		
	}
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		N = sc.nextInt();
		int C = sc.nextInt(); //간선 수
		Node[] adjList = new Node[N];
		for(int i = 0; i < C; i++) {
			int from = sc.nextInt();
			int to = sc.nextInt();
			adjList[from] = new Node(to,adjList[from]);
			adjList[to] = new Node(from,adjList[to]);
		}
		for(Node head : adjList) {
			System.out.println(head);
		}
}
}
```

* 무향 그래프

  * 인접리스트에 존재하는 노드의 수 = 그래프 상 **간선**의 개수x2
    * 각각의 노드마다 내가 누구와 연결됐는지 표현하는데 양쪽에서 모두 표현하므로
  * 인접리스트에 존재하는 노드의 수 = 그래 상 간선의 개수

  ​           

  ​                 

## 간선 리스트

> 두 정점에 대한 간선 그 자체를 객체로 표현하여 리스트로 저장한다.
>
> 간선을 표현하는 두 정점의 정보를 나타낸다.

* 리스트에 들어가는 정보
  * [ 시작 정점의 번호 / 끝 정점의 번호 ]



​          

​             

## BFS(Breadth First Search)

> 너비우선탐색은 탐색 시작점의 인접한 정점들을 모두 차례대로 방문한 후에 방문했던 정점을 시작점으로 하여 다시 인접한 정점들을 차례로 방문하는 방식
>
> **큐**를 활용

​             

### Sudo코드

```java
BFS(G,v) // 그래프 G, 탐색 시작 정점 v
	큐 생성
	시작 정점 v를 큐에 삽입
	정점 v를 방문한 것으로 표시
	
	while(큐가 비어있지 않은 경우){
			t = 큐의 첫번째 원소
      for(t와 연결된 모든 간선에 대해){
					u = t의 인접정점
          u가 방문되지 않은 곳이면
          u를 큐에 넣고 방문 표시
      }
	}
```

​          

​           

## DFS(Depth First Search)

> 시작점의 한 방향으로 갈 수 있는 경로까지 탐색해 더 이상 갈 곳이 없게되면 갈림길 간선이 있는 정점으로 되돌아와서 다른 방향의 정점으로 탐색 반복
>
> **재귀**로 구현

​         

### Sudo 코드

```java
G : 그래프

DFS(v) // v 탐색 정점

	visited[v] = true //방문 설정
	
	FOR each all w in adjacency( G, v )
		IF visited[w] != true
				DFS(w)
```




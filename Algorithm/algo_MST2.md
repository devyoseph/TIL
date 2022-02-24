# 최단 경로

* 간선의 가중치가 있는 그래프에서 두 정점 사이의 경로들 중에 간선의 가중치 합이 최소인 경로
* 다익스크라(dijkstra) 알고리즘
  * 음의 가중치를 허용X
* 벨만-포드(Bellman-Ford) 알고리즘
  * 음의 가중치를 허용
* 모든 정점들에 대한 최단 경로
  * 플로이드-워샬(Floyd-Warshall)

​           

## Dijkstra 알고리즘

[참고링크](https://m.blog.naver.com/ndb796/221234424646)

> 시작 정점에서 다른 모든 정점으로의 최단 경로를 구하는 알고리즘
>
> 탐욕 기법을 사용한 알고리즘으로 MST의 프림 알고리즘과 유사하다

```java
s : 시작 정점, A : 인접 행렬, D : 시작정점에서의 거리
V : 정점 집합, U : 선택된 정점 집합

Dijkstra(s,A,D)
	U = {s};   // 임의의 시작 노드 선택
	
	FOR 모든 정점 v
		D[v] = A[s][v] // 시작 노드(s)에 직접연결된 모든 노드 거리 구함
	
	WHILE U != V
		D[w]가 최소인 정점 w ∈ V-U 를 선택 // 트리에 속하지 않는 노드 중 최소거리인 노드를 구하고
		U = U ∪ {w} 
		FOR w에 인접한 모든 미방문 정점
			D[v] = min(D[v], D[w] + A[w][v]) // w에서 다시 연결된 모든 정점들과의 거리를 최소값으로 업데이트
```

​         

#### 순서

* 시작 정점과 다른 정점들과의 거리를 갱신
  * 직접적으로 이어졌다면 숫자를 그냥 쓰지만 직접 연결이 아닌 경우 무한대의 수를 기록
  * 1차원 배열에는 출발점과 모든 노드와의 최소 거리가 기록
* 그렇게 기록한 배열 값을 기준으로 **방문하지 않은 노드** 중에서 최소인 노드로 이동
* **출발노드 - 현재 노드까지의 거리를 유지한 상태**로 다른 노드와의 거리를 계산한다
  * 그래서 출발노드-다음노드[직접연결] < 출발노드-현재노드 - 다음 노드 [간접연결] 을 만족하는 루트를 찾고
    * 최소값을 배열에다 갱신
    * 현재 노드를 방문체크

```java
import java.util.*;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int V = sc.nextInt(); // 정점의 개수
		int[][] map = new int[V][V]; // 인접행렬
		int start = 0; //출발정점
		
		boolean[] visited = new boolean[V]; //방문체크
		int[] distance = new int[V]; //출발지에서 자신으로 오는 최소비용
		
		Arrays.fill(distance, Integer.MAX_VALUE); //최대값으로 모두 채움
		distance[0] = 0;
		
		for (int i = 0; i < V; i++) { // 값 입력받기
			for (int j = 0; j < V; j++) {
				map[i][j] = sc.nextInt();
			}
		}
		
		for(int i=0; i<V; i++) {
			// 단계 1: 최소비용이 확정되지 않은 정점 중 최소비용 정점 선택
			int min = Integer.MAX_VALUE, current = 0;
			
			for (int j = 0; j < V; j++) {
				if(!visited[j] && min > distance[j]) {
					min = distance[j];
					current = j;
				}
			}
			
			visited[current] = true;
			
			for (int j = 0; j < V; j++) {
				if(!visited[j] && map[current][j] != 0 &&
						distance[j] > distance[current] + map[current][j]) {
					distance[j] = distance[current] + map[current][j];
				}
			}
		}
		
		System.out.println(Arrays.toString(distance));
	}   
}
```


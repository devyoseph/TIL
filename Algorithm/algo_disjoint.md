# 서로소 집합(Disjoint-set)

* 서로소 또는 상호배타 집합들은 서로 중복 포함된 원소가 없는 집합들이다. 다시 말해 교집합이 없다.
* 집합에 속한 하나의 특정 멤버를 통해 각 집합들을 구분한다. = 대표자(representative)
* 서로소 집합을 표현하는 방법
  * 연결 리스트
  * 트리

​           

## 서로소 집합 연산

* Make-Set(x) : 유일한 멤버 x를 포함하는 새로운 집합을 생성하는 연산 [단위집합]

```java
Make-Set(x) 
	p[x] = x // [0,0,0,0] : 4 원소가 모두 0을 부모로 가지고 있는 형태
```

* Find-Set(x) : x를 포함하는 집합을 찾는 연산 : **재귀나 반복문 사용**

```java
Find-Set(x)
	IF x == p[x] : RETURN x // [0,1,1,3,2,4] : find-set(5) = 4 - 2 - 1 - 0: 루트를 찾을 때까지 이동
	ELSE 				 : RETURN Find_Set(p[x])
```

* Union(x, y) : x와 y를 포함하는 두 집합을 통합하는 연산

```java
Union(x,y)
	IF Find-Set(y) == Find-Set(x) RETURN; //이미 같은 집합일 때 종료
	p[Find-Set(y)] = Find-Set(x) // 반대로 해도 상관X, Y대표자의 부모에 X대표자의 부모를 넣어줌
```

* x, y가 각각 대표원소인 집합을 통합하는 과정

​                    

​            

## 서로소 집합 표현 - 연결리스트

* 같은 집합의 원소들은 하나의 연결리스트로 관리
* 연결리스트의 맨 앞의 원소를 집합의 대표 원소로 삼는다
* **각 원소는 집합의 대표원소를 가리키는 링크를 갖는다**. = **각각의 원소는 모두 대표원소와 연결된다**
  * 앞 뒤 원소와 연결 링크(Node link) + 대표자 링크(Node rep)
* 연결 리스트끼리 UNION 할 때
  * 두 집합 중 대표자가 될 원소를 선정한 다음, 대표자가 바뀌는 집합 쪽 대표자의 부모를 변경
* 만약 원소 d와 f를 합치라고 하면?
  * 그 둘만 바로 합치면 오류가 발생: **각각의 대표자를 찾고 합쳐준다**.

​          

### 서로소 집합 표현 - 트리

* 같은 집합의 원소들을 하나의 트리로 표현한다.
* 자식 노드가 부모 노드를 가리키며 루트 노드가 대표자가 된다.

​              

​         

## 서로소 집합에 대한 연산

* 연산의 효율을 높이는 방법

  * Rank를 이용한 Union
    * Rank: 자신을 기준으로 최대 깊이를 저장
    * 각 노드는 자신을 루트로 하는 subtree의 높이를 rank로 저장
    * 두 집합을 합칠 때 rank(depth)가 낮은 집합을 rank가 높은 집합에 붙인다
  * Path compression : 경로 압축
    * Find-Set을 행하는 과정에서 만나는 모든 노드들이 직접 root를 가리키도록 포인터를 바꿔준다.
    * 즉 트리의 길이(재귀의 깊이)가 작아진다.

  ```java
  Find-Set(x)
  	IF x == p[x] : RETURN x
  	ELSE         : RETURN p[x] = Find-Set(p[x])
  ```

   

### 전체 코드

```java
import java.util.*;

public class Main {
	
	static int N;
	static int[] parents;
	
	//단위 집합 생성
	public static void makeSet() {
		parents = new int[N];
		//자신의 부모노드를 자신의 값으로 세팅
		
		for (int i = 0; i < N; i++) {
			parents[i] = i;
		}
	}
	
	//대표자 찾기
	public static int findSet(int a) {
		if(a == parents[a]) return a;
		
		return parents[a] = findSet(parents[a]); //path Comprssion
	}
	
	//a, b 두 집합 합치기
	public static boolean union(int a, int b) { //리턴값은 경우에 따라 다름
		int aRoot = findSet(a);
		int bRoot = findSet(b);
		
		if(aRoot == bRoot) return false; //둘의 부모가 같으면 합칠 필요가 없음
		
		parents[bRoot] = aRoot;
		
		return true;
	}
	
	public static void main(String[] args) {
		N = 5;
		
		makeSet();
		
		System.out.println(union(0,1));
		System.out.println(Arrays.toString(parents));
		System.out.println(union(2,1));
		System.out.println(Arrays.toString(parents));
		System.out.println(union(3,2));
		System.out.println(Arrays.toString(parents));
		System.out.println(union(4,3));
		System.out.println(Arrays.toString(parents));
		
		System.out.println("=====find=====");
		for(int i=0; i<N; i++) {
			System.out.println(findSet(i));
		}
}
}
```



​           
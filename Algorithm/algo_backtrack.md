# 백트래킹

* 문제의 해답을 찾는 방법을 상태 공간 트리(state space tree)로 나타내본다.
* 보통 재귀함수로 구현되며 여러 가지 선택지들이 존재하는 상황에서 하나의 가지를 선택한다.

> 어떤 노드의 유망성을 점검한 후에 유망(promising)하지 않다고 결정되면 그 노드의 부모로 되돌아가(backtracking) 다음 자식 노드로 간다.
>
> * 유망(promising)하다.
>   * 어떤 노드를 방문하였을 때 그 노드를 포함한 경로가 해답이 될 수 있는 경우
> * 가지치기(pruning)
>   * 유망하지 않은 노드가 포함되는 경로는 더 이상 고려하지 않는다.

* 백트래킹 알고리즘을 사용하면 일반적으로 경우의 수가 줄어들지만 최악의 경우 지수함수시간(Exponential Time)을 요하므로 처리 불가능할 수 있다.

​           

​            

## 일반적인 백트래킹 알고리즘

````java
backtrack(code v)
	
	IF promising( v ) == false then return; // 유망하지 않다면 가지치기
	
	IF there is a solution at v // 해답을 찾은 경우 출력
		write the solution
		
	ELSE
		FOR each child u of v // 각각의 방문 가능한 노드 v에 대해
			backtrack( u ) // 다시 재귀함수 호출을 통한 탐색
	
````


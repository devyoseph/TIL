# 트리

​       

### 트리의 개념

* 비선형 구조
* 원소들 간에 1:n 관계를 가지는 구조
* 원소들 간에 계층관계를 가지는 계층형 자료구조
* 상위 원소에서 하위 원소로 내려가면서 확장되는 트리(나무)모양의 구조

​      

​        

## 트리 - 정의

​      

* #### 노드(node) : 트리의 원소

  > 형제 노드(sibling node) : 같은 부모 모드의 자식 노드들
  >
  > 조상 노드 : 상위의 모든 노드
  >
  > 자손 노드 : 하위의 모든 노드
  >
  > 서브 트리(부 트리) : 부모 노드와의 간선을 끊었을 때 생성되는 트리

  ​     

* #### 간선(edge) : 노드와 노드를 연결하는 선

  * 루트(root) : 노드 중 최상위 노드

  * 리프(leaf) : 최하단 노드

    ​       

* #### 차수(degree) : 노드에 연결된 자식 노드의 수

  * 트리의 차수 : 트리에 있는 노드의 차수 중에서 가장 큰 값

  * 단말 노드(리프 노드) : 차수가 0인 노드

    ​       

* #### 높이

  * 노드의 높이 : 루트에서 노드에 이르는 간선의 수(노드의 레벨)
  * 트릐의 높이 : 트리에 있는 노드의 높이 중에서 가장 큰 값

  ​       

* 한 개 이상의 노드로 이루어진 유한 집합이며 다음 조건을 만족한다.
  * 나머지 노드들은 n개의 분리집합으로 분리 가능하다(루트의 가지에 나온 자식들의 뭉치)

  

​          

## 이진 트리

> 각 노드가 자식 노드를 최대 2개까지 가질 수 있는 트리 (왼쪽, 오른쪽)
>
> * 어떤 노드든 최대 서브 트리의 개수는 2개이다

​        

### 이진 트리 - 특성

* #### 높이

  * 높이 i에서 노드의 최대 개수는 2^i 개 (루트의 높이 = 0)
  * 높이가 h인 이진 트리가 가질 수 있는 노드의 최소 개수는 (h+1), 최대 개수는 2^(h+1) + 1

​       

### 이진트리 - 종류

> 이진트리는 노드 번호에 규칙성이 있어서 배열로 나타낼 수 있다(힙 정렬).

* #### 포화 이진 트리(Full Binary Tree)

  * 모든 레벨의 노드가 포화 상태인 이진 트리
  * 높이가 h일 때, 노드의 개수는 2^(h+1) + 1이다.

  ​       

* #### 완전 이진 트리(Complete Binary Tree)

  * **최하단 노드를 제외**하고 모두 2개의 자식을 가지고 있는 트리

    * 노드의 수가 10개일 때 자식 노드가 없는 최하단 노드가 존재하지만 완전 이진 트리이다.

      ​      

* #### 편향 이진 트리(Skewed Binary Tree)

  * 한쪽 방향의 자식 노드만을 가지는 이진 트리
  * 높이 h에 대한 최소 개수의 노드를 가짐

​         

### 이진트리의 표현

* #### 배열

  **\- 자식 노드 번호** : 부모 노드의 번호가 i 일 때, 2 * i, 2 * i +1

  **\- 부모 노드 번호** : 자식 노드의 번호가 i 일 때, 2 / i

  **\- 시작 번호** : 레벨 n의 노드 시작 번호 = 2의 n 승

  **\- 높이** : 높이가 h인 트리의 최대 원소 개수 = 2^(h+1) - 1 = 배열의 크기

  ​        

  * **배열의 단점**

    > 메모리 공간 낭비 : 편향 이진 트리의 경우 배열 원소를 모두 사용하지 않음
    >
    > 크기 변경 불가: 트리 중간에 노드 삽입, 삭제가 많은 경우 비효율적

​             

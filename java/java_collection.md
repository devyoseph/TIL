# Collection Framework

> **자료 구조**(data structure)는 컴퓨터 과학에서 효율적인 접근 및 수정을 가능케하는 자료의 조직, 관리, 저장을 의미한다.

​       

### 배열

> 가장 기본적인 자료 구조

* **장점**

  * 접근 속도가 빠름, 사용이 쉬움

    ​        

* **단점**

  * homogeneous collection: 동일한 데이터 타입만 관리 가능
  * 크기 변경X, 추가 데이터를 위해 새로운 배열을 만들어야 함
  * 비 순차적 데이터 추가, 삭제에 많은 시간 소요

  ​      

* Polymorphism

  * Object를 이용하면 모든 객체 참조 가능 = Collection Framework

  * 담을 때 편리하지만 빼낼 때 Object로만 가져올 수 있음

  * 런타임에 실제 객체 타입 확인 후 사용해야하는 번거로움 존재

    ​      

* Generic을 이용한 타입 한정

  * 컴파일 타임에 저장하려는 타입 제한 = 형 변환 번거로움 제거

​        

### Collection Framework

* java.util 패키지
  * 다수의 데이터를 쉽게 처리하는 방법 제공 = DB 처럼 CRUD 기능 중요
  * CRUD = Create / Read / Update / Delete
* Iterable = Collection의 최상위 객체

​       

#### Collection framework의 핵심 interface

| interface | 특징                                                         |
| --------- | ------------------------------------------------------------ |
| List      | 순서가 있는 데이터 집합, 데이터 중복O                        |
|           | ArrayList, LinkedList                                        |
| Set       | 순서가 없는 데이터 집합, 중복X                               |
|           | HashSet, TreeSet                                             |
| Map       | key와 value의 쌍으로 데이터를 관리하는 집합, 순서는 없고 key의 중복 불가, values는 중복 가능 |
|           | HashMap, TreeMap                                             |

​           

| 분류 | Collection                        |
| ---- | --------------------------------- |
| 추가 | add(E e)                          |
|      | addAll(Collection<? Extends E> c) |
| 조회 | contains(Object o)                |
|      | containsAll(Collection<?> c)      |
|      | equals()                          |
|      | inEmpty()                         |
|      | iterator()                        |
|      | size()                            |
| 삭제 | clear()                           |
|      | removeAll(Collection<?> c)        |
|      | retainAll(Collection<?> c)        |
| 수정 |                                   |
| 기타 | toArray()                         |

​         

### List

* 특징
  * 순서가 있는 데이터의 집합
  * 순서가 있으므로 데이터의 중복을 허락

| 분류 | Collection                                               |
| ---- | -------------------------------------------------------- |
| 추가 | add(E e)                                                 |
|      | addAll(Collection<? Extends E> c)                        |
| 조회 | get(int index)                                           |
|      | indexOf(Object o)                                        |
|      | lastIndexOf(Object o)                                    |
| 삭제 | remove(int index)                                        |
| 수정 | set(int index, E element)                                |
| 기타 | subList(int fromIndex, int toIndex) : 부분을 잘라서 대입 |

```java
List<String> sub = friends.subList(0,2); // 잘라서 대입
```

​       

### LinkedList

*  각 요소를 Node로 정의하고 Node는 다음 요소의 참조 값과 데이터로 구성됨
  * 각 요소가 다음 요소의 링크 정보를 가지며 연속적으로 구성될 필요가 없다

* 노드 삭제
  * 삭제하는 노드 기준으로 이전 노드의 주소값만 삭제 다음 노드의 주소로 바꿔주면 됨
* 노드 추가
  * 삽입하는 위치에서 이전 노드의 참조 주소를 현재 삽입하는 노드의 주소로 바꾸고 현재 노드에서 다음 노드의 주소값을 저장

​        

#### for-each 문장

* 값을 수정할 수 없고 조회(read-Only)만 가능하다
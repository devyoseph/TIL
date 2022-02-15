# 분할 정복

​              

### 유래

* 1805년 12월 2일 아우스터리츠 전투에서 나폴레옹이 사용한 전략
* 전력이 우세한 연합군을 공격하기 위해 나폴레옹은 연합군의 중앙부로 쳐들어가 연합군을 둘로 나눔
* 둘로 나뉜 연합군을 한 부분씩 격파함

​              

### 설계 전략

* 분할(Divide) : 해결할 문제를 여러 개의 작은 부분으로 나눈다.
* 정복(Conquer) : 나눈 작은 문제를 각각 해결한다.
* 통합(Combine) : (필요하다면) 해결된 해답을 모은다.

​          

​             

​                                 

## 분할 정복 기법

​               

### Top-Down approach

> 문제의 크기 n → 크기 n/2인 부분 문제 → 부분 문제의 해 → 전체 문제의 해

* 반복(Iterative) 알고리즘 : O(n)

  ```java
  Iterative_Power(x,n) // x의 n승 구하기
  	result = 1
  	
  	For i in 1 to n
  			result = result * x
  	
  	return result
  ```

* 분할 정복 기반의 알고리즘 : O(log2n)

  ```java
  Recursive_Power(x,n)
  	if n == 1 : return x
  	if n is even //짝수라면
      	y = Recursive_Power(x,n/2)
      	return y*y
    else
      	y = Recursive_Power(x, (n-1)/2)
      	return y*y*x
  ```

  ​           

  ​          

  ​          




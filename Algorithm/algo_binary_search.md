# 이진 검색

* 선행 조건: 정렬

> 자료의 가운데에 있는 항목의 키 값과 비교하여 다음 검색의 위치를 결정하고 검색을 계속 진행하는 방법

​            

* 검색 과정
  * 자료 중앙 원소를 고른다
  * 중앙 원소의 값과 찾고자 하는 목표 값 비교
  * 중앙 원소의 값과 찾고자 하는 목표 값이 일치하면 탐색을 끝낸다
  * 목표 값이 중앙 원소 값보다 작으면 자료 왼쪽 반에 대해 탐색, 크다면 오른쪽 반에서 검색
  * 찾고자 하는 값을 찾을 때까지 위의 과정 반복

​             

​              

 ### 문제 예시 : 병뚜껑 속의 숫자 게임

* 술래가 병뚜껑 속 숫자를 확인하고 다음 사람부터 숫자를 맞히기 시작한다. 술래는 Up 또는 Down을 통해 게임에 참여한 사람들이 병뚜껑 속 숫자에 가까워지도록 힌트를 제시한다.

​          

​                

### 알고리즘 : 반복구조

```python
def binarySearch(S[], n, key):
	start = 0
	end = n - 1
	
  while start <= end:
    mid = (start + end) / 2
    
    if S[mid] == key:
    		return mid
    
    elif S[mid] < key:
    		start = mid + 1
      
    elif S[mid] > key:
    		end = mid - 1
  
  return -1 # 해를 못 찾는 경우 -1을 반환
```

​                

### 알고리즘 : 재귀구조

```python
def binarySearch(S[], start, end, key):
 
	if start > end:
    	return -1
  
  else
  		mid = (start + end) / 2
    	
      if S[mid] == key:
      		return mid
     
    	elif S[mid] < key:
      		return binarySearch(S[], mid + 1, end, key):
        
      else:
        	binarySearch(S[], start, mid - 1, key):
```

​                 

### 이진 탐색 API

* 이진탐색 API

  ```java
  int binarySearch(int[] a, int key);
  ```

  ```java
  int binarySearch(int[] a, int fromIndex,int tolndex,int key);
  ```

  

* https://docs.oracle.com/javase/8/docs/api/java/util/Arrays.html
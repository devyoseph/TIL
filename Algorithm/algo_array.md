# Array 알고리즘

​         

### 지그재그 순회

```java
int i; // 행의 좌표
int j; // 열의 좌표

for i from 0 to n-1
	for j from 0 to m-1
		Array[i][j + (m-1-2*j) * (i%2)];
		// 필요한 연산 수행
```

​        

### 델타를 이용한 2차 배열 4방 탐색

```python
dx = [-1, 1, 0, 0] // x 좌표
dy = [0, 0, -1, 1] // y 좌표

for row in range(N):
	for col in range(M): // NxM 행렬에서 
		for i in range(4): // 4 방향 탐색
    	X = col + dx[i]
      Y = row + dy[i]
      
      if X < 0 or X >= N or Y < 0 or Y >= : // 경계 처리
        continue
	
```

​                   

### 전치 행렬

```java
int arr[3][3] //3*3 행렬
int i;
int j;

for i from 0 to 2
	for j from 0 to 2
		if (i<j)
			swap(arr[i][j], ary[j][i])
```


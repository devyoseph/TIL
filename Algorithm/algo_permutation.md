# 순열의 응용

> **반복문, 재귀**를 이용해 순열을 생성할 수 있다. 하지만 다른 방법도 존재한다.

​                

### 비트마스킹을 통한 순열 생성 - 정수와 비트연산자를 사용

* int = 32개의 비트

> **< 숫자는 상태를 나타냄 >**
>
> 0 : 사용X인 상태, false
>
> 1 : 사용O인 상태, true

```java
input[ ] //숫자 배열
numbers[ ] //순열 저장 배열
  
permutation(depth, flag) // depth는 현재까지 뽑은 원소의 개수, flag 선택된 원소에 대한 비트정보 표현
 
  if depth == N // 순열 생성 완료
    
  else
    for i from 0 to N-1 //index체크를 비트의 shift 연산 / & 연산 / or 연산을 활용해 구현
      
      if (flag & 1<<i) != 0 then continue // i번째 인덱스를 이미 사용했는지를 1<<i 로 보낸다음 비교
        										        // 만약 이미 사용하고 있다면 그 자리가 1이므로 &연산시 0이 아님
        numbers[depth] = input[i]  // 만약 0이라면 i번째 인덱스를 사용하는 것이 아니므로 넣어준다
        
        permutation(depth+1, flag | 1<<i) // 다음에 보낼 때는 | 연산을 통해 합친다음 보내준다
        
    end for
      
end permutation()
```

​                  

​              

### NextPermutation : 현 순열에서 사전 순으로 다음 순열 생성

> 배열을 **오름차순으로 정렬** 후 시작한다.
>
> 과정: **오름차순 정렬에서 시작해 내림차순 정렬**로 이동하는 과정 = **끝부분부터** 탐색
>
> **현재 순열을 기준으로 다음 순열**을 구할 수 있다.

````java
1 2 3 4 → 1 2 4 3 → 1 3 2 4 → 1 3 4 2


1 3 4 2 // 1) 오른쪽 끝 2에서부터 시작(i)해서 arr[i-1] < arr[i]를 만족하는 구간을 찾는다.
1 [3] 4 2 // 3과 4가 있는 구간이 위 1) 조건을 만족한다.
1 [3] 4 2 // 3이 아닌 다시 끝부터 시작해서 다시 왼쪽으로 이동, arr[i-1] < arr[j]를 만족하는 j를 찾는다
1 [3] 4 (2) // 2는 3보다 크지 않다 
1 [3] (4) 2 // 4가 3보다 크므로 둘의 위치를 교환한다 = 현재 순열의 다음 순열의 값을 구할 수 있음
1 4 [3 2] // 3부터 오름차순한다
1 4 2 3
 
1 4 3 2 → 2 1 3 4 (오름차순 정렬: 현재부분까지 내림차순인데 양끝에서부터 자리를 바꿔주면 된다) → 2 1 4 3

````

​        

**코드**

```java
import java.util.*;
import java.io.*;
 
public class Solution {
	static int[] arr;
	
	static void swap(int i, int j) {
		int tmp = arr[i];
		arr[i] = arr[j];
		arr[j] = tmp;
	}
	
    public static void main(String[] args){
    Scanner sc = new Scanner(System.in);
    int N = sc.nextInt();
    arr = new int[N];
    
    for(int i = 0; i<N; i++) { //N까지 배열 안에 숫자집어넣기
    	arr[i] = i+1;
    }
    
    while(true) {
    	int i = N-1; //i는 끝에서부터 시작
    	int j = N-1; //j도 끝에서 부터 시작
    	
    	while(i>=1 && arr[i-1]>=arr[i]) i--; //오른쪽이 더 큰 값일 때 빠져나옴
    	i--; // i를 i-1로 변경
    	
    	if(i<0) break; //0보다 작다면 모두 내림차순이므로 종료 
    	
    	while(j>i && arr[i]>=arr[j]) j--; //i를 집고 다시 오른쪽에서 찾기
    
    	swap(i,j); //그 둘의 자리를 자꾸고
    	
    	int last = N-1;
    	i++; //i부터 내림차순 정렬
    	
    	while(i<last) {
    		swap(i,last);
    		i++;
    		last--;
    	}
    	
    	System.out.println(Arrays.toString(arr));
    	
    }
}
}
```




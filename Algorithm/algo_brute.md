# Brute Force



* 순열(permutation), 조합(combination), 부분집합(subset) 을 온전히 활용할 수 있어야 한다.

* JAVA 기준 Arrays.toString()을 디버깅 용도로 활용할 수 있다.

* 방문 체크 기록 사용하는 방법으로 가지치기 / 실행문 방식으로 스타일에 차이가 있다.

  ```java
  	    for(int i =0; i < N; i++) {
          
  	        if(v[i]) { // 가지치기: 조건을 만족하지 않으면 넘어가는 방식
  	            continue;
  	        }
          
  	        numbers[idx] = input[i];
  	        v[i] = true;
  	        
  	        perm(idx + 1);
  	        v[i] = false;
  	    }
  ```

  ```java
  	    for(int i =0; i < N; i++) {
          
  	        if(!v[i]) { // 실행문: 조건에 맞으면 바로 실행하는 방식
              numbers[idx] = input[i];
              v[i] = true;
  
              perm(idx + 1);
              v[i] = false;   
  	        }
  	    }
  ```

  ​           

  ​      

### 순열 (Permutation)

>  다수의 알고리즘 문제들은 순서화된 요소들의 집합에서 최선의 방법을 찾는 것과 관련이 있다.
>
> ex) TSP(Traveling Salesman Problem)

* 서로 다른 것들 중 몇 개를 뽑아서 한 줄로 나열하는 것
* 서로 다른 n개 중 r개를 택하는 순열은 아래와 같이 표현한다

> nPr

* 그리고 nPr 은 다음과 같은 식이 성립한다

  > nPr = n * (n-1) * (n-2) * ... * (n-r+1)

* nPn = n! 이라고 표기하며 Factorial 이라 부른다.

  > n! = n * (n-1) * (n-2) * ... * 1

​          

* 순열을 반복문으로 구현하려면 r중 반복문을 사용해야 한다. 간결한 코드를 위해 재귀로 순열을 구현해본다.

```java
numbers[] // 순열 저장 배열
isSelected[] // 인덱스에 해당하는 숫자가 사용 중인지 저장하는 배열
perm(depth) // depth: 현재까지 뽑은 순열 수의 개수
	if depth == 3
		순열 생성 완료
  else
    for i from 1 to 3
      if isSelected[i] == true then continue
      
      numbers[depth] = i
      isSelected[i] = true
      perm(depth + 1)
      isSelected[i] = false
    end for
```

​         

* java code

```java
import java.util.Arrays;
import java.util.Scanner;
public class Main {
   static int N,R;
   static int[] input;
   static int[] numbers;
   static boolean[] isSelected;
   public static void main(String[] args) {
      Scanner sc = new Scanner(System.in);
      N = sc.nextInt();
      R = sc.nextInt();
      
      input = new int[N];
      numbers = new int[R];
      isSelected = new boolean[N];
      
      for(int i = 0; i<N;i++) {
         input[i] = sc.nextInt();
      }
      
      permutation(0);
   }
   
public static void permutation(int cnt) {
   if(cnt == R) {
      System.out.println(Arrays.toString(numbers));
      return;
   }
   for(int i=0;i<N;i++) {
      if(isSelected[i]) continue;
      
      numbers[cnt] = input[i];
      isSelected[i] = true;
      permutation(cnt+1);
      isSelected[i] = false;
      }
}

}
```

​                  

​                             

### 조합

* 서로 다른 n개의 원소 중 r개를 순서없이 골라낸 것을 조합(combination) 이라고 부른다.

* 조합의 수식

  > nCr = n!/(n-r)!r! ( n >= r )

* 반복문을 통한 조합 생성

```java
for i from 1 to 4
	for j from i+1 to 4
		for k from j+1 to 4
			print i, j, k
		end for
	end for
end for
```

​        

* 재귀 호출을 이용한 조합 생성

```java
comb(depth, start) // 조합을 시도할 원소 시작 인덱스
	if depth == R
		조합 생성 완료
	else
		for i from start to n-1
			numbers[depth] = input[i]
			comb(depth+1, i+1)
		end for
end comb()
```

* java code

```java
import java.util.Arrays;
import java.util.Scanner;
public class Main {
   static int N,R;
   static int[] input;
   static int[] numbers;
   public static void main(String[] args) {
      Scanner sc = new Scanner(System.in);
      N = sc.nextInt();
      R = sc.nextInt();
      
      input = new int[N];
      numbers = new int[R];
      
      for(int i = 0; i<N;i++) {
         input[i] = sc.nextInt();
      }
      
      combination(0,0);
   }
   
public static void combination(int cnt, int start) {
   if(cnt == R) {
      System.out.println(Arrays.toString(numbers));
      return;
   }
   for(int i=start;i<N;i++) {
      
      numbers[cnt] = input[i];
      
      combination(cnt+1,i+1);
   
   }
}
}
```

​             

​                 

### 부분 집합(Power Set)

* 집합에 포함된 원소들을 선택하는 것이다
* 다수의 중요 알고리즘들이 원소들의 그룹에서 최적의 부분 집합을 찾는 것이다.
  * 예) 배낭 짐싸기(knapsack)
* 부분집합의 수
  * 집합의 원소가 n개일 때 공집합을 포함한 부분집합의 수는 2^n 개 이다.
  * 이는 각 원소를 부분집합에 포함시키거나 포함시키지 않는 2가지 경우를 모든 원소에 적용한 경우의 수와 같다.
  * 예) {1, 2, 3, 4} = 2^4 = 16가지

​      

* 생성하는 방법[반복문]

```java
for i in 1 → 0
	selected[1] ← i
	
	for j in 1 → 0
		selected[2] ← j
		
		for k in 1 → 0
			selected[3] ← k
			
			for m in 1 → 3
				if selected[i] == 1 then
					print i
```

​       

* 생성하는 방법[재귀]

```java
input[] // 숫자 배열
isSelected[] // 부분집합에 포함/비포함 여부를 저장한 배열

generateSubSet(cnt)  // cnt: 현재까지 처리한 원소개수

	if(cnt == N) // 원하는 깊이/길이에 도달 시 
		부분집합 완성
    
	else
		isSelected[cnt] = true //현재 원소를 선택한 경우에서
		generateSubSet(cnt+1) // 다음 재귀 호출
		isSelected[cnt] = false // 선택하지 않은 경우에서
		generateSubSet(cnt+1) // 다음 재귀 호출
		
```

* 문제 예시: 유한 개의 정수로 이루어진 집합이 있을 때 부분집합 중에서 모든 원소의 합이 0이 되는 부분 집합을 구하여라

  * 예시) {-7, -3, -2, 5, 8}라는 집합이 있을 때 합이 0이 되는 부분집합은 무엇이 있는가?

    ```java
    package stack;
    import java.util.Arrays;
    import java.util.Scanner;
    
    public class Main {
    	static int N;
    	static int[] input/*입력받은수*/, numbers/*선택받은 수*/;
    	static boolean[] v; //선택여부 확인
    	public static void main(String[] args) {
    		    Scanner sc = new Scanner(System.in);
    		    N = sc.nextInt(); //원소의 개수
    		    input = new int[N];
    		    numbers = new int[N];
    		    v = new boolean[N];
    		    //input data 입력 받기
    		    for(int i = 0; i < N; i++) {
    		        input[i] = sc.nextInt();
    		    }
    		    
    		    //순열 생성
    		    generateSubSet(0,0);
    		    
    		}
    
    	static void generateSubSet(int depth, int start) {
    	    //종료 조건
    	    if(depth == N) {
    	    	int sum = 0;
    	    	for(int num : numbers) {
    	    		sum += num;
    	    	}
    	    	if(sum==0) {
    	    		System.out.println(Arrays.toString(numbers));
    	    	}
    	        return;
    	    }
    	    // 선택한 상태에서 다음 원소로 보내기
    	        numbers[depth] = input[depth];
    	        generateSubSet(depth+1,depth+1);
         // 선택하지 않은 상황에서 다음 원소로 보내기
    	        numbers[depth] = 0;
    	        generateSubSet(depth+1,depth+1);
    	    
    	}
    }
    ```

    
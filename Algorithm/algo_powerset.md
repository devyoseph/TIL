

# 부분집합 응용

> **사전적 순서(Lexicographical Order)**로 생성 = 바이너리 카운팅(Binary Counting)
>
> 원소의 개수가 N개일 때 2의 N승을 바이너리 코드로 나타내면 모든 원소의 선택 경우의 수를 나타낼 수 있다.
>
> 바이너리 코드로 나타내고 2의 N승까지 도달할 때까지의 바이너리 코드들을 모두 출력하면 곧 부분집합이 된다.

​         

### 바이너리 카운팅을 통한 부분집합 생성 코드의 예

> 만약 원소의 개수가 5개라면 2진수로 배열 원소를 11111로 표현할 수 있다.
>
> 1<<5 로 100000로(2의 n+1승) 나타내면 이 수보다 작은 수가 모두 원소의 참여 여부를 나타내는 부분집합이 된다.

```java
int arr[] = {3, 6, 7, 1, 5, 4};
int n = arr.length;

for(int i = 0; i< (1 << n); i++) // 1 << n: 부분집합의 개수
{
  	for(int j = 0; j < n; j++)
    {
				if( i & (1<<j) != 0)  // i의 j 번째 비트가 1이면 j번째 원소 출력
    			System.out.print(arr[j]+" ");
    }
  	System.out.println();
}
```

​        

​         

**코드**

```java
import java.util.Arrays;
import java.util.Scanner;

public class Main {
	static int N,arr[];

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		N = sc.nextInt();
		
		arr = new int[N];
		
		for(int i=0; i<N; i++) {
			arr[i] = sc.nextInt();
		}
		
		for(int flag = 0; flag < (1<<N); flag++) {
			//원소의 비트열: 2의 n승까지 비트화하며 그 배치는 겹치지 않는다. = 모든 부분집합
			for(int i=0; i<N; i++) {
				if((flag & 1<<i) != 0) {
					System.out.print(arr[i]+" ");
				}
			}
			System.out.println();
		}
		
}
}
```


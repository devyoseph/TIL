# Stack

> 물건을 쌓아 올리듯 자료를 쌓아 올린 형태의 자료구조이다.
>
> 스택에 저장된 자료는 **선형 구조**이다. (자료 간의 관계가 1대1의 관계)
>
> **후입선출구조(LIFO, Last-In-First-Out)**
>
> * 마지막에 삽입한 자료를 가장 먼저 꺼낸다

​       

### 주요 연산

* push : 저장소에 자료를 저장한다(삽입)
* pop : 저장소에서 자료를 꺼낸다(삭제)
* peek : 스택의 top에 있는 item(원소)을 반환

​       

### JAVA에서 ```java.util.Stack```

* 주요 메서드
  * push()
  * pop()
  * isEmpty()
  * size()

​        

### 활용

* Wrapper Class 원칙

```java
Stack<Integer> stack = new Stack<>();
```

​         

* 배열은 기본형 사용

```java
Stack<int[]> stack = new Stack<int[]>();
```

​             

​                    

​       

#### 스택 응용1: 괄호 검사

#### 스택 응용2: function call

* 자바에서 함수호출은 stack 구조이다.

#### 스택 응용3: 계산기

> 중위 표기법을 후위 표기법으로 바꾼다

* 중위 표기법: A + B
* 후위 표기법: AB+ (연산자를 만나면 계산하고 종료)
  * 연산자를 만나면 pop을 두번해서 연산한 뒤 다시 집어넣는다.

```java
import java.io.*;
import java.util.*;

public class Main {
	public static void main(String[] args) {
		Stack<Integer> stack = new Stack<Integer>();
	Scanner sc = new Scanner(System.in);
	String s = sc.next();
	
	for(int i = 0 ; i < s.length(); i++) {
		char c = s.charAt(i);
		System.out.println(c);
		if(c == '+' || c == '-' || c == '*'|| c == '/') {
			int next = stack.pop();
			int prev = stack.pop();
			int result = 0;
			
			switch(c) {
			case '+': result = prev + next; break;
			case '-': result = prev - next; break;
			case '*': result = prev * next; break;
			case '/': result = prev / next; break;
			}
			stack.add(result);
			//System.out.println(prev+" "+next+"="+result);
		}else {
			stack.add(Character.getNumericValue(c));
		}
	}
	System.out.println(stack.pop());
}
}
```


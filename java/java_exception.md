# Exeption Handling

​           

## 에러와 예외

* 어떠한 원인에 의해 오동작 하거나 비정상적으로 종료되는 경우
* 심각도에 따른 분류
  * Error
    * 메모리 부족, stack overflow와 같이 일단 발생하면 복구할 수 없는 상황
    * 프로그램 비정상적 종료를 막을 수 없음 = 디버깅 필요
  * Exception
    * 읽으려는 파일이 없거나 네트워크 연결이 안되는 등 수습될 수 있는 비교적 상태가 약한 것들
    * 프로그램 코드에 의해 수습될 수 있는 상황
* Exception handling(예외 처리)
  * 예외 발생 시 프로그램의 비 정상 종료를 막고 정상적인 실행 상태를 유지하는 것
    * **예외 감지 & 예외 발생 시 동작할 코드 작성** 필요

​             

## 예외 클래스의 계층

* 컴파일러가 예외 체크를 한다

### 1. checked exception

 * 예외에 대한 대처 코드가 없으면 **컴파일이 진행되지 않음**

   ​      

### 2. Unchecked exception(RuntimeExeption)

* 예외에 대한 대처 코드가 없더라도 **컴파일은 진행됨**

​       

## 예외 처리 방법

​       

### \- try ~ catch 구문 ~ finally

```java
try{
	// 예외가 발생할 수 있는 코드
} catch(XXException e){ // 던진 예외를 받음
	// 예외가 발생했을 때 처리할 코드
} finally{ // 예외 발생 여부와 상관 없이 언제나 진행
  // try 블록에서 접근했던 System 자원의 안전한 원상 복구
}
```

* try 문에서 예외발생: **JVM이 해당 Exception 클래스의 객체 생성 후 던짐(throw)**

  ```java
  throw new XXException()
  ```

* catch 블록: 던져진 exception을 받을 수 있는 catch블록을 찾음(없다면 예외처리 실패)

  * 예외를 성공적으로 처리하면 다음 코드로 진행     

* finally 블록

  * 중간에 **return을 만나는 경우도 finally 블록을 먼저 수행** 후 리턴 실행 (try, catch 내부 return문 모두)

  ​    

* 주의사항

  * JVM이 던진 예외는 객체 형태며 catch문을 찾을 때 다형성이 적용

  * if문처럼 상위 타입의 예외가 먼저 선언되는 경우 뒤에 등장하는 catch 블록은 동작할 기회가 없다

    ```java
    try{
    
    }catch(Exeption e){ // Exception이 모든 예외의 상위 객체므로 여기서 동작
    
    }catch(YYException e){ // 동작X
    
    }
    ```

  * 상속 관계가 없는 경우는 무관

  * **상속 관계에서는 작은 범위(자식)에서 큰 범위(조상) 순으로 정의한다**

​         

​              

### \- Throwable의 주요 메서드 (Exception의 상위 클래스)

| 메서드                            | 설명                                                         |
| --------------------------------- | ------------------------------------------------------------ |
| public String getMessage()        | 발생된 예외에 대한 구체적인 메시지를 반환                    |
| Public Throwable getCause()       | 예외의 원인이 되는 Throwable 객체 또는 null 반환             |
| **public void printStackTrace()** | 예외가 발생된 메서드가 호출되기까지의 메서드 호출 스택을 출력한다. 디버깅의 수단으로 주로 활용한다. |

​               

### exception handling 기법

> 적당히 exception 별로 나누어서 처리하는 것이 좋다

* Exception 하나의 객체로 처리

  * = 예외 상황 별 처리가 쉽지 않다

    ​      

* 너무 세분화하는 경우

  *  | 를 이용해 하나의 catch 구문에서 상속관계가 없는 여러 개의 exception 처리

  ```java
  catch(ClassNotFoundException | FileNotFoundException e){
  	System.out.println("자원을 찾을 수 없습니다.: %s%n, e.getMessage")
  }
  ```

​                         

### 목적

* try 블록에서 사용한 리소스 반납
* 생성한 시스템 자원을 반납하지 않으면 장래 resource leak 발생 가능 = close 처리

    ```java
	public static void main(String[] args) {
		FileInputStream fileInput = null;
		try {
			fileInput = new FileInputStream("abc.txt"); //checked exception 발생 가능
			fileInput.read();
		} catch(IOException e){
			e.printStackTrace();
		} finally {
			if(fileInput != null) {
				try {
					fileInput.close();
				} catch(IOException e){
					e.printStackTrace();
				}
			}
		}
	}
    ```

* finally 를 같이 사용시 코드의 복잡성이 증가한다

​       

### try-with-resources

* **try 구문에 (소괄호)가 붙어있는 형태**

* JDK 1.7 이상에서 리소스의 자동 close 처리

  ```java
  try(리소스_타입1 res1 = 초기화; 리소스_타입2 res2 = 초기화; ...){ //finally에서 close가 자동 처리
  	// 예외 발생 코드
  } catch(Exception e){
  	// exception handling 코드
  }
  ```

* try 선언문에 선언된 객체들에 대해 자동 close 호출(finally 역할)

  * 단 해당 객체들이 AutoCloseable interface를 구현할 것
    * 각종 I/O steam, socket, connection...
  * 해당 객체는 try 블록에서 다시 할당 불가

  ```java
  public void useStreamNewStyle(){
  	try(FileInputStream fileInput = new FileInputStream("abc.txt")){
  		System.out.println("FileInputStream이 생성되었습니다.");
      fileInput.read();
    } catch(IOException e){
  		System.out.println("파일 처리 실패");
    }
  }
  ```

​        

​        

## throws 의 활용

> 처리 위임: method에서 처리할 하나 이상의 예외를 호출한 곳으로 전달

* 예외가 없어지는 것이 아니라 단순히 전달됨

* 예외를 전달받은 메서드는 다시 예외 처리의 책임 발생

  ```java
  void exceptionMethod() throws Exception1,Exception2{
  	//예외 발생 코드
  }
  
  void methodCaller(){
  	try{
  		exceptionMethod();
  	}catch(Exception e){}
  }
  ```

* 처리하려는 예외 조상 타입으로 throws 처리 가능

​           

### 로그 분석과 예외의 추적

* Throwable의 printStackTrace는 메서드 호출 스택 정보 조회 가능
  * 최초 호출 메서드에서부터 예외 발생 메서드까지의 스택 정보 출력
* 꼭 확인할 정보
  * 예외 종류, 예외 원인, 디버깅 출발점(라이브러리는 과감히 건너뛰기)

​                  

#### 왜 예외를 처리해야 하는가?

* API가 제공하는 메서드들은 사전에 예외가 발생할 수 있음을 선언부에 명시하고 프로그래머가 그 예외에 대처하도록 강요

​              

#### 메서드 재정의와 throws

* Override시 부모 예외보다 더 큰 예외를 자식이 던질 수는 없다
  * 자식에서 Exception을 던지는 경우 = 메서드 재정의 X
* 선언부가 다 같아야 한다
  * 접근제한자(부모 이상), 메소드명, 매개변수 순서, 변수형

​        

​                 

## 사용자 정의 예외

> API에 정의된 exception 이외에 필요에 따라 사용자 정의 예외 클래스 작성

* 대부분 Exception 또는 RuntimeException 클래스를 상속받아 작성

  * checked exception 활용: 명시적 예외 처리 또는 throws 필요

    * 코드는 복잡해지지만 처리 누락 등 오류 발생 가능성 저하

  * runtime exception 활용: 묵시적 예외 처리 가능

    * 코드가 간결해지지만 예외 처리 누락 가능성 발생

    ​      

* 사용자 정의 예외를 만들어 처리하는 장점

  * 객체의 활용: 필요한 추가 정보, 기능 활용 가능
  * 코드의 재사용: 동일한 상황에서 예외 객체 재사용
  * throws 메커니즘 이용: 중간 호출 단계에서 return 불필요

```java
class MyException extends Exception{ //Exception을 상속받고
	public MyException(String name){ //생성자를 통해 super를 호출하며 메시지를 보냄
		super(name+ "에 해당하는 것은 존재하지 않습니다"); //Exception의 getMessage로 보내줍니다
	}
}
```

* 예외 발생시키고 던지기

```java
throw new FruitNotFoundException(name);
```

​            
# 4-2. StringBuffer클래스와 StringBuilder 클래스

구분: 4. java.lang패키지와 유용한 클래스
완료: No
작성자: 양요셉
태그: Immutable, Mutable

[참고문헌]

[https://velog.io/@heoseungyeon/StringBuilder와-StringBuffer는-무슨-차이가-있는가](https://velog.io/@heoseungyeon/StringBuilder%EC%99%80-StringBuffer%EB%8A%94-%EB%AC%B4%EC%8A%A8-%EC%B0%A8%EC%9D%B4%EA%B0%80-%EC%9E%88%EB%8A%94%EA%B0%80)

[https://codevang.tistory.com/121](https://codevang.tistory.com/121)

Java 에서 문자열을 다루는 대표적인 클래스는 **String, StringBuilder, StringBuffer** 가 있다.

3가지 클래스는 각자 차이점이 존재한다.

- **String** VS **StringBuilder** , **StringBuffer**
- ***String Constant Pool***
- **StringBuilder** VS **StringBuffer**
- **String** 을 사용해야 할 때
- **StringBuilder** 를 사용 해야 할 때
- **StringBuffer** 를 사용해야 할 때

## 1. **String** VS **StringBuilder** , **StringBuffer**

---

### String

- 불변성을 갖는다. → Immutable 하다.

### StringBuilder, StringBuffer

- 가변성을 갖는다. → mutable 하다.

String, StringBuilder, StringBuffer 타입의 변수를 선언하고 문자열을 수정하기 전에 **객체의 주소를 해싱하여 값을 반환**해주는 **hashCode()**의 반환 값을 출력하고, 문자열을 수정한 뒤 hashCode()의 반환값을 출력하면 다음과 같습니다.

```java
String 객체의 주소 : 3541040
StringBuilder 객체의 주소 : 1468177767
StringBuffer 객체의 주소 : 434091818
=============================
String 객체의 주소 : 1758230625
StringBuilder 객체의 주소 : 1468177767
StringBuffer 객체의 주소 : 434091818
```

**1-1. *String Constant Pool***

String 변수에 값을 할당하는 방법은 2가지

- 리터럴 변수를 대입 : `""`
- new 키워드를 사용 : `new String("")`

![string 비교.png](4-2%20StringBuffer%E1%84%8F%E1%85%B3%E1%86%AF%E1%84%85%E1%85%A2%E1%84%89%E1%85%B3%E1%84%8B%E1%85%AA%20StringBuilder%20%E1%84%8F%E1%85%B3%E1%86%AF%E1%84%85%E1%85%A2%E1%84%89%E1%85%B3%20a796b9dfadcd4d269139c2ce9877447c/string_%25E1%2584%2587%25E1%2585%25B5%25E1%2584%2580%25E1%2585%25AD.png)

## ****2. StringBuilder VS StringBuffer 공통점****

---

- String 과 달리 **StringBuilder**와 **StringBuffer**는 둘 다 크기가 유연하게 변하는 **가변성**
을 갖는다.
- 두 클래스 모두 **AbstractStringBuilder** 라는 추상 클래스를 상속받아 구현
    
    ```java
    public final class StringBuilder extends **AbstractStringBuilder
    	implements java.io.Serializable, Comparable<StringBuilder>, CharSequence {
    }**
    ```
    
    - StringBuffer를 예시로 들었지만 StringBuildereh 동일하다.
- StringBuilder , StringBuffer에 문자열을 추가하게 되면 추가할 문자열의 크기(길이)만큼 현재의 문자열을 저장하는 배열의 공간을 늘려주고, 늘려준 공간에 추가할 문자열을 넣어주는 방식
    - 위에서 살펴본 내부동작을 통해 값이 변경되더라도 **같은 주소공간을 참조**하게 되는 것이며, **값이 변경되는 가변성**을 띄게 되는 이유이다.

## 3****. StringBuilder VS StringBuffer 차이점****

---

- StringBuffer :  `synchronized` 키워드 사용
    - `synchronized` 키워드는 여러개의 스레드가 한 개의 자원에 접근할려고 할 때, 현재 데이터를 사용하고 있는 스레드를 제외하고 **나머지 스레드들이 데이터에 접근할 수 없도록 막는 역할**
        
        ```java
        @Override
        public synchronized StringBuffer append(CharSequence s) {
            toStringCache = null;
            super.append(s);
            return this;
        }
        ```
        
- StringBuilder : multi-thread 환경에 취약
    
    ```java
    @Override
    public StringBuilder append(String str) {
        super.append(str);
        return this;
    }
    ```
    

## 4. StringBuilder/Buffer 내부 메서드

[ String 클래스와 동일 메소드 ]

- charAt() - 특정 인덱스 위치의 문자 반환
- indexOf() / lastIndexOf() - 문자열 검색해서 위치 반환
- length() - 문자열 길이 반환
- replace() - 검색된 문자열 교체
- substring() - 특정 인덱스 범위 내 문자열을 복사해서 새로 생성된 인스턴스 반환
- toString() - 문자열 출력

[ append() ]

- 문자열 추가
    
    ```java
    StringBuilder a = new StringBuilder("Hello");
    		
    a.append(" World");
    System.out.println(a); 		// "Hello World"
    ```
    

[ insert() ]

- 특정 위치에 문자열 삽입
- 매개변수로 받은 인덱스 위치부터 문자열을 삽입해줌
    
    ```java
    StringBuilder a = new StringBuilder("He World");
    		
    a.insert(2, "llo");
    System.out.println(a);			// "Hello World"
    
    a.insert(5, 55);
    System.out.println(a); 			// "Hello55 World"
    ```
    

[ delete() ]

- 매개변수로 전달받은 인덱스 사이의 문자열 제거
- parameter : 인덱스 시작점, 인덱스 끝점 + 1
- 문자열에서 시작과 끝은 항상 "시작 <= 범위 < 끝" 형태
    
    ```java
    StringBuilder a = new StringBuilder("Hello");
    
    a.append(" World");
    System.out.println(a);  // "Hello World"
    
    a.delete(6, 9);         // (6~8 삭제)
    System.out.println(a);  // "Hello ld"
    ```
    

[ deleteCharAt() ]

- 특정 인덱스의 한 문자만 삭제
- delete() 메소드에서 범위를 한 글자만 잡는 것과 동일한 효과

[ capacity() ]

- String 클래스와 다르게 char[] 배열 사이즈를 여유 있게 잡아둠
- 현재 char[] 배열이 가진 사이즈 정보를 반환
- length()는 실제 데이터가 들어있는 문자열 자체의 길이이고 capacity()는 현재 배열 사이즈
- append() 등 문자열 조정할 때 배열 사이즈가 자동으로 변경됨

```java
StringBuilder a = new StringBuilder("Hello");
		
		System.out.println(a.length());		// 5
		System.out.println(a.capacity()); 	// 21
		
		a.append(" World");
		System.out.println(a);             	// "Hello World"
		
		System.out.println(a.length()); 	// 11
		System.out.println(a.capacity()); 	// 21
		
		a.append(" Hi everybody!!!!");
		System.out.println(a);             	// Hello World Hi everybody!!!!

		System.out.println(a.length()); 	// 28
		System.out.println(a.capacity()); 	// 44

```
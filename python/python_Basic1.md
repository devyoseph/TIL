### 컴퓨터(Computer)

Calculation + remember

### 프로그래밍(Programming)

program: 명령들의 모음

### 언어

컴퓨터에게 명령하기 위한 약속

ex) 과자를 먹는다

* 선언전 지식: 사실에 대한 내용
* 명령적 지식: How-to

### 파이썬이란?

* 같은 작업에 대해서도 C나 자바보다 학습이 쉽다

* 인터프리터 언어

#### 파이썬 개발환경 종류

1) 대화형 환경: 기본 interpreter, Jupyter Notebook
2) 스크립트 실행(평가용)

##### Jupyter Lab

웹 브라우저 환경에서 코드를 작성할 수 있는 오픈소스

##### Text editor

메모장 ex) Visual Studio Code

##### IDE

통합 개발 환경 ex) Pycharm



### 기초 문법

* 코드를 '어떻게 작성할지'에 대한 가이드라인
* 파이썬에서 제안하는 스타일 가이드 ex) PEP8
* 기업, 오픈소스 등에서 사용돠는 스타일 가이드 ex) Google Style guide 등
* ' 나 "를 혼용하지 말 것
* 들여쓰기: 4칸(Tab키 1번): 탭 키를 사용하면 계속 탭키를 사용한다

#### # 변수(Variable)

방법: 할당(Assignment)연산자를 통해 값을 할당: dust = 60, [ 이름 ] = [ 값 ]

개념: 컴퓨터 메모리 어딘가에 저장되어 있는 객체를 참조하기 위해 사용되는 이름

* 객체(object): 숫자, 문자, 클래스 등 값을 가지고 있는 모든 것
* 파이썬은 객체지향 언어이며 모든 것이 객체로 구현되어 있음

type()

* 변수에 할당된 값의 타입

id()

* 변수에 할당된 값의 고유한 아이덴티티 값, 메모리 주소

del()
* 변수를 메모리에서 제거

변수연산

```python
i = 5
j = 3
s = '파이썬'

i+j
i*j
'안녕'+s
s = s*3
s += '은 재밌다'
```

* 동시 할당

```python
x = y = 1004
print(x,y)
```

* 동시 할당2

```python
x, y = 1, 2
print(x,y)
```

* 동시 할당3

```python
x, y = 10, 20
# 위 두 변수의 값을 바꿔서 저장하시오
x, y = y, x
```



식별자(Identifier): 변수의 이름 짓기, 객체를 식별하는데 사용하는 이름

* 규칙

>* 식별자의 이름은 영문 알파벳, 언더스코어(_), 숫자로 구성
>* 첫 글자에 숫자가 올 수 없음
>* 길이제한이 없고, 대소문자 구분
>* 예약어는 사용할 수 없음, 내장함수 모듈 이름 또한 사용불가
>* Camel Case / Snake Case: useThis / use_this

사용자 입력

* Input( [ prompt ] ): 사용자로부터 값을 즉시 입력 받는다
* 출력값이 문자열임을 명심한다

주석(Comment)

* 한 줄 주석: #
* 여러 줄의 주석: ''' 또는 """
* 특수한 형태의 주석: Docstring



#### 파이썬 자료형(Python Datatype)

Boolean / Numeric(Int, Float, Complex) / String



None

* 값이 없음을 표현하기 위한 타입인 None Type

불린(Boolean)

* True / False 값을 가진 타입은 boolean
* False: 0, 0.0, (), [], {}, '', None
* True: ' ', [0], {1}
* bool() 함수: 특정 데이터가 True인지 False인지 검증

> bool(0) # False
>
> bool('') # False
>
> bool( [0] ) # True

정수(Int)

* 모든 정수의 타입은 int: 파이썬 3부터 long 타입은 없고 모두 int로 표현된다
* 매우 큰 수를 나타낼 때 오버플로우가 발생하지 않음: 가용 메모리 사용

진수(Int) 표현: box로 외우자

* 2진수: 0b

```python
0b10 # 2
```

* 8진수: 0o

```python
0o30 # 24
```

* 16진수: 0x

실수(Float): 정수가 아닌 모든 실수

* 부동소수점: 실수를 컴퓨터가 표현하는 방법 = 2진수(비트)로 숫자를 표현
* 부동소수점에서 실수 연산 과정에서 발생 가능: 값 비교하는 과정에서 정수가 아닌 실수인 경우 주의

```python
# 같은 값일까요?
3.14 - 3.02 == 0.12
# 0.120000000001 가 나와서 False
```

Math 모듈

* abs()
* math.isclose(a, b)
* 입실론: sys.float_info.epsilon

복소수(Complex)

문자열(String Type): 모든 문자는 str 타입, 문자열의 나열이다

* 문자열은 작은 따옴표(')나 큰 따옴표(")를 활용하여 표기
* Immutable(불변)

```python
a = 'my string'
a[-1] = '!'
```

* Iterable(반복)

```python
a = '123'
for char i in a
	print(i)
```

* 삼중따옴표(Triple Quotes): '''

* Escape sequence: 문자열 내에서 특정 문자나 조작을 위해 역슬래시( \ )를 활용해 구분

  ```python
  print('철수가 말했다 \n \'안녕\''); # \n : 줄바꿈
  ```

* String Interpolation (문자열 사이에 변수)

```python
print('Hello %s' % name)
print('Hello {} 성적은{}'.format(name,score))
print(f'Hello {name} 성적은{score}')
```

* f-string 사용 예

```python
f'오늘은 {today:%y}년 {today:%m}월 {today:%d}일'
```



컨테이너(Container) 정의

정의: 여러 개의 값을 담을 수 있는 것(객체)으로, 서로 다른 자료형을 저장할 수 있음

예시: List, tuple

분류: 순서가 있는 데이터(Ordered): 리스트(가변), 튜플, 레인지 vs 순서가 없는 데이터(비시퀀스): 세트(가변), 딕셔너리(가변)



시퀀스형 컨테이너

리스트

* 정의: 순서를 가지는 0개 이상의 객체를 참조하는 자료형
* 특징: 생성된 이후 변경 가능, 유연성 때문에 가장 흔히 사용
* 생성: [대괄호] 혹은 소괄호
* 접근: 인덱스로 접근 가능 = 0부터 시작, Negative index = 맨 뒤(-1)부터 -2, -3...

```python
my_list = []
another_list = list()

location = ['서울','대전','부울경']

boxes = ['A','B',['apple','banana']] # 2차원 리스트

len(boxes) # 3

boxes[2] # ['apple','banana'], boxes[-1]과 같은 값

boxes[2][-1] # banana

boxes[-1][1][0] # b
```



튜플(Tuple)

* 정의: 순서를 가지는 0개 이상의 객체를 참조하는 자료형
* 특징: 불변, 소괄호만 사용

```python
a = (1, 2, 3, 4)
b = tuple((1, 2, 3, 4))
# a[1] = 3 으로 하면 에러가 발생
```

* 생성 주의사항

  > 단일 항목의 경우: 하나의 항목으로 구성된 튜플은 값 뒤 쉼표 붙인다 (a = 1,)
  >
  > 복수 항목의 경우: 쉼표 불필요 (b = 1, 2, 3)

* 튜플 대입(Tuple assignment): 우변의 값을 좌변의 변수에 한번에 할당하는 과정

  > 일반적으로 파이썬 내부에서 사용
  >
  > x, y = 1, 2 은 사실
  >
  > x, y = (1, 2)

레인지(Range): 숫자의 시퀀스를 나타내기 위해 사용

* 기본형: range(n) = 0부터 n-1까지의 숫자의 시퀀스
* 범위 지정: range(n, m) = n부터 m-1까지 숫자의 시퀀스
* 범위 및 스텝 지정: range(n,m,k) = 시퀀스 간격이 k (역순 표현을 -1로 가능)

```python
list(range(6, 1, -1))
```



패킹/언패킹 연산자

​	패킹

		* 대입문의 좌변 변수에 위치
		* 우변의 객체 수가 좌변의 변수수보다 많을 경우 사용

​	언패킹



##### 비시퀀스형 컨테이너

셋(Set)

* 정의: 순서없이 0개 이상의 해시가능한 객체를 참조하는 자료형
* 특징: 해시 가능한 객체(immutable)만 담을 수 있으며 가변자료, 집합 연산 가능
* 생성: {중괄호} 혹은 set()을 통해 생성

```python
{1, 2, 3, 4, 5}

blank = {} # 빈 중괄호는 Dictionary

blank_set = set() # 빈 set은 set()을 활용

len(set(my_list)) # 중복되는 자료 제거
# 하지만 set은 내부 자료의 순서를 구할 수 없다는 것을 주의한다
```



딕셔너리(Dictionary)

* 정의: 순서 없이 키-값(key-value) 쌍으로 이뤄진 객체를 참조하는 자료형
* 해시가능한 불변 자료형만 가능하며 수정 가능하다
* 각 키의 값(values): 레인지, 튜플 등 어떠한 형태도 가능하다. 하지만 값을 통해 key를 찾을 수는 없다
* key는 고유한 값이며 중복되지 않아야하고 식별자 규칙을 따른다.
* 생성

```python
dict_c= {'a':'apple', 3: '삼', '지역': ['서울', '광주']}
```



#### 형 변환

자료형 변환(Typecasting)

* 암시적 형 변환(implicit): 사용자가 의도X, 파이썬 내부적으로 자료형 변환

```python
True + 3 # 4

3 + 5.0 # 8.0

3 + 4j + 5 # 8 + 4j
```

* 명시적 형 변환(Explicit): 사용자가 의도O, 파이썬 외부적으로 자료형 변환

```python
int('3') + 4

float('3')
```

![image-20220117110108265](파이썬기초.assets/image-20220117110108265.png)

* dictionary는 형변환하면 key부분만 나온다



#### 연산자(Operator)

연산자의 종류: 산술 연산자, 비교 연산자, 논리 연산자, 복합 연산자 등

* 산술 연산자(Arithmetic Operator): 기본적인 사칙연산 및 수식 계산 ( //, %, dived )

```python
print(5 //2)
print(17 % 4)
```

* 비교 연산자(Comparison Operator): 값을 비교하며 True, False를 리턴함
* 논리 연산자(Logical Operator): and / or / not : 결과가 확실한 경우 두 번째 값은 확인하지 않음

```python
print(not 'hi') # False

print( 5 or 3 ) # 5

print( 5 and 3) # 3

print( 5 and 0) # False
```

* 복합 연산자(In-Place Operator)
* 식별 연산자(Identity Operator): is 연산자를 통해 동일한 객체인지 확인한다
* 맴버십 연산자(Membership Operator): 포함 여부 확인

```python
in [3, 2]
in (1, 2, 'hi')
'a' in 'apple'
```

* 시퀀스형 연산자(Sequence Type Operator)

```python
[1, 2] + ['a']
(1, 2) + ('a',)

[0]*8

(1, 2)*3
```

* 기타: 인덱싱(Indexing): 시퀀스의 특정 인덱스 값에 접근 (인덱스가 없는 경우 IndexError)

```python
[1, 2, 3][2]

(1, 2, 3)[0]
```

* 슬라이싱(Slicing)

```python
[1, 2, 3, 4][1:4] # 포함 : 미포함

[1, 2, 3, 4][0:4:2] # 원하는 간격 = 2

[1, 2, 3, 4][-3:-1] # 2 3 4

[1, 2, 3, 4][0:] # 0부터 끝까지

[1, 2, 3, 4][::] # range와 비슷

[1, 2, 3, 4][::-1] # 역순 가져오기
```

* set 연산자: | (합집합), & (교집합), - (여집합), ^ (대칭자)
* 연산자 우선순위: ( )가 제일 우선이기 때문에 ( )를 활용한다



#### 프로그램 구성 단위

* 식별자(identifier)
* 표현식(Expression): 새로운 데이터 값을 생성하거나 계산하는 코드 조각
* 문장(Statement): 파이썬이 실행 가능한 최소한의 코드 단위
* 함수(Function): 특정 명령을 수행하는 묶음
* 모듈(Module)
* 패키지(Package)
* 라이브러리(Library)

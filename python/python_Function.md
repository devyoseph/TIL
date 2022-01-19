### 함수(Function)

##### 함수의 정의

* 특정한 기능을 하는 코드의 조각(묶음)
* 특정 명령을 수행하는 코드를 매번 다시 작성하지 않고, 필요 시에만 호출하여 사용

##### 사용자 함수

* 구현되어 있는 함수가 없는 경우, 사용자가 직접 작성 가능

```python
def fuction_name(parameter):
	# code
	return returning_value
```

##### 함수를 사용하는 이유

* 표준편차: statistics.pstdev(values)



##### 함수의 기본 구조

* 선언과 호출(define & call)
* 입력(input)
* 문서화(Doc-String)
* 범위(Scope)
* 결과값(Output)

###### 1. 선언과 호출(define & call)

함수 선언은 `def`코드 사용

```python
def foo():
	return True
```

함수 호출은 `함수명()` 사용

```python
foo() 
```

###### < 실습 문제 >

* 입력 받은 수를 세제곱하여 반환하는 함수 cube를 작성하시오

  ```python
  def cube(number):
      return number**3
  print(cube(2),cube(100))
  ```



###### 2 . 함수의 결과값(output)

* Void fuction: 명시적인 return 값이 없는 경우, None을 반환하고 종료

  ```python
  def void_product(x, y):
      print(f'{x} * {y} = {x*y}')
  void_product(3,5)
  # 3 * 5 = 15
  
  print(void_product(3,5))
  # None
  # void 함수의 결과값은 None이다
  ```

* Value returning function: 함수 실행 후, return문을 통해 값 반환 (return시 값 반환 후 바로 함수를 종료하므로 **빠져나가기** 용도로도 사용한다)

  ```python
  def returning_product(x, y):
      return x*y
  returning_product(3,5) # return은 출력이 아님을 주의한다
  print(returning_product(3,5)) # 15
  ```

###### Output 주의사항

* return 문을 두 개 이상 사용하지 않는다

  ```python
  def calculation (x, y):
      return x-y
      return x*y
  print(calculation(3,5))
  # -2
  # return문을 만나면 즉시 종료
  ```

* 두 개 이상의 값 반환하는 법: 튜플 사용

  ```python
  def calculation (x, y):
      return x-y,x*y
    
  print(calculation(3,5))
  # (-2, 15)
  ```

* < 실습 예제 >

  너비와 높이를 입력 받아 사각형의 넓이와 둘레를 튜플로 반환하는 함수 rectangle을 작성하시오

  ```python
  def rectangle(x, y):
      return 2*(x+y),x*y
    
  print(rectangle(4,5))
  ```



###### 3. 함수의 입력(Input)

* Parameter: 함수를 실행할 때 함수 내부에서 사용되는 식별자

* Argument: 함수를 호출할 때 넣어주는 값

  * 필수 Argument: 반드시 전달되어야 하는 값

  * 선택 Argument: 전달하지 않아도 되는 값

    → default(기본)값을 설정한다

  ```python
  def say_anything(anything): # parameter
      print(f'hello {anything}')
  
  say_anything('python') # argument
  ```

  ```python
  def plus_func(x,y=0): #Default
      return x+y
    
  print(plus_func(3,5))
  print(5)
  ```

* Packing / Unpacking

  ```python
  def add(**kwargs):
      for key, value in kwargs.items():
          print(key,':', value)
  
  # add(a,b,c,d): 자동으로 묶이는 것은 아니다
  
  add(a='first',b='second',c='third',d='fourth')
  ```

* 함수 주의사항: 위치 인자는 맨 앞에

  ```python
  def greeting(name='John', age)
  # 오류 발생
  
  # 기본 인자를 먼저 적용하기 때문에
  # greeting(1)을 입력하면 name을 말하는건지 age를 말하는 건지 모르기 때문
  
  
  # keyword argument 다음에 position argument 활용 불가
  ```



###### 4. 함수의 범위(Scope)

* 함수는 코드 내부에 local scope를 생성

* 그 외의 공간은 global scope로 구분

  ><scope>
  >
  >* global scope: 어디서든 참조 가능한 공간
  >* local scope: 함수가 만든 scope, 함수 내부에서만 참조 가능

  ><varaible>
  >
  >* global variable: global scope에 정의된 변수
  >* local variable: local scope에 정의된 변수

###### 변수 수명주기(lifecycle)

* 변수는 각자의 수명주기(lifecycle)가 존재
  * built-in scope: 파이썬 실행 이후 영원히 유지
  * global scope: 모듈 호출 이후/인터프리터 끝날 때까지
  * local scope: 함수 호출시 생성, 함수 종료까지 유지

###### 이름 검색 규칙(Name Resolution)

* 파이썬에서 사용되는 이름(식별자)들은 이름 공간(namespace)에 저장되어있다
* LEGB
  * Local scope: 함수
  * Enclosed scope: 특정 함수의 상위 함수
  * Global scope: 함수 밖의 변수, Import 모듈
  * Built-in scope: 파이썬 안 내장된 함수/속성
* 함수 내에서는 바깥 Scope 변수에 접근 가능하나 수정은 할 수 없다(global문 사용시 변경 가능).

###### global문

* global문 전에 변수를 사용하지 않도록 한다

* 이전에 만들어지지 않은 변수라도 global로 생성

  > 하지만 함수를 꼭 실행해야 적용되는 제약 존재
  >
  > ```python
  > def func():
  >     global a
  >     a=5
  >     print(a)
  > # func()    
  > print(a)
  > # 함수를 실행하지 않으므로 변수 또한 생성되지 않아서 오류가 발생한다
  > ```

```python
a = 10
def func():
    global a
    a = 3
print(a)
func()
print(a)
```

###### nonlocal문

* global을 제외하고 가장 가까운 scope의 변수 연결
* nonlocal에 나열된 이름은 같은 블록에서 nonlocal 앞에 등장할 수 없음

* nonlocal에 나열된 이름은 parameter, for, 루프 대상, 클래스/함수 정의 등으로 정의되지 않아야 한다.
* global과는 달리 이미 존재하는 이름과의 **연결**만 가능하다.



##### 5. 함수의 문서화(Docstring)

* 함수나 클래스의 설명

  ```python
  def ptptpt(num):
  """
  instant fuction
  """
  ```

###### Naming Convention

* 좋은 함수와 parameter 이름을 짓는 방법
  	* 상수 이름은 전체 대문자
  	* 클래스 및 예외의 이름은 첫글자만 대문자
  	* 이외 나머지는 소문자 또는 밑줄로 구분
* 스스로를 설명
  * 함수의 이름만으로 어떤 역할을 하는지 파악가능
  * 어떤 기능을 수행하는지, 결과값으로 무엇을 반환하는지 등
* 약어 사용을 지양
  * 보편적으로 사용하는 약어를 제외하고 가급적 약어 사용을 지양한다



##### 함수 응용

###### 내장 함수(Built-in Fun)

* 파이썬 인터프리터에서는 항상 사용할 수 있는 많은 함수와 형(type)이 내장되어 있음

> **map( function, iterable)**
>
> : 순회 가능한 데이터구조(iterable)의 모든 요소에 함수(function)적용하고 그 결과를 map object로 반환
>
> ```python
> numbers = [1, 2, 3]
> result = map(str, numbers)
> print(result, type(result))
> print(list(result))
> ```
>
> 알고리즘 풀이 시 input 값들을 숫자로 바로 활용하고 싶을 때
>
> ```python
> n, m = map(int, input().split())
> # n = 3, m = 5
> 
> print(type(n), type(m))
> # <class 'int'> <class 'int'>
> ```



> **filter(function, iterable)**
>
> : 순회 가능한 데이터구조(iterable)의 모든 요소에 함수(function)적용하고, 그 **결과가 True**인 것들을 filter object로 반환
>
> ```python
> def odd(n):
>     return n % 2
> numbers = [1, 2, 3]
> result = filter(odd, numbers)
> 
> print(result, type(result))
> print(list(result))
> 
> # <filter object at 0x100d93f70> <class 'filter'>
> [1, 3]
> ```



> **zip(iterables)**
>
> : 복수의 iterable을 모아 튜플을 원소로 하는 zip object를 반환
>
> ```python
> girls = ['Jane', 'Dorothy']
> boys = ['justin', 'eric']
> pair  = zip(girls,boys)
> 
> print(pair,type(pair))
> print(list(pair))
> # <zip object at 0x104b57440> <class 'zip'>
> [('Jane', 'justin'), ('Dorothy', 'eric')]
> ```



> **lamda [parameter] : 표현식**
>
> *  람다함수: 표현식을 계산한 결과값을 반환하는 함수로 이름이 없는 함수여서 익명함수라고도 불림
>
> * 특징: return 문을 가질 수 없음, 간편 조건문 외 조건문이나 반복문을 가질 수 없음
>
> * 장점: 함수를 정의해 사용하는 것보다 간결하게 사용 가능, def를 사용할 수 없는 곳에서 사용 가능
>
>   ```python
>   rectangle_area = lambda x, y : x*y
>   
>   print(rectangle_area(3,5))
>   # 15
>   ```



> **재귀 함수(recursive function)**
>
> : 자기 자신을 호출하는 함수
>
> * 알고리즘 설계에서 유용하다
>
> * 코드의 가독성 증가
>
> * 1 개 이상의 base case(종료 상황)이 존재하며 수렴하도록 가정한다
>
> * 메모리 스택이 넘치는 stack overflow를 주의한다
>
> * 파이썬의 최대 재귀 깊이는 1000번이다
>
>   (Maximum recursion depth)
>
> ```python
> def factorial(n):
>     if n==0 or n==1:
>         return 1
>     else:
>         return n * factorial(n-1)
>       
> print(factorial(4))
> # 24
> ```

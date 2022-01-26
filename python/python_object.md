# OOP(Object Oriented Programming)

> \- **객체 지향 프로그래밍**, 파이썬은 모두 **객체**(Object)로 이루어져 있다.
>
> \- 객체 지향 프로그래밍이란? 프로그램을 여러 개의 독립된 객체들과 그 객체들 간의 상호작용으로 파악하는 프로그래밍 방법
>
> *  데이터와 기능(메소드) 분리, 추상화된 구조(인터페이스)
>
> \- 객체 = 속성(Attribute) + 기능(Method)
>
> \- 객체는 특정 타입의 인스턴스(instance)이다
>
> * ex) 10은 int의 인스턴스, '애플'은 str의 인스턴스 

​    

* 객체지향의 장점

  \- 프로그램을 유연하고 변경이 용이하게 만듭니다.

  \- 소프트웨어 개발과 보수를 간편하게하며 직관적인 코드 분석을 가능하게 합니다.

   

### 기본 문법

* 클래스 정의 ```class MyClass:```
* 인스턴스 생성 ```my_instance = MyClass()```
* 메소드 호출 ```my_instance.my_method()```
* 속성 ```my_instance.my_attribute```

   

#### 메소드

* 특정 데이터 타입/클래스의 객체에 공통적으로 적용 가능한 행위(함수)

  ```python
  class Person:
  	def talk(self):
  		print('안녕')
  	
  	def eat(self, food):
  		print(f'{food}를 냠냠')
  ```

     

### 객체 비교하기

* 객체의 값 비교: ```==```

* 객체의 주소 비교: ```is``` ex) is None

   

## 인스턴스

### 인스턴스 변수

* 인스턴스가 개인적으로 가지고 있는 속성(Attrubute)
* 각 인스턴스들의 고유한 변수
* 생성자 메소드에서 self.<name>으로 정의

### 인스턴스 메소드

* 인스턴스 변수를 사용하거나, 인스턴스 변수의 값을 설정하는 메소드
* 클래스 내부에 정의되는 메소드의 기본
* 첫번째 인자로 인스턴스 자기자신(self)이 전달됨 (self말고 다른 이름을 사용할 수 있으나 잘 하지 않는다)

   

### self

> 인스턴스 조작을 위해서는 인자(argument)로 넘겨주어야하는데 인스턴스 내부의 값을 조작하기 위해선 인스턴스 자기 자신을 넣어주어야 한다. 파이썬은 자동으로 이를 자동으로 넣어주며, 값을 받아주지 않으면 오류가 발생하기 때문에 내부 메소드에서 self를 적어주어야 한다.

* 인스턴스 자기자신
* 파이썬에서 인스턴스 메소드는 호출 시 첫번째 인자로 인스턴스 자신이 전달되도록 설계
* 매개변수 이름으로 self를 첫번째 인자로 정의/암묵적인 규칙

   

### 생성자 메소드

* 인스턴스 객체가 생성될 때 자동으로 호출되는 메소드

* 인스턴스 변수들의 초기값을 설정

  * 인스턴스 생성
  * \_\_init\_\_메소드 자동 호출

  ```python
  class Person:
  	
  	def __init__(self):
  		print('응애!')
      
  person1 = Person()
  # 응애! 가 출력
  ```

  ```python
  class Person:
  
      def __init__(self, name, age=1):
          self.name = name
          self.age = age
  
  person = Person('홍길동',20)
  print(person.name)
  # 홍길동
  
  person2 = Person('철수')
  print(person2.age)
  # 1
  ```

   

### 소멸자 메소드

* 인스턴스가 소멸될 때 실행되는 메소드

```python
def __del__(self):
```

```python
class Person:

    def __init__(self):
        print('응애!')

    def __del__(self):
        print('으억..')


person = Person()
# 응애!
del person
# 으억..
```

   

### 매직 메소드

* Double underscore(\_\_)가 있는 메소드는 특수한 동작을 수행한다(=스페셜, 매직 메소드).

* 특정 상황에 자동으로 불리는 메소드

  > str, len, repr, lt, le, eq, gt 등

| 매직 메소드 | 기능                                                       |
| ----------- | ---------------------------------------------------------- |
| \_\_str\_\_ | 해당 객체의 출력 형태를 지정, print 함수 호출 시 자동 호출 |
| \_\_gt\_\_  | 부등호 연산자(>, greater than)                             |
| \_\_len\_\_ | 어떤 값을 len으로 처리할 것인지 정할 수 있다               |

   

   

## 클래스

### 클래스 변수

* 한 클래스의 모든 인스턴스라도 똑같은 값을 가지고 있는 속성

* 클래스 이름 대신 인스턴스 이름을 쓰면?

  * 인스턴스 변수

* 클래스 속성(Attribute)

  * 한 클래스의 모든 인스턴스라도 똑같은 값을 가지고 있는 속성

* 클래스 선언 내부에서 정의

  ```python
  class Circle:
      pi = 3.14
  
  c1 = Circle()
  print(c1.pi)
  ```

   

### 클래스 메소드

* 클래스가 사용할 메소드

* ```@classmethod``` 데코레이터를 사용해 정의

  * 데코레이터: 함수를 어떤 함수로 꾸며서 새로운 기능을 부여

* 호출 시, 첫번째 인자로 클래스(cls)가 전달됨

  ```python
  class Myclass:
      @classmethod
      def class_method(cls, *arg):
          print(arg)
          
  m = Myclass()
  m.class_method(1,2,3)
  # (1,2,3)
  ```

   

### 스태틱 메소드

* 인스턴스 변수, 클래스 변수를 전혀 다루지 않는 메소드

* 클래스가 사용할 메소드

* 언제 사용하는가?

  * 속성을 다루지 않고 단지 기능만을 하는 메소드를 정의할 때 사용

* ```@staticmethod``` 데코레이터를 사용하여 정의

* **호출 시 어떠한 인자도 전달되지 않음 / 접근, 수정 불가**

  ```python
  class Myclass:
      @staticmethod
      def class_method(*args):
          print(sum(args))
          
  m = Myclass()
  m.class_method(1,2,3)
  # 6
  ```

   

### 인스턴스와 클래스 간의 이름공간(namespace)

* 클래스를 정의하면, 클래스와 해당하는 이름 공간 생성
* 인스턴스를 만들면, 인스턴스 객체가 생성되고 이름 공간 생성
* 인스턴스에서 특정 속성에 접근하면, 인스턴스-클래스 순으로 탐색

```python
class Person:
    species = 'human'

    def __init__(self,name):
        self.name = name

# __init__ >> species
p1 = Person('Hong')
print(p1.species)
# human : 인스턴스 공간에 변수가 없어 클래스로 이동

p1.species = 'bird'
print(p1.species)
# bird : class 변수가 아닌 인스턴스 변수가 생성된 것

p2 = Person('Kim')
print(p2.species)
# human
```

   

   

## 메소드 정리

* 인스턴스 메소드

  > self 매개변수를 통해 동일한 객체에 정의된 속성 및 다른 메소드에 접근 가능
  >
  > 클래스 자체 접근이 가능하며 **인스턴스 메소드가 클래스 상태를 수정**할 수 있다

* 클래스 메소드

  > 클래스를 가리키는 cls 매개 변수를 받음
  >
  > cls 인자에만 접근할 수 있기 때문에 인스턴스를 수정할 수는 없음

* 스태틱 메소드

  > 임의개수의 **매개변수를 받을 수 있지만 self나 매개변수를 사용하지 않음**
  >
  > **객체 상태나 클래스 상태를 수정할 수 없음**
  >
  > 일반 함수처럼 동작하지만 클래스 이름공간에 귀속
  >
  > * 주로 해당 클래스로 한정하는 용도로 사용
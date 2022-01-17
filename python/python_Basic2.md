## 제어문(Control Statement)

* 조건문, 반복문

* 파이썬은 기본적으로 위에서부터 아래로 순차적으로 명령을 수행

* 특정 상황에 따라 코드를 선택적으로 실행(분기/조건)하거나 계속하여 실행(반복)하는 제어가 필요함

* 제어문은 순서도(flow chart)로 표현이 가능



#### 조건문 기본

##### 조건문

* 조건문은 참/거짓을 판단할 수 있는 조건식과 함께 사용

* 기본 형식: expression 자리에 조건문이 들어간다. 들여쓰기를 주의한다.

  ```python
  if ( expression ==True ):
  	#Run this Code block
  else:
  	#Run this Code block
  ```

  

  ```python
  a = 5
  
  if a > 5:
      print('5 초과')
  else:
      print('5 이하')
  print(a)
  ```

[ 실습문제 ]

* 조건문을 통해 변수 num의 값의 홀수/짝수 여부를 출력하시오.

  (이 때, num은 imput을 통해 사용자로부터 입력을 받으시오)

```python
num = int(input('숫자를 입력해주세요'))

if num % 2:
    print('홀수입니다')
else:
    print('짝수입니다')
```



##### 복합조건문

```python
if< expression >:
	# code
elif< expression2 >:
	# code
elif< expression3 >:
	# code
else:
	# code
```

[ 실습문제 ]

* 미세먼지 농도에 따라 출력값을 다르게 하시오

```python
dust = int(input('미세먼지 농도를 입력해주세요'))

# 150 초과 : 매우 나쁨
if dust > 150:
    print('매우 나쁨!')
# 80 초과 : 나쁨
elif dust > 80:
    print('나쁨')
# 30 초과 : 보통
elif dust > 30:
    print('보통')
# 나머지는 모두 좋음
else:
    print('좋음')
```



##### 중첩 조건문

```python
if < expression1 >:
	if< expression2 >:
		# code	
	else:
		# code
else:
	# code
```



##### 조건 표현식

* **조건 표현식이란? **일반적으로 조건에 따라 값을 정할 때 활용, 삼항 연사자라고 부름

[ 무슨 코드일까요? ]

```python
value = num if num>=0 else -num # 절대값(abs)
```

[ 다음 코드와 동일한 조건 표현식을 작성하시오 ]

```python
num = 2
if num % 2 :
	result = '홀수입니다.'
else
	result = '짝수입니다.'
print(result)
```

```python
num = 2

result = '홀수입니다.' if num%2 else '짝수입니다.'
print(result)
```



### 반복문

* 특정 조건을 도달할 때까지 계속 반복하는 문장

###### while 문

* while문은 조건식이 참인 경우 반복적으로 코드 실행

[ 1부터 사용자가 입력한 정수까지의 총 합 ]

```python
num = int(input('숫자를 입력하시오'))
sum=0

while num > 0:
    sum+=num
    num-=1
print(sum)
```



###### For문

* 시퀀스를 포함한 순회 가능한 모든 객체(iterable)를 모두 순회함

  >for <변수명> in <object-iterable>: 

```python
for fruit in ['apple','orange','potato']:
	print(fruit)
print('끝')
```



[ 문자열의 글자를 하나씩 출력하기 ]

```python
chars = input('입력')
for i in chars:
    print(i)
```

```python
chars = input('입력')
for idx in range(len(chars)):
    print(chars[idx])
```



**Dictionary 순회**: key를 순회한다

```python
grades = {'john': 80, 'eric': 90}

for student in grades:
    print(student)
```

```python
grades = {'john': 80, 'eric': 90}

print(grades.keys()) # dict_keys(['john', 'eric'])
print(grades.values()) # dict_values([80, 90])
print(grades.items()) # dict_items([('john', 80), ('eric', 90)]), ( key, value ) 튜플 구성

for key in grades.values():
    print(key)
    
for key, value in grades.items():
    print(key,value)
```



##### enumerate 순회

* enumerate(): 인덱스와 객체를 쌍으로 담은 열거형(enumerate) 객체 반환
* (Index, value) 형태의 tuple로 구성된 열거 객체를 반환

```python
seansons = ['Spring', 'Summer', 'Fall', 'Winter']

print(list(enumerate(seansons)))
# [(0, 'Spring'), (1, 'Summer'), (2, 'Fall'), (3, 'Winter')]
```

```python
seansons = ['Spring', 'Summer', 'Fall', 'Winter']
print(list(enumerate(seansons, start = 1)))
# [(1, 'Spring'), (2, 'Summer'), (3, 'Fall'), (4, 'Winter')]
```



#### List Comprehension

* 표현식과 제어문을 통해 특정한 값을 가진 리스트를 간결하게 생성하는 방법

  >< expression > for < 변수 > in < iterable >
  >
  > 

```python
print( [number**3 for number in range(1,4)] )
# [1, 8, 27]

print({number: number**3 for number in range(1,4)})
# {1: 1, 2: 8, 3: 27}

print([num for num in range(1,31) if num%2])
# 1부터 30까지 홀수만 출력
```



#### 반복문 제어

* break: 반복문 종료
* continue: 현재 반복 구간 스킵
* for-else: break실행시 else는 실행되지 않음
* pass: 아무것도 하지 않음, 자리를 채우는 용도

##### break

```python
num = int(input('숫자를 입력하시오'))

for i in range(1,num+1):
    print(i)
    if(i==num/2):
        break;
# 1 2 3 4 5
```



##### for-else

```python
for char in 'apple':
    if char == 'b':
        print('b!')
        break
else:
    print('b가 없습니다')
    
# apple이 아닌 banana를 적으면 else는 실행되지 않는다
```



##### continue, pass

```python
for i in range(3):
    if i > 1:
        continue
    print(i)
# 0 1

for i in range(3):
    if i > 1:
        pass
    print(i)
# 0 1 2 
# pass는 사실상 없는 코드
```
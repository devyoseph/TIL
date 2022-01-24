# 파이썬의 데이터 구조

### 메소드(method)

* 순서가 있는 데이터 구조
  * 문자열(String)
  * 리스트(List)
  * 튜플(Tuple)
* 순서가 없는 데이터 구조
  * 셋(Set)
  * 딕셔너리(Dictionary)



## < 순서가 있는 데이터 구조: 문자열 / 리스트 / 튜플 >

#### 문자열(String Type): *immutable

| 문법        | 설명                                                      |
| ----------- | --------------------------------------------------------- |
| s.find(x)   | x의 첫 번째 위치를 반환, 없으면 -1 반환                   |
| s.index(x)  | x의 첫 번째 위치를 반환, 없으면 오류 발생 (get은 None)    |
| s.isalpha() | 알파벳 문자 여부 (*단순 알파벳이 아닌 유니코드 상 Letter) |
| s.isupper() | 대문자 여부                                               |
| s.islower() | 소문자 여부                                               |
| s.istitle() | 타이틀 형식 여부                                          |

* .find(x)

  ```python
  'apple'.find('p')
  # 1
  ```

* .index(x)

  ```python
  'apple'.index('k')
  # ValueError: substring not found
  ```

* .isalpha()

  ```python
  'abc'.isalpha()
  # True
  ```

* .istitle()

  ```python
  print('TITLE IS'.istitle())
  # False
  print('Title Is'.istitle())
  # True
  ```

| 문법                            | 설명                                                         |
| ------------------------------- | ------------------------------------------------------------ |
| s.replace(old, new [,count] )   | 바꿀 대상 글자를 새로운 글자로 바꿔서 반환, count는 선택인데 해당 개수만큼만 시행하도록 한다 |
| .strip([chars])                 | rstrip/lstrip/strip 사용해 공백 제거 (=trim)                 |
| .split(sep=None, maxsplit = -1) | 문자열을 특정한 단위로 나눠 **리스트**로 변환, sep이 **None**이면 공백문자로 간주, maxsplit = 내가 스플릿을 몇 번 할 것인지 |
| 'separator'.join([iterable])    | 반복가능한(iterable) 컨테이너 요소들을 separator(구분자)로 합쳐 문자열을 반환, iterable에 문자열이 아닌 값이 있다면 오류 발생 |
| s.capitalize()                  | 가장 첫 번째 글자를 대문자로                                 |
| s.title()                       | ' 나 공백 이후를 대문자로                                    |
| s.upper()                       | 모두 대문자로                                                |
| s.lower()                       | 모두 소문자로                                                |
| s.swapcase()                    | 대문자는 소문자로 소문자는 대문자로                          |

* .replace()

  ```python
  'wooooooowoo'.replace('o','!',2)
  # w!!ooooowoo
  ```

* .strip([chars])

  ```python
  print('      123123'.strip())
  # 123123
  ```

  

* String.join()

  ```python
  '!'.join('sofia')
  # s!o!f!i!a
  
  # 문자열을 사용해야하므로 변환 필수
  numbers = [1,2,3]
  print(' '.join(map(str,numbers)))
  # 1 2 3
  ```

* 기타

  ```python
  msg = 'hI! Everyone, I\'m sofia'
  print(msg)
  print(msg.capitalize())
  # Hi! everyone, i'm sofia
  print(msg.upper())
  # HI! EVERYONE, I'M SOFIA
  print(msg.lower())
  # hi! everyone, i'm sofia
  print(msg.swapcase())
  # Hi! eVERYONE, i'M SOFIA
  ```



#### 리스트(List): *mutable

| 문법                   | 설명                                                         |
| ---------------------- | ------------------------------------------------------------ |
| L.append(x)            | 리스트 마지막에 항목 x 추가                                  |
| L.insert(i,x)          | 리스트 인덱스 i에 항목 x 삽입                                |
| L.remove(x)            | 리스트에서 값이 x인 것을 삭제, 왼쪽부터 제거, 없는 경우 에러 |
| L.pop()                | 리스트 가장 오른쪽에 있는 항목, pop(i)하면 그 값을 삭제하고 반환한다 |
| L.clear()              | 모든 항목 삭제                                               |
| L.extend(m)            | 들어가는 m이 iterable임에 주의                               |
| L.index(x, start, end) | .index(x) = x값을 찾아 인덱스를 반환, 범위지정가능, 없다면 Value Error 발생 |
| L.reverse()            | 순서를 반대로 뒤집음(정렬하는 것이 아님)                     |
| L.sort()               | 원본 리스트를 정렬함. None 반환, sorted 함수와 비교(sort()는 메소드) |
| L.count(x)             | x와 같은 값의 개수를 반환                                    |

* .extend(x)

  ```python
  alpha = ['a','b','c']
  alpha.extend(['3'])
  
  print(alpha)
  # ['a', 'b', 'c', '3']
  ```

* .count(x)

  ```python
  numbers = [1,2,3,1,1,1]
  print(numbers.count(1))
  # 4
  ```

* .sort()

  ```python
  a = [100, 10, 1, 5]
  b = [100, 10, 1, 5]
  
  print(a.sort())
  # Node: a 리스트를 정렬하고 None을 반환
  
  print(sorted(b))
  # [1, 5, 10, 100]
  
  print(a)
  # [1, 5, 10, 100]
  
  print(b)
  # [100, 10, 1, 5]
  ```

* .reverse()

  ````python
  a = [1, 2, 3, 4]
  
  a.reverse()
  # 위 내용을 출력하면 None
  
  print(a)
  # [4, 3, 2, 1]
  ````



#### 튜플(Tuple): *immutable

* 튜플은 변경할 수 없기 때문에 값에 영향을 미치지 않는 메소드만을 지원
* 리스트 메소드 중 항목을 변경하는 메소드를 제외하고 대부분 동일

| 문법         | 설명                     |
| ------------ | ------------------------ |
| type()       | 튜플이면 tuple 타입 반환 |
| tuple[index] | 튜플의 인덱스 접근       |





## < 순서가 없는 데이터 구조: 셋 / 딕셔너리 >

#### 셋(Set): *mutable, 순서x

| 문법              | 설명                         |
| ----------------- | ---------------------------- |
| s.copy()          |                              |
| s.add(elem)       | 값을 추가한다                |
| s.pop()           | 임의의 원소를 제거           |
| s.remove(elem)    | 셋에서 삭제하고 없으면 error |
| s.discard(elem)   | 셋에서 삭제하고 없어도 에러x |
| s.update(*others) | s에 없는 항목을 추가         |
| s.clear()         | 모든 항목을 제거             |
| s.isdisjoint(t)   | 서로 교집합이 없을 때 True   |
| s.issubset(t)     | s가 t 하위에 있을 때 True    |
| s.issuperset(t)   | s가 t의 상위에 있을 때 True  |

* .discard()

  ```python
  a = {'1','2','3'}
  a.discard('3')
  print(a)
  ```

* .pop()

  ```python
  # 임의의 원소를 제거 = random
  a = {'1','2','3'}
  a.pop()
  print(a)
  # 예: {'2', '3'}
  ```



#### 딕셔너리(Dictionary): *mutable, 순서x

| 문법           | 설명                                                         |
| -------------- | ------------------------------------------------------------ |
| d.get(k [, v]) | 키 k의 값을 반환, 딕셔너리에 없는 경우 None을 반환, v는 선택으로 None이 아니라 v를 반환하도록 한다. |
| d.pop(k [, v]) | 키 k의 값을 반환하면서 동시에 삭제, 없으면 KeyError, 하지만 v를 설정하면 v를 반환 |
| d.update()     | 딕셔너리 d의 값을 매핑하여 업데이트                          |
| d.keys()       | 모든 key를 담은 뷰를 반환                                    |
| d.values()     | 모든 value를 담은 뷰를 반환                                  |
| d.items()      | 딕셔너리의 key - value 쌍을 담은 뷰를 반환                   |
| d.clear()      | 모든 항목을 제거                                             |
| d.copy()       | 딕셔너리 d의 얕은 복사본을 반환                              |

* .update()

  ```python
  my_dict = {'apple': '사시미', 'banana':'바나나'}
  
  my_dict.update(apple='사과')
  my_dict.update(melon='멜론')
  
  print(my_dict)
  # {'apple': '사과', 'banana': '바나나', 'melon': '멜론'}
  ```



### 얕은 복사와 깊은 복사(Shallow Copy / Deep Copy)

##### [ 복사 방법 ]

* 할당(Assignment)
* 얕은 복사(Shallow copy)
* 깊은 복사(Deep copy)

##### 할당(Assignment)

```python
my_list = ['1','2','3']
copy_list = my_list

my_list[0] = 'Hello'
print(my_list,copy_list)
# ['Hello', '2', '3'] ['Hello', '2', '3']
```



##### 얕은 복사(Shallow copy)

* Slice 연산자를 활용하여 같은 원소를 가진 리스트를 다른 주소로 복사

```python
my_list = ['1','2','3']
copy_list = my_list[:]

my_list[0] = 'Hello'
print(my_list,copy_list)
# ['Hello', '2', '3'] ['1', '2', '3']
```

* 리스트의 원소가 값이 아니라 객체라면 이 값은 또 주소를 참조하기 때문에 연쇄적으로 값이 변경된다

  ```python
  my_list = ['1','2',['3','4']]
  copy_list = my_list[:]
  
  print(my_list,copy_list)
  # ['1', '2', ['3', '4']] ['1', '2', ['3', '4']]
  my_list[2][0] = 'three'
  print(my_list,copy_list)
  # ['1', '2', ['three', '4']] ['1', '2', ['three', '4']]
  ```

##### 깊은 복사(Deep copy)

* **copy 모듈 사용**: 얕은 복사의 문제점을 생각할 필요없는 복사

  ```python
  import copy # 모듈 임포트
  
  a = ['1','2',['3','4']]
  b = copy.deepcopy(a) #deepcopy() 메소드 사용
  
  b[2][0] = 'three'
  print(a,b)
  # ['1', '2', ['3', '4']] ['1', '2', ['three', '4']]
  ```

  
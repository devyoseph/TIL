# JSON 기초

## 🐳 JSON의 장점?

* 자바스크립트 객체(object) 형식과 연동이 뛰어나다 = 나만의 js DB
* 내용이 함축적, 최소한의 정보를 가지고 있다 = XML에 비해 용량이 적음 = 빠른 속도
* 언어 독립적, 쉬운 사용법

## 🐌 JSON의 단점은?

* 내용이 함축적이므로 의미 파악이 힘들 수 있다
* 대용량급 데이터 송수신에는 부적합한 모습을 보인다



## 파일 입력 활용법

##### 데이터를 가공해 JSON 형태로 저장할 수 있습니다

기본적으로 dictionary, list 의 데이터 타입으로 저장합니다.

##### 파일 입력

```python
open(file, mode='r', encoding=None)
# file: 명
# mode: 텍스트 모드 ( 생략 가능 ) = open(file, encoding='UTF8')
# encoding: 인코딩 방식, 일반적으로 utf-8 활용
```

| Character | Meaning                                                     |
| --------- | ----------------------------------------------------------- |
| 'r'       | 읽기 전용                                                   |
| 'w'       | 쓰기 전용                                                   |
| 'x'       | Open for exclusive creation                                 |
| 'a'       | Open for writing, appending to the end of file if it exists |
| 'b'       | binary mode                                                 |
| 't'       | text mode(default)                                          |
| '+'       | Open for updating                                           |



##### with 키워드 활용

```python
with open('workfile') as f:
	read_data = f.read()

f.closed
```



##### JSON(Javascript Object Notation)

* JSON은 **자바스크립트 객체 표기법**으로 개발환경에서 많이 활용되는 데이터 양식

* 문자 기반(텍스트) 데이터 포멧으로 다수의 프로그래밍 환경에서 쉽게 활용 가능함

  * 텍스트를 언어별 데이터 타입으로 변환
  * 언어별 데이터 타입을 적절하게 텍스트로 변환

* JSON과 객체 상호변환

  ```python
  #  객체를 JSON으로
  import json
  x = [1, 'simple', 'list']
  json.dumps(x)
  ```

  ```python
  # JSON을 객체로 변환
  x = json.load(f)
  ```

* dictionary 접근1: 특정 키의 value

  ```python
  for i in stocks:
  	print(i['name'])
  ```

* dictionary 접근2

  ```python
  # dict.get(key, default)
  
  for i in stocks:
  	print(i.get('price','비상장주식'))
  # 값이 None인 경우 '비상장주식'으로 출력
  ```

* Pprint: 임의의 파이썬 데이터 구조를 예쁘게 출력

  ```python
  import json
  from pprint import pprint
  
  pprint(함수나 자료형)
  ```

* 반복문을 활용해 여러 JSON 폴더 열기/활용

  ```python
  for movie in movies: # movies: 리스트 내부 dict 파일 형식 = [{:},{:},{:}]
  # for in 구문: 각각의 dict 파일을 movie에 저장합니다
  
          id = int(movie.get('id')) # dict 내부에서 key 값을 검색(id)
    
    			# 중요 : 특정 경로를 생성하기 위해 '{}'.format() 함수 이용
      		# 얻어낸 id이 곧 파일명이기 때문에 아래와 같이 작성
          path = 'data/movies/{}.json'.format(id)
          movie_info = json.load(open(path,encoding='UTF8'))
          
          budget = int(movie_info.get('budget'))
          # 기록된 예산값 중 최대값을 구한다
          if budget > max:
              max = budget
  ```

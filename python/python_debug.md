# 디버깅

* 제어가 되는 시점
* 조건/반복, 함수

| 디버깅      | 고려할 사항                      |
| ----------- | -------------------------------- |
| branches    | 모든 조건을 고려했는가?          |
| For loops   | 반복문 원하는 횟수와 종료값      |
| While loops | For문에서 고려할 사항 + 종료조건 |
| function    | 호출값, 파라미터, 결과           |





## 에러와 예외

* #### 문법 에러(Syntax Error)

  	* SyntaxError가 발생하면 파이썬 프로그램은 실행되지 않는다
  	* 파일이름, 줄번호, ^ 문자를 통해 파이썬이 코드를 읽어 나갈 때(parser) 문제가 발생한 위치를 표현
  	* 줄에서 에러가 감지된 가장 앞의 위치를 가리키는 캐럿(caret)기호(^)를 표시

  | 문법 에러 종류    | 내용               |
  | ----------------- | ------------------ |
  | Invalid syntax    | ```while```        |
  | Assign to literal | ``` 5 = 3 ```      |
  | EOL (End of Line) | ```print('hello``` |
  | EOF (End of File) | ```print(```       |

  

* #### 예외(Exception)

  * 실행 도중 예상치 못한 상황을 맞이하면 프로그램 실행을 멈춤
  * 실행 중에 감지되는 에러들을 예외(Exeption)라고 부름
  * 예외는 여러 타입(type)이 존재
  * 모든 내장 예외는 Exception Class를 상속받아 이뤄짐
  * 사용자 정의 예외를 만들어 관리할 수 있음

  | 에러 종류           | 내용                                         |
  | ------------------- | -------------------------------------------- |
  | ZeroDivisionError   | 0을 나누고자할 때 발생                       |
  | NameError           | Namespace 상에 이름이 없는 경우              |
  | TypeError           | ```1+'1'``` or ```round('3.5')```            |
  | ValueError          | ```range(3).index(6)```                      |
  | IndexError          | ```lst = []; let[2]```                       |
  | KeyError            | ```song = { 'IU' : '좋은날'}; song('BTS')``` |
  | ModuleNotFoundError | ```import supermarket```                     |



## 예외 처리

* try 문(statement) / except 절(clause)를 이용해 예외 처리할 수 있음

* try 문

  * 오류가 발생할 수 있는 코드를 실행
  * 예외가 발생하지 않으면 except 없이 실행 종료

* except 문

  * 예외가 발생하면 except 절이 실행
  * 예외 상황을 처리하는 코드를 받아서 적절한 조취를 취함

  ```python
  try:
  	# try - 명령문
  except 예외:
  	# 예외처리 명령문
  else:
  	# else 명령문
  Finally:
  	#	최종 정리문(clean-up)
  ```

  * 예시

  ```python
  try:
      num = int(input('100으로 나눌 값을 입력하시오'))
      100/num
  except (ValueError, ZeroDivisionError):
      print('0이 아닌 \'숫자\'를 입력하시오')
  ```

  * as를 사용한 에러 메시지 처리

    ```python
    try:
        num = int(input('100으로 나눌 값을 입력하시오'))
        100/num
    except ZeroDivisionError as err:
        print(f'{err} 오류 발생 \'숫자\'를 입력하시오')
    ```

  * raise를 이용해 예외를 강제로 발생

    ```python
    raise <표현식>(메시지)
    ```

    ```python
    raise ValueError('값 에러 발생')
    ```

    ```python
    try:
        raise ZeroDivisionError
    except ZeroDivisionError as err:
        print(f'{err} 오류 발생 \'숫자\'를 입력하시오')
    ```

  * assert를 통해 예외를 강제로 발생: 무조건 AssertionError 발생

    * 일반적인 디버깅 용도로 사용

      ```python
      assert <표현식>, <메시지>
      ```

      ```python
      assert len([1,2]) == 1, '길이가 1이 아닙니다'
      ```
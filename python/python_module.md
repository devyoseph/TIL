### 모듈

* 특정 기능을 하는 코드를 파이썬 파일(.py) 단위로 작성한 것

### 패키지

* 특정 기능과 관련된 여러 모듈의 집합
* 패키지 않에는 또 다른 서브 패키지를 포함



#### 모듈과 패키지 불러오기

```python
import module
from module import var, function, Class
from module import *

from package import module
from package.module import var, function, Class
```



#### 파이썬 표준 라이브러리

* 파이썬에 기본적으로 설치된 모듈과 내장 함수

  https://docs.python.org/3/library/index.html

```python
import random

print(random.sample(range(1, 46), 6))
```



#### 파이썬 패키지 관리자(pip)

* PyPI(Python Package Index)에 저장된 외부 패키지들을 설치하도록 도와주는 패키지 관리 시스템

* **패키지 설치**

  * 최신/특정/최소 버전 명시해 설치 가능
  * 이미 설치된 경우 아무것도 하지 않음

  ```bash
  $ pip install SomePackage
  $ pip install SomePackage==1.0.5
  $ pip install 'SomePackage>=1.0.4'
  ```

* **패키지 삭제**

  ```bash
  $ pip uninstall SomePackage
  ```

* **패키지 목록**

  ```bash
  $ pip list
  # 목록 및 패키지 정보
  $ pip show SomePackage
  ```

* **패키지 freeze**

  ```bash
  $ pip freeze
  # pip install에서 활용되는 식으로 패키지 목록을 만든다
  ```

* **패키지 관리**

  ```bash
  $ pip freeze > requirements.txt
  $ pip install -r requirements.txt
  # 텍스트 파일에 있는 대로 설치하는 명령
  
  # requirements.txt 로 관리한다
  ```

  

#### 사용자 모듈과 패키지

###### <모듈 만들기>

* check.py에 짝수를 판별하는 함수(even)와 홀수를 판별하는 함수(odd)를 만들고 check 모듈을 활용 해보시오

  ```python
  # check.py
  def odd(n):
      return bool(n%2)
  def even(n):
      return not bool(n%2)
  ```

  ```python
  # check.py 외부 문서
  # 모듈자체를 import 하기
  import check
  print(dir(check))
  
  print(check.odd(3)) # True
  print(check.even(3)) # False
  ```

  ```python
  # from으로 import 하기
  from check import *
  
  print(odd(3))
  print(even(3))
  ```

###### 패키지 만들기



###### 가상환경

* 파이썬 표준 라이브러리가 아닌 외부 패키지와 모듈을 사용하는 경우 모두 pip을 통해 설치를 해야함

* 복수의 프로젝트를 하는 경우 버전이 상이할 수 있음

  * 과거 외주 프로젝트 - django 버전 2.x
  * 신규 회사 프로젝트 - django 버전 3.x
  * 이러한 경우 가상환경을 만들어 프로젝트별로 독립적인 패키지를 관리할 수있음

* **venv**: 가상환경을 만들고 관리하는 모듈(v.3.5이상)

  * 특정 디렉토리에 가상환경을 만들고 고유한 파이썬 패키지 집합을 가질 수 있음

  ```bash
  $ python -m venv <폴더명>
  ```

  * 가상환경 활성화/비활성화

    [ 활성화 ]

    | 플랫폼 | 셀              | 명령                                 |
    | ------ | --------------- | ------------------------------------ |
    | POSIX  | bash/zsh        | $ source <venv>/bin/activate         |
    |        | fish            | $ source <venv>/bin/activate.fish    |
    |        | csh/tcsh        | $ source <venv>/bin/activate.csh     |
    |        | PowerShell Core | $ <venv>/bin/Activate.psl            |
    | 윈도우 | cmd.exe         | C:\\> <venv>\Scripts\activate.bat    |
    |        | PowerShell      | PS C:\\> <venv>\Scripts\Activate.psl |

    **cmd/bash 환경**

    ```bash
    $ source venv/Scripts/activate
    ```

    

    [비활성화]

    ```bash
    $ deactivate
    ```
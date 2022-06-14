# 과정

​                 

### 1. 원본 CSV 파일을 다운

* Data.go 에서 파일을 다운 받습니다

​               

### 2. Excel 환경에서 쉼표(,)제거 및 줄바꿈 제거

* Ctrl + h 를 이용해 `,`를 모두 `#`로 바꾸어 CSV 파일 인식을 정상적으로 할 수 있도록 바꿉니다.(이후 mysql에서 재변경합니다.)
* 셀 범위 선택 후 서식 파일 설정에서 줄바꿈을 모두 체크해제 합니다.

​               

### 3. CSV TO JSON

* 웹사이트를 이용해 CSV파일을 JSON으로 변경합니다

​              

### 4. MYSQL import

* JSON 파일이기 때문에 오류 없이 import 됩니다.

​                 

### 5. 테이블 명 변경 & column 값 변경 & row 값 변경

* 요구사항에 주어진대로 값들을 변경합니다.

  * `saffy_nm`이라는 칼럼을 추가해야합니다.

* row값 변경: `#`를 다시 `,`로 원위치 시킵니다.

  ```sql
  update sc_clinic set weekday_time = replace(weekday_time, '#', ',');
  update sc_clinic set sat_time = replace(sat_time, '#', ',');
  update sc_clinic set holiday_time = replace(holiday_time, '#', ',');
  ```

* 추가한 열 `saffy_nm`에 값 일괄 적용

  ```sql
  update sc_clinic set ssafy_nm = "7기_구미_양요셉”;
  ```

  ​                

### 6.  CSV 로 내보내기

* 내보내기 명령어

```sql
SELECT *
FROM sc_clinic
INTO OUTFILE '/Users/yang-yoseb/Desktop/name.csv';
```

​             

* 만약 다음오류가 발생한 경우

```
Error Code: 1290. The MySQL server is running with the --secure-file-priv option so it cannot execute this statement
```

* my.cnf 파일을 찾고 내용 수정

```bash
$ mysql --help | grep my.cnf
```

```bash
$ vim <위에서 검색된 경로>
```

* 아래 내용 추가(입력 후 :wq)

```
[mysqld]
secure-file-priv=""
```

* 서버 재시작

```bash
$ mysql.server restart
```



#### - 재시작 후 위 코드를 재실행


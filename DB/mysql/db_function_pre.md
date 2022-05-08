# DB 함수/Transaction 예습

> 클라이언트(웹) - 미들웨어 - DB 세단계로 연결하며 이를 3-Tier Architecture이라고 한다.
>
> JDBC가 그 역할을 한다.
>
>  데이터연산을 요즘은 프론트에서도 할 수 있지만 연산을 최대한 데이터베이스에서 처리하도록 한다.
>
> 그것을 위해 데이터베이스의 **내장 함수**를 잘 알아야한다.

​             

## 함수 - 숫자

> 숫자, 문자, 날짜, 논리, 그룹 함수들이 있고 이제꺼 봐왔던 키워드들이다.
>
> **MATH.**으로 시작한다. 
>
> 연산 내용 그대로 **테이블 이름**으로 뜨기 때문에 **AS**키워드(ALIAS)를 잘 활용한다.

### ABS

```sql
CREATE TABLE ta(a int);
INSERT INTO ta VALUES(1);
INSERT INTO ta VALUES(-1);
INSERT INTO ta VALUES(1);

SELECT a, ABS(a) FROM ta;
```

* ABS는 보통 값들을 조회하고 절대값으로 넘길 때 사용한다. 

​         

### CEILING, CEIL

* 올림 키워드, 둘 모두 사용 가능하다

```sql
SELECT CEIL(COLUMN명) FROM ta;
```

​            

###  FLOOR

* 내림 키워드

```SQL
SELECT FLOOR(COLUMN명) FROM ta;
```

​         

### ROUND

* 반올림 키워드

```SQL
SELECT ROUND(COLUMN) FROM ta;
```

​          

### TRUNCATE(a, b)

* 버림, 소수점 b자리수(음수면 기본 자리수)**까지** 남기고 버린다.

​        

### POW(a, b), MOD(a, b)

* 지수승, 나머지 연산
* **Mysql**은 모듈러 연산을 지원한다 **a%b**로 MOD(a,b)를 대체 가능

​       

### 숫자 그외

* GREATEST(a,b,c...)와 LEAST(a,b,c,e,..)가 있다

​            

​            

​           

## 함수 - 문자

### LCASE/LOWER, UCASE/UPPER

* 대문자, 소문자 표현

### LEFT(a, b), RIGHT(a,b)

* 문자열 왼쪽/오른쪽에서 얼만큼을 가져옵니다.

### ASCII('a')

* 아스키 코드반환

### CONCAT(A,B,C,D)

* 칼럼 문자열을 합침

​            

### INSERT(a, 6, 3, b)

* A의 6번째 자리에서 3번째 자리를 b로 **대체**한다.

​                 

### REPLACE(a,b,c)

* 검색: a문자에서 b를 c로 **대체**합니다.

  ​       

### SUBSTRING(a,7,5)

* A의 7번째 자리에서 5길이만큼 **가져옵니다.**

​             

### REVERSE('a')

* a 문자열을 뒤집습니다.

​       

​            

## 함수 - 날짜

### NOW()  /  SYSDATE()  /   CURRENT_TIMESTAMP()

* 현재 날짜와 시간 리턴

### CURDATE() / CURRENT_DATE()

* 현재 날짜까지 리턴

### YEAR(), MONTH()

* 날짜의 년도, 월 리턴

### DATE_ADD(A, INTERVAL B)

* A에 B시간만큼 더한 값을 리턴합니다.

  ```SQL
  DATE_ADD(A, INTERVAL 5 HOUR)
  ```

### DATE_FORMAT(A, 'B')

* A를 B 포맷으로 바꿉니다
* 권장되는 포맷: `20220316` 혹은 `20220316020322`

​        

​       

## 함수 - 논리

### IF(A,B,C)

* A조건이 참이면 B 를 출력 거짓이면 C를 출력

### IFNULL(column, value)

* 자주쓰임, null이라면 어떻게 할 것인지.

```sql
IFNULL(COLUMN명, 나타낼 값);
```

*  #### NULLIF(a,b)

  * a가 b와 같으면 NULL로 표기

​             

​                

## 집계함수

> 가장 중요하지만 키워드는 단순하다

* COUNT(), MAX, MIN, AVG(), SUM()

  * **NULL 데이터를 배제하고 계산한다**

    * COUNT(): NULL 값을 세지 않음에 주의

  * 해결 방안

    1. NULL값이 없는 칼럼을 사용하거나
    2. NULL값을 바꾼다음 세어주기

    ```sql
    COUNT(ifnull(id,0));
    # NULL이라면 그값을 0으로 바꾼다음 COUNT해주기
    ```

    

​           

​                      

# Transaction 예습

> 트랜젝션: 데이터베이스의 상태를 변화시키는 일종의 작업 단위
>
> **DML에만** 적용가능하다
>
> DDL, DCL 은 적용안됨
>
> 기본적으로 AUTO COMMIT이기 때문에 그것을 해제해준다
>
> ```SQL
> select @@autocommit; # 현재의 autocommit 속성을 확인한다.
> 
> set autocommit=false; # 만약 위의 조회 결과가 1 즉 true 이면 false 로 변경 후 처리한다.
> ```

* START TRANSACTION
  * COMMIT, ROLLBACK이 나올 때까지 실행되는 모든 SQL
  * 굳이 안써줘도 알아서 해줌
* **COMMIT**
  * 그냥 **ROLLBACK**시 돌아가는 포인트입니다.
* **SAVEPOINT a;**
  * **ROLLBACK TO SAVEPOINT a** 시 a로 롤백합니다.

```SQL
create table tc_test
(
	val varchar(10)
);

start transaction;

insert into tc_test
values ('a');

insert into tc_test
values ('b');

insert into tc_test
values ('c');

rollback; # START TRANSACTION으로 돌아갑니다
```



​          
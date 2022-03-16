# MySQL

> MySQL을 써야하는 이유 중 하나: LIMIT = paging이 쉽다는 점

### 대소문자 구분

* MySQL은 where절에서 검색할 때 대소문자를 구분하지 않고 검색하기 때문에 BINARY키워드를 사용한다

```sql
select * from employees where first_name = 'steven';
```

```sql
select * from employees where binary(first_name) = 'steven';
```

​        

### 테이블 생성

* 세부 옵션은 **그냥 띄어쓰기**로 넣어주면 된다.

```sql
CREATE TABLE table_name(
	column_1 INT NOT NULL,
	idx INT AUTO_INCREMENT,
	column_name3 INT,
    PRIMARY KEY(idx)
);
```

​         

### INSERT INTO a VALUES b

* 테이블에 row 전체에 값을 넣는 방법

```sql
INSERT INTO table_name
VALUES (col1,col2,col3);
```

* 테이블에 지정한 COL 값만 넣기 (부분적으로 데이터 집어넣기)

```sql
INSERT INTO table_name(col1, col2)
VALUES (val1,val2);
```

* **하나의 INSERT로 여러 개 값을 넣기**
  * VALUES에 콤마(,)로 이어붙임

```SQL
INSERT INTO table_name(col1,col2)
VALUES (val1,val2),
	   (val3,val4);
```

​         

### UPDATE a SET b WHERE c

* 모든 칼럼을 바꿀 수 없기 때문에 where절이 필수이다

​        

### DELETE  FROM  table_name  WHERE conditions

* 특정 테이블에서 조건에 해당하는 데이터 삭제

​            

### 실행 순서

> SELECT - 실행순서 5
>
> FROM - 실행순서 1
>
> WHERE - 실행순서 2
>
> GROUP BY - 실행순서 3
>
> HAVING - 실행순서 4
>
> ORDER BY - 실행순서 6
>
> LIMIT - 실행순서 7

#### 주의

> 실행 순서는 위와 같지만 **MySQL**의 SELECT문에서 ALIAS를 적용해도 이전 실행 순서에서 읽을 수 있다.

```sql
select department_id, avg(salary) AS avgsal # AS
from employees
where salary >= 2000
group by department_id
having avgsal > 7000 # 적용
order BY department_id desc
limit 1,3;
```

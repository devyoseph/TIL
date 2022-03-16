# DB GROUP / CONSTRAINT / VIEW / INDEX 예습

​        

## - GROUP BY / ALTER

### GROUP BY절

>SELECT - 실행순서 5
>
>FROM - 실행순서 1
>
>WHERE - 실행순서 2
>
>GROUP BY - 실행순서 3
>
>HAVING - 실행순서 4
>
>ORDER BY - 실행순서 6
>
>LIMIT - 실행순서 7

```SQL
select department_id, max(salary), min(salary)
from employees
group by department_id
order by department_id desc;
```

​           

### HAVING 절

* 그룹의 조건문

```SQL
select department_id, avg(salary)
from employees
group by department_id
having avg(salary) > 7000;
```

​         

### LIMIT a, b;

* **Paging**: a부터 b까지 검색할 때 사용
  * a는 0부터 가능

​          

​            

### WITH ROLLUP

* 맨 뒤 ROW를 만들고 그룹으로 묶은 전체 데이터의 합을 띄움

​         

### GROUPING( )

* GROUP BY와 다른 함수이다

  * 그룹으로 묶였는지 판단해서 0아니면 1로 반환한다.

  ```sql
  -- grouping 를 이용한 총계표시
  select if(grouping(department_id) = 1, '총계', department_id), count(*)
  # grouping의 값이 1인 것은 칼럼의 값을 총계로 설정한다
    from employees
   group by department_id with rollup;
  ```

  ​          

### ALTER

* DDL 언어: 구조를 바꿀 때 사용 = **AUTO COMMIT** = 롤백이 안됨
  * 기존의 데이터가 바뀔 수 있으므로 주의한다.

```SQL
ALTER TABLE 테이블명
ADD / MODIFY / DROP / RENAME

ADD (); DROP (); MODIFY();
RENAME COLUMN a TO b
```

```sql
-- email 컬럼 추가하기
alter table tb_alter 
add (email varchar(20));

-- 컬럼이름 변경
alter table tb_alter 
rename column name to user_name;

-- 컬럼 삭제: 데이터가 모두 삭제되므로 웬만해서 사용X
alter table tb_alter
drop email;

-- 컬럼 구조 변경: 실무에서는 웬만해서 사용하지 말 것, 또한 데이터의 형식과 안맞으면 변경 불가
ALTER TABLE tb_alter
MODIFY age int;
```

​         

### DESC / DESCRIBE

* 테이블의 구조

​          

## - CONSTRAINT

> 제약조건

### PRIMARY KEY

* 테이블당 하나만 설정 가능
* 여러 칼럼을 조합해 생성 가능
* 데이터를 구분하는 역할
* `NOT NULL` + `UNIQUE`

* **복합키**

  ```SQL
  CREATE TABLE ttt(
  	a varchar(20),
      b varchar(30),
      c int,
      primary key(a,b) #복합키 지정: 애초에 NULL은 불가
  );
  
  insert into ttt values('a','b',3);
  insert into ttt values('a','a',3);
  insert into ttt values('a','a',3); # 두개가 primary key라면 두 개가 중복될 때 불가능
  ```

  ​         

### UNIQUE 주의점

* UNIQUE는 NULL을 아예 취급하지 않기 때문에 NULL데이터가 여러개 들어갈 수 있다.

  ```SQL
  CREATE TABLE aaa(a varchar(3) unique);
  INSERT INTO aaa VALUES('sss');
  INSERT INTO aaa VALUES('ssa');
  INSERT INTO aaa VALUES(NULL);
  INSERT INTO aaa VALUES(NULL);
  SELECT * FROM aaa;
  ```

​               

### NN  (NOT NULL)

* NULL을 허용하지 않는다 = **반드시 입력되어야 한다**

​         

### CK(CHECK)

* 값을 체크

​        

### FOREIGN KEY

* 외래키(이후 자세히 다룸)

​      

### DEFAULT

* 원래 입력되지 않으면 NULL이지만 DEFAULT 값을 입력하도록 만드는 설정

​         

## CONSTRAINT 예제

* 칼럼에 제약 조건 부여

```sql
-- 컬럼 레벨 설정 
create table book (
	id int primary key,
	name varchar(20) not null,
	price int check(price > 0), # check를 통해 값 저장 자체를 제한(WHERE과는 근본적으로 다름)
	isbn varchar(14) unique,
	pubDate timestamp default current_timestamp
    #, PRIMARY KEY(id) : 테이블 단위 제약조건으로 주는 방식도 가능 = 복합키로 확장 가능
    # PRIMARY KEY(id, b)
);
```

```sql
-- 테이블 레벨 제약조건 설정방식
create table book (
	id int,
	name varchar(20) not null,
	price int,
	isbn varchar(14),
	pubDate timestamp default current_timestamp,
	#not null(name),	에러
	primary key(id),
	check(price > 0),
	unique(isbn)
);
```

* 제약 조건에 이름 부여

  * 데이터 제약조건의 추가 / 수정이 가능해진다.

  ```SQL
  # The name of a PRIMARY KEY is always PRIMARY
  create table book (
  	id int,
  	name varchar(20) not null,
  	price int,
  	isbn varchar(14),
  	pubDate timestamp default current_timestamp,
  	#not null(name),	에러
  	constraint book_id_pk primary key(id),
  	constraint book_price_ck check(price > 0),
  	constraint book_isbn_uk unique(isbn)
  );
  
  # 아래 내용을 넣으려고 할 때 많은 데이터를 집어넣을 때 UNIQUE 조건에 의해 오버헤드가 발생한다
  INSERT INTO book VALUES(1, 'aaa', 3000, 'ddd1', now());
  INSERT INTO book VALUES(2, 'aaa', 3000, 'ddd2', now());
  INSERT INTO book VALUES(3, 'aaa', 3000, 'ddd3', now());
  INSERT INTO book VALUES(4, 'aaa', 3000, 'ddd4', now());
  INSERT INTO book VALUES(5, 'aaa', 3000, 'ddd5', now());
  
  
  # 그래서 아래와 같이 제약조건을 잠시 해제하고 넣기도 한다.
  alter table book
  drop constraint book_isbn_uk;
  
  # 다시 제약 조건 넣어주기
  alter table book
  add constraint book_isbn_uk unique(isbn);
  ```

  ​          

​                 

## VIEW

* 기본 구문

```SQL
CREATE [OR REPLACE] VIEW view이름 AS
```

```sql
create or replace view employeedeptno50
as
select employee_id, first_name, job_id, salary, department_id
  from employees
 where department_id = 50;
 
desc employeedeptno50;

# 뷰의 사용
select * from employeedeptno50;

# 생성된 뷰 확인하기
use information_schema;
show tables;

use abcd;

select * 
  from views;

select * 
  from views
 where TABLE_SCHEMA = 'abcd'
   and TABLE_NAME = 'employeedeptno50';

```

​       

​           

## INDEX

* 계속 참조하므로 상황에 따라 적절히 사용한다. 

```SQL
CREATE INDEX index명 on 테이블명(컬럼명);

ALTER 테이블명 DROP INDEX index명;
```

* 기본 정렬된 데이터로 관리한다.
* 테이블 데이터와 **별개 공간**으로 관리된다.
* 테이블 **조회 속도**를 높히기 위해 사용한다.
* primary key, unique, foreign key 제약 조건들은 자동으로 인덱스 생성
* 자주 수정되는 칼럼은 오버헤드를 불러 일으킬 수 있다(insert, update, delete = CRUD).

​           


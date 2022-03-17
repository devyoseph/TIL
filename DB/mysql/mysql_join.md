# JOIN

>* 둘 이상의 테이블에서 데이터가 필요한 경우 조인이 필요
>
>* 일반적으로 조인 조건을 포함하는 WHERE 절을 작성해야 한다.
>  * **테이블의 수 = n-1 개**
>  * ON: 조인의 조건
>  * WHERE: 일반 조건
>
>* 조인 조건은 일반적으로 테이블의 PK 및 FK
>  * PK = UNIQUE + NOT NULL, INDEX 자동생성
>  * FK = 다른 테이블의 값, **NULL** 가능
>* 주의
>  * 조인의 처리는 어느 테이블을 먼저 읽을지 결정하는 것이 중요(처리할 작업량이 상당히 달라진다)
>  * INNER JOIN: 어느 테이블을 먼저 읽어도 결과가 달라지지 않아 MySQL 옵티마이저가 조인의 순서를 조절해 다양한 방법으로 최적화 수행 가능
>  * OUTER JOIN: 반드시 OUTER가 되는 테이블을 먼저 읽어야 하므로 옵티마이저가 조인 순서를 선택할 수 없다.
>
>​         

### JOIN의 종류

* INNER JOIN
* OUTER JOIN
  * LEFT OUTER JOIN
  * RIGHT OUTER JOIN

​         

### JOIN 조건의 명시에 따른 구분

* NATURAL JOIN
* CROSS JOIN(FULL JOIN, CARTESIAN JOIN)

​        

### JOIN의 필요성

```sql
select employee_id, first_name, salary, department_name
from employees, departments
where employees.department_id = departments.department_id # 두 테이블을 가져올 때 겹치는 값만 가져옴
and employee_id = 100;
```

​          

## INNER JOIN

* 가장 일반적인 JOIN의 종류이며 교집합이다
* 동등 조인(Equi-Join)이라고도 하며 N개의 테이블을 조인시 N-1개의 조인 조건이 필요하다.

```sql
SELELCT COL1,COL2...,COLN
FROM table1 INNER JOIN table2
ON table.column = table2.column;
```

* table에 Alias 사용

```SQL
SELELCT COL1,COL2...,COLN
FROM table1 AS alias1 INNER JOIN table2 AS alias2
ON alias1.column = alias2.column;
```

```sql
select e.employee_id, e.first_name, e.salary, e.department_id, d.department_name
from employees e inner join departments d
on e.department_id = d.department_id
where e.employee_id = 100;
```

### Using 사용

* using절 안에는 alias를 사용X
* 두 테이블이 같은 column을 가질 때 사용 

```sql
select e.employee_id, e.first_name, e.salary, e.department_id, d.department_name
from employees e inner join departments d
using(department_id)
where e.employee_id = 100;
```

​          

​           

## NATURAL JOIN

```sql
SELECT COL1, COL2, ...COLN
FROM table1 NATURAL JOIN table2
```

* 예제1

```sql
select e.employee_id, e.first_name, e.salary, e.department_id, d.department_name
from employees e natural join departments d
where e.employee_id = 100;
# result 가 없다 이유는?
# 다른 column이 겹칠 때 그 값이 다른 경우 둘을 다른 row로 분류하고 내놓지 않는다.
```

* 예제2

```sql
select d.department_id, d.department_name, l.city
from departments d natural join locations l
where d.department_id = 10;
```

​             

## OUTER JOIN

> MySQL 은 FULL OUTER JOIN은 지원하지 않는다.

```SQL
SELECT COL1, COL2...
FROM table1 LEFT/RIGHT/FULL OUTER JOIN table2
ON or USING
```

> * LEFT OUTER JOIN, RIGHT OUTER JOIN, FULL OUTER JOIN으로 구분
>   * LEFT OUTER: 왼쪽 테이블을 기준으로 JOIN에 일치하지 않는 데이터까지 출력
>   * RIGHT OUTER: 오른쪽 테이블을 기준으로 JOIN에 일치하지 않는 데이터까지 출력
>
> * 어느 한쪽 테이블에는 해당하는 데이터가 존재하는데 다른 쪽 테이블에는 데이터가 존재하지 않을 경우 그 데이터가 검색되지 않는 문제점을 해결하기 위해 사용

* 예시

```sql
select e.employee_id, e.first_name, e.salary, d.department_name
from employees e join departments d
using(department_id);
```

* 예시2
  * 만약 가져오는 column 값에서 NULL이 있는 경우 = 그 null이 있는 column을 기준으로 정렬한다

```sql
select e.employee_id, e.first_name, d.department_name
from employees e left outer join departments d
using (department_id); # 한쪽에서 이 값의 null이 존재하는 경우 아예 이 칼럼을 기준으로 정렬하면 해결
```

​          

### FULL OUTER JOIN의 구현

> UNION: 두 서브쿼리를 합쳐줌
>
> UNION ALL: 합치되 중복되는 것은 제거

```sql
select ifnull(d.department_name, '승진발령'), e.employee_id, e.first_name
from employee e left outer join departments d
on e.department_id = d. department_id
union all ## 중복 제거하면서 합침
select department_name, e.employee_id, first_name
from employee e right outer join departments d
using (department_id)
```



​                         

## SELF JOIN

* 같은 테이블끼리 JOIN
* 같은 테이블 안에서 서로 다른 column값들을 참조할 때 서로 참조하는 알짜배기를 골라낼 수 있다.

```SQL
select e.employee_id, e.first_name, m.employee_id, m.first_name
from employees e inner join employees m
on e.manager_id = m.employee_id; # 자기 자신과 조인
```

​          

## None-Equi JOIN

* table PK, FK가 아닌 일반 column을 조건으로 지정
* 모든 사원의 사번, 이름, 급여, 급여등급

```sql
select e.employee_id, e.first_name, e.salary, s.grade
from employees e join salgrades s
where e.salary >= s.losal
and e.salary <= s.hisal;
```


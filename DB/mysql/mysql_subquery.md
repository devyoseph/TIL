# Subquery

> * 다른 쿼리 내부에 포함되어 있는 SELECT 문을 의미한다
> * 서브 쿼리를 포함하고 있는 쿼리를 외부(outer query) 또는 메인 쿼리라고 부르며, 서브쿼리는 내부 쿼리(inner query)라고 부른다
> * 서브 쿼리는 비교 연산자의 오른쪽에 기술해야 하고 **반드시 괄호( )로 감싸져 있어야만 한다.**
>
> ​           
>
> **서브 쿼리의 종류**
>
> * 중첩 서브 쿼리(Nested Subquery) WHERE 문에 작성하는 서브 쿼리
>   1. 단일 행: 같다, 크다, 작다
>   2. 복수(다중) 행: in, any, all, exists
>   3. 다중 컬럼
> * 인라인 뷰(Inline View) - **FROM 문에 작성하는 서브 쿼리**
> * 스칼라 서브 쿼리(Scalar Subquery) - SELECT 문에 작성하는 서브 쿼리
>
> ​           
>
> **서브 쿼리 사용이 가능한 곳**
>
> * SELECT
> * FROM
> * WHERE
> * HAVING
> * ORDER BY
> * INSERT문의 VALUES
> * UPDATE문의 SET
>
> ​        
>
> **MySQL**
>
> 5.5 이하 버전: 웬만하면 JOIN 사용
>
> 5.6 이상 버전: Optimizer의 업데이트로 JOIN과 Subquery의 차이가 미미 그래도 최적화 경우가 달라 join이 조금 더 좋다

​          

### NESTED SUBQUERY

> WHERE문에 작성하는 서브 쿼리

* 단일 행

  ```sql
  select employee_id, first_name, department_id
  from employees
  where department_id =
  (select department_id
  from employees
  where first_name = 'adam'
  );
  ```

* 다중 행: IN, ANY, ALL 사용

  ```sql
  select salary, first_name, salary, department_id
  from employees
  where salary > all (
                  select salary
                  from employees
                  where department_id = 30
                  );
  ```

* **다중 열**: 결과가 다중열을 리턴

  ```sql
  select employee_id, first_name
  from employees
  where (salary, department_id) in (
                                  select salary, department_id
                                  from employees
                                  where commission_pct is not null
                                  and manager_id = 148
                                  );
  ```

  ​        

### INLINE VIEW

> FROM 절에 사용되는 서브 쿼리
>
> 임시적인 뷰이지만 데이터베이스에 저장X
>
> 동적으로 생성된 테이블이기 때문에 column을 자유롭게 참조 가능

```sql
-- 인라인뷰(Inline View)
-- 모든 사원의 평균 급여보다 적게 받는 사원들과 같은 부서에서 근무하는 사원의 사번, 이름, 급여, 부서번호
select e.employee_id, e.first_name, e.salary, e.department_id
from employees e join (
                        select distinct department_id
                        from employees
                        where salary < (select avg(salary) from employees)
                        ) a
on e.department_id = a.department_id;
```

​         

#### 인라인 뷰 - TopN 질의

* `rownum` : 행 번호

```sql
set @pageno = 3;

select b.rn, b.employee_id, b.first_name, b.salary
from (
      select @rownum := @rownum + 1 as rn, a.*
      from (
            select employee_id, first_name, salary
            from employees
            order by salary desc
           ) a, (select @rownum := 0) tmp
     ) b
where b.rn > (@pageno * 5 - 5) and b.rn <= (@pageno * 5);
```

* MySQL은 **LIMIT**로 해결

```sql
select first_name, salary
from employees
order by salary desc limit 10,5;
```

​          

### SCALAR SUBQUERY

> SELECT 절에 있는 서브 쿼리, **한 개의 행만**을 반환

* 예시

```sql
-- 부서번호가 50인 부서의 총급여, 60인 부서의 평균급여, 90인 부서의 최고급여, 90인 부서의 최저급여
select
    (select sum(salary) from employees where department_id = 50) sum50,
    (select avg(salary) from employees where department_id = 60) avg60,
    (select max(salary) from employees where department_id = 90) max90,
    (select min(salary) from employees where department_id = 90) min90
from dual;
```

​                         

## 서브쿼리의 활용

>  서브쿼리를 이용한 CREATE, INSERT, UPDATE, DELETE

## CREATE

* 데이터 모두 복사해서 가져오기

```sql
CREATE TABLE emp_copy
select * from employees;
# 제약조건까지 모두 복사
```

* 구조만 가져오기

```sql
CREATE TABLE emp_blank
SELECT * FROM employees
where 1 = 0;
```

* 조건을 맞추어 가져오기

```sql
CREATE TABLE emp50
SELECT employee_id eid, first_name name, salary sal, department_id did
from employees
where department_id = 50;
```

​        

### INSERT

* 조건에 맞춘 테이블 가져오기: Values가 없다

```sql
INSERT INTO emp_blank
SELECT * FROM employees
WHERE department_id = 80;
```

​         

### UPDATE

* 예제

```sql
# 평균 급여보다 적게 받는 사람 연봉 인상
UPDATE emp50
SET sal = sal + 500
WHERE sal < (SELECT AVG(salary) FROM employees);
```

​        

### DELETE

* 예제

```sql
# 평균 급여보다 적으면 삭제/퇴사
DELETE FROM emp50

WHERE sal < (SELECT AVG(salary) FROM employees);
```




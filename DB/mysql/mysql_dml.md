## DML

### SELECT FROM WHERE

* 기본적인 조회 키워드

​        

### ALL / DISTINCT 키워드

* ALL: FROM 절에서 가져온 테이블의 모든 열 반환(default)
* DISTINCT: 행에서 중복값 제거

```sql
SELECT DISTINCT department_id FROM employees
```

* AS: ALIAS: 별칭

​             

### 사칙연산 가능

````sql
SELECT employee_id, first_name, salary, salary*12 AS 연봉 FROM employees
````

​       

### CASE (WHEN~THEN) END

```SQL
SELECT employ_id, first_name, salary,
				CASE WHEN salary  > 15000 THEN '고액연봉'
				     WHEN salary > 8000 THEN '평균연봉'
				     ELSE '저액연봉'
				END "연봉등급" # ALIAS
FROM employees;
```

​       

### IN(), ANY(), BETWEEEN A AND B 키워드

* IN( ): 내부와 일치하는 값만 출력
  * 응용: NOT IN( )
* ANY(): 하나라도 같다면 그 값을 출력
* BETWEEN A AND B
  * A와 B 사이값인지 확인 조건

​         

### LIKE '문자열'

```sql
LIKE '%x%';
```

* %: 어느 문자(크기상관X)
* _: 어느 문자(한 글자)

​       

### NULL 주의

* NULL 에 NOT을 해도 NULL이 나온다

​       

### ORDER BY절

```SQL
SELECT column명 FROM 테이블명 WHERE 조건
ORDER BY 기준칼럼 DESC (혹은 ASC);
```


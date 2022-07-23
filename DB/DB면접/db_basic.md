# DB 면접 대비

​                  

### 1. 데이터베이스의 특징

* 실시간 접근성(Real-Time Accessibility): 실시간 처리에 의한 응답이 가능
* 지속적인 변화(Continuous Evloution): 새로운 데이터의 삽입(Insert), 삭제(Delete), 갱신(Update)으로 항상 최신의 데이터를 유지
* 동시 공용(Concurrent Sharing): 다수의 사용자가 동시에 같은 내용의 데이터를 이용
* 내용에 의한 참조(Content Reference): 사용자가 요구하는 데이터 내용으로 찾기
* 데이터 독립성

​              

### 2. 데이터베이스 언어(DDL, DML, DCL)

* DML (조작어 : Data Manipulation Language) : 데이터베이스내의 자료 검색, 삽입, 갱신, 삭제를 위한 언어 ( select, insert, update, delete )

* DDL (정의어 : Data Definition Language) : 데이터베이스 구조를 정의, 수정, 삭제하는 언어 ( alter, create, drop )

* DCL (제어어 : Data Control Language) : 데이터에 대해 무결성 유지, 병행 수행 제어, 보호와 관리를 위한 언어 ( commit, rollback, grant, revoke )

​                

### 3. SELECT 쿼리문 실행 순서

```
FROM, ON, JOIN > WHERE, GROUP BY, HAVING > SELECT > ORDER BY > DISTINCT > LIMIT
```

1. FROM
- 각 테이블을 확인한다.
2. ON
- JOIN 조건을 확인한다.
3. JOIN
- JOIN이 실행되어 데이터가 SET으로 모아지게 된다. 서브쿼리도 함께 포함되어 임시 테이블을 만들 수 있게 도와준다.
2. WHERE
- 데이터셋을 형성하게 되면 WHERE의 조건이 개별 행에 적용된다. WHERE절의 제약 조건은 FROM절로 가져온 테이블에 적용될 수 있다.
3. GROUP BY
- WHERE의 조건 적용 후 나머지 행은 GROUP BY절에 지정된 열의 공통 값을 기준으로 그룹화된다. 쿼리에 집계 기능이 있는 경우에만 이 기능을 사용해야 한다.
4. HAVING
- GROUP BY절이 쿼리에 있을 경우 HAVING 절의 제약조건이 그룹화된 행에 적용된다.
5. SELECT
- SELECT에 표현된 식이 마지막으로 적용된다.
6. DISTINCT
- 표현된 행에서 중복된 행은 삭제
7.ORDER BY
- 지정된 데이터를 기준으로 오름차순, 내림차순 지정
8. LIMIT
- LIMIT에서 벗어나는 행들은 제외되어 출력된다.

​                 

### 4. 트리거(Trigger)

* 트리거는 특정 테이블에 대한 이벤트에 반응해 INSERT, DELETE, UPDATE 같은 DML 문이 수행되었을 때, 데이터베이스에서 자동으로 동작하도록 작성된 프로그램
* 사용자가 직접 호출하는 것이 아닌, 데이터베이스에서 자동적으로 호출한다는 것이 가장 큰 특징

```sql
CREATE TRIGGER check_removed_name
	AFTER DELETE 			-- 삭제 되면 작동
	ON user_address_table		-- 어떤 테이블에?
    FOR EACH ROW			-- 각 row(행) 마다 적용

-- 테이블에 백업데이터 삽입
BEGIN
	INSERT INTO removedName
		VALUES (OLD.ID, OLD.Name, OLD.Address, CURDATE() );
END
```

​              

### 5. Index에 대해 설명해주시고, 장/단점에 대해 아는대로 말해주세요.

> B+Tree: 중간 노드는 분류의 역할만 수행하고 맨 끝 리프 노드에서만 정보들을 저장한다.
> 해시테이블: 컬럼의 값을 해쉬화한 해시가 곧 인덱스 번호가 된다.

* Index란 테이블을 처음부터 끝까지 검색하는 방법인 FTS(Full Table Scan)과는 달리 인덱스를 검색하여 해당 자료의 테이블을 엑세스 하는 방법

* 인덱스는 항상 정렬된 상태를 유지하기 때문에 원하는 값을 검색하는데 빠르지만, 새로운 값을 추가하거나 삭제, 수정하는 경우에는 쿼리문 실행 속도가 느려집니다.
* 인덱스는 데이터의 저장 성능을 희생하고 그대신 데이터의 검색 속도를 높이는 기능이라 할 수 있습니다.

​                 

### 6. 정규화

#### 1 정규화)

* Atomic Value(원자 값):같은 칼럼인데 여러 데이터가 들어가지 않도록 칼럼 쪼개기

​             

#### 2 정규화)

* 1 정규형 만족
* 속성이 기본키에 완전 함수 종속이도록 분해(기본키의 부분집합이 다른 키의 값을 결정하지 않도록)
  * ex) 고양이면 동물인 것은 당연하니까 굳이 고양이와 동물을 같은 데이터에 넣지 않고 분리한다.

​               

#### 3 정규화)

* 2 정규형 만족
* 이행적 함수 종속을 없애도록 한다.
  * A가 B일 때 B가 C라면 A -> C가 성립할 때 다음 문제가 발생한다.
  * B의 값을 수정했을 때 C의 값도 같이 수정하지 않으면 오류가 발생한다.
  * B와 C를 분리하고 FK 등으로 연결해줘야 한다.

​             

#### 4) BCNF

* 모든 키가 후보키가 되어야 한다.
  * 즉 모든 칼럼을 포함해서 그 데이터를 정의할 수 있어야 한다.
  * 만약 칼럼이 총 3개인데 2개만으로도 PK를 만들 수 있다면 BCNF를 정의하지 못한 것이다.

​                  

#### 5) 역정규화

*  무분별한 JOIN 방지

​              

### 7. 이상 현상

1. 삽입 이상: NULL값을 넣어야 할 때
2. 갱신 이상: 데이터가 일부만 수정될 때
3. 삭제 이상: 다른 정보가 연결되어 삭제될 때


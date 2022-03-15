## 1. RDBMS & SQL

> ### RDBMS ?
>
> * 관계형(Relational) 데이터베이스 시스템
> * 테이블기반(Table based)의 DBMS
>   * 데이터를 테이블 단위로 관리
>     * 하나의 테이블은 여러 개의 컬럼(column)으로 구성
>   * 중복 데이터를 최소화 시킴
>     * 같은 데이터가 여러 칼럼 또는 테이블에 존재했을 경우
>       * 데이터를 수정 시 문제가 발생할 가능성이 높아짐 - 정규화
>   * 여러 테이블에 분산되어 있는 데이터를 검색 시 테이블 간의 관계(join)을 이용해 필요한 데이터를 검색
>
> ​         
>
> #### RDBMS 저장 구조
>
> * column name, column, row
>
> ​        
>
> ### SQL ?
>
> > DCL, DDL, DML로 구분한다.
>
> * Database에 있는 정보를 사용할 수 있도록 지원하는 언어
> * 모든 DBMS에서 사용 가능
> * 대소문자는 구분하지 않음(단, 데이터의 대소문자는 구분)
>
> ​                     

## SQL 구문

| 문장     | 설명                                                         |
| -------- | ------------------------------------------------------------ |
| INSERT   | DML(Data Manipulation Language), 행을 입력                   |
| UPDATA   | DML(Data Manipulation Language), 행을 변경                   |
| DELETE   | DML(Data Manipulation Language), 행을 제거                   |
| SELECT   | DML(Data Manipulation Language), Database로 부터 Data를 검색 |
| CREATE   | DDL(Data Definition Language), 테이블로부터 데이터 구조 생성 |
| ALTER    | DDL(Data Definition Language), 테이블로부터 데이터 구조 변경 |
| DROP     | DDL(Data Definition Language), 테이블로부터 데이터 구조 제거 |
| RENAME   | DDL(Data Definition Language), 테이블로부터 데이터 구조 이름 변경 |
| COMMIT   | DML, 수행한 변경을 관리                                      |
| ROLLBACK | DML, 수행한 변경을 관리                                      |
| GRANT    | DCL(Data Control Language) 접근 권한 제공                    |
| REVOKE   | DCL(Data Control Language) 접근 권한 제거                    |

​         

### SQL 종류

#### - DDL(Data Definition Language): 데이터 정의어

* 데이터베이스 객체(table, view, index,...)의 구조를 정의
* 테이블 생성, 컬럼 추가, 타입변경, 제약조건 지정, 수정 등

| SQL문  | 설명                                |
| ------ | ----------------------------------- |
| CREATE | 데이터베이스 객체 생성              |
| DROP   | 데이터베이스 객체 삭제              |
| ALTER  | 데이터베이스 객체 수정(기존에 존재) |

​          

#### - DML(Data Manipulation Language): 데이터 조작어

* Data 조작기능
* 테이블의 레코드를 CRUD (Create, Retrieve, Update, Delete)

| SQL문     | 설명                                |
| --------- | ----------------------------------- |
| INSERT(C) | 데이터베이스 객체에 데이터를 입력   |
| SELECT(R) | 데이터베이스 객체에서 데이터를 조회 |
| UPDATE(U) | 데이터베이스 객체에 데이터를 수정   |
| DELETE(D) | 데이터베이스 객체에 데이터를 삭제   |

​         

#### - DCL(Data Control Language): 데이터 제어어

* DB, Table의 접근권한이나 CRUD 권한을 정의
* 특정 사용자에게 테이블의 검색권한 부여/금지 등

| SQL문  | 설명                          |
| ------ | ----------------------------- |
| GRANT  | 데이터베이스 객체에 권한 부여 |
| REVOKE | 데이터베이스 객체 권한 취소   |

​        

#### TCL(Transaction Control Language): 데이터 제어어

* Transaction: 데이터베이스 논리적 연산의 단위

| SQL문    | 설명                                                     |
| -------- | -------------------------------------------------------- |
| COMMIT   | 실행한 Query를 최종적으로 적용                           |
| ROLLBACK | 실행한 Query를 마지막 COMMIT 전으로 취소시켜 데이터 복구 |

​         

​        

## Table에서 데이터 타입

* CHAR[ ] : 고정 길이를 갖는 문자열 저장, 1 ~ 255, 전체 공간을 사용하지 않더라도 무조건 고정 장소를 차지
* VARCHAR[ ]  : 가변 길이 문자열 저장, 10만 저장하면 실제로 10만큼 기억장소 차지
* TEXT[ ] : 최대 65535byte
* INT[ ] : signed(음수포함)/unsigned(0포함 양수만)
* DATETIME : YYYY-MM-DD
* TIMESTAMP[ ]: 1970-01-01부터 2038-01-19까지 지원, Index가 더 빠르게 생성 


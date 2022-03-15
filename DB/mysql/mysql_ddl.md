## DDL

> Data Definition Language
>
> **MySQL은 시작할 때 어느 데이터베이스를 사용할지 알려주어야 한다**

### CREATE

* 다국어 처리(utf8mb3) 데이터베이스 생성

```sql
CREATE DATABASE 데이터베이스명;
DEFAULT CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci;
```

* 이모지 문자까지 처리

```sql
CREATE DATABASE 데이터베이스명;
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
```

​          

#### table

* 테이블 생성

```sql
CREATE TABLE 테이블명(
	컬럼명1,
  컬럼명2,
  컬럼명3,
);
```

| Optional Attributes | 설명                                                         |
| ------------------- | ------------------------------------------------------------ |
| NOT NULL            | 각 행은 해당 열의 값을 포함, null값은 허용X                  |
| DEFAULT value       | 값이 전달되지 않을 때 추가되는 기본값 설정                   |
| UNSIGNED            | Type이 숫자인 경우만 해당되며 숫자가 0 또는 양수로 제한됨    |
| AUTO INCREMENT      | 새 레코드가 추가될 때마다 필드 값을 자동으로 1증가시킴       |
| PRIMARY KEY         | 테이블에서 행을 고유하기 식별하기 위해 사용. 보통 ID값에 적용하며 AUTO INCREMENT와 함께 적용 |

*  제약조건
  * 컬럼에 저장될 데이터의 조건 지정
  * 위배되는 데이터는 저장 불가
  * `CONSTRAINT`로 지정, 또는 `ALTER`를 이용해 설정 가능

| 제약 조건   | 설명 |
| ----------- | ---- |
| NOT NULL    |      |
| UNIQUE      |      |
| PRIMARY KEY |      |
| FOREIGN KEY |      |
|             |      |
|             |      |

​                

### ALTER

* 데이터베이스 변경

```sql
ALTER DATABASE 데이터베이스명
DEFAULT CHARACTER SET 값 COLLATE 값;
```

​        

### DROP

* 데이터베이스 삭제

```sql
DROP DATABASE 데이터베이스명;
```

* 데이터베이스 사용

```sql
USE 데이터베이스명;
```


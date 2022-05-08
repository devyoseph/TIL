## MyBatis 

  \- Spring 연동(web.xml)

```xml
<bean id="dataSource" class="org.springframework.jndi.JndiObjectFactoryBean">
		<property name="jndiName" value="java:comp/env/jdbc/site"></property>
</bean>
	
	<!-- <bean id="sqlSessionFactoryBean" class="org.mybatis.spring.SqlSessionFactoryBean">
		<property name="dataSource" ref="dataSource"/>
		<property name="configLocation" value="classpath:mybatis-config.xml"/>
		<property name="mapperLocations">
			<list>
				<value>classpath:mapper/member.xml</value>
				<value>classpath:mapper/home.xml</value>
			</list>
		</property>
	</bean> -->
	
	<bean id="sqlSessionFactoryBean" class="org.mybatis.spring.SqlSessionFactoryBean">
		<property name="dataSource" ref="dataSource"/>
		<property name="typeAliasesPackage" value="com.site.home.model"/>
		<property name="mapperLocations" value="classpath:mapper/*.xml"/>
	</bean>
	
	<!-- <bean id="sqlSession" class="org.mybatis.spring.SqlSessionTemplate">
		<constructor-arg ref="sqlSessionFactoryBean"></constructor-arg>
	</bean> -->
	
	<!-- mybatis에서 제공하는 scan 태그를 통해 repository interface들의 위치를 지정. -->
	<mybatis-spring:scan base-package="com.site.home.model.mapper"/>
	
	<bean id="transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
		<property name="dataSource" ref="dataSource" />
	</bean>
	
	<tx:annotation-driven transaction-manager="transactionManager"/>
```

​           

  \- web.xml 에서 mapper 읽어들이기 

```xml
<mybatis-spring:scan base-package=“com.site.root.model.mapper”/>
```

​           

  \- transaction 연동(이건 필수)

```xml
<bean id="transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
	<property name="dataSource" ref="dataSource" />
</bean>
```

​            

\- 어노테이션 기반 트랜잭션 설정(선택)

````xml
<tx:annotation-driven transaction-manager=“transactionManager”/>
````

````java
@Transactional
````

​           

\- mybatis-spring:scan 을 Annotation으로 등록

```java
@MapperScan(basePackages = {"com.site.root.**.mapper"})
```

​               

  \- 객체와 메서드

​	1. SqlSessionFactory = SqlSessionFactoryBuilder.build(reader)

​	2. SqlSession = SqlSessionFactory.openSession()

​                              

  \- 구성파일

 1. MyBatis 설정파일: sqlMappingConfig.xml (sqlMappingConfig.java 에서 읽어들이기)

    ```xml
    <configuration>
        <properties resource="dbinfo.properties"/>
    
        <typeAliases>
          <typeAlias type="com.site.root.model.MemberDto" alias="member" />
          <typeAlias type="com.site.root.model.BookDto" alias="root" />
          <typeAlias type="com.site.root.model.FileInfoDto" alias="fileinfo" />
        </typeAliases>
    
        <environments default="development">
              <environment id="development">
                  <transactionManager type="JDBC"/>
                  <dataSource type="POOLED">
                      <property name="driver" value="${driver}"/>
                      <property name="url" value="${url}"/>
                      <property name="username" value="${dbid}"/>
                      <property name="password" value="${dbpwd}"/>
                  </dataSource>
              </environment>
          </environments>
    
    
      <mappers>
          <mapper resource="root.xml" />
          <mapper resource="member.xml" />
      </mappers>
    
    </configuration>
    ```

    ​            

​	2. Mapping 파일

```xml
<mapper namespace="com.site.root.model.mapper.MemberMapper">
</mapper>
```

* select, insert, update, delete

  * 공통 속성: id, parameterType

  ```xml
  <mapper namespace="com.site.root.model.mapper.MemberMapper">
  	<select id="메서드명" parameterType="String" resultType="MemberDto">
    </select>
     
    <insert id="메서드명" parameterType="MemberDto">
    </insert>
    
    <update id="메서드명" parameterType="map">
    </update>
    
    <delete id="메서드명" parameterType="String">
    </delete>
  </mapper>
  ```

     - select만 존재: resultType / resultMap

       ```xml
       <resultMap type="BookDto" id="articleList">
       		<result column="articleno" property="articleNo"/>
       		<result column="userid" property="userId"/>
       		<result column="username" property="userName"/>
       		<result column="subject" property="subject"/>
       		<result column="content" property="content"/>
       		<result column="regtime" property="regTime"/>
       		<collection property="fileInfos" column="articleno=articleno" javaType="list" ofType="FileInfoDto" select="fileInfoList"/>
       </resultMap>
       ```

  ​                 

  * select외에 존재: 값이 성공적으로 변경된 것을 알려주기 위함

    ```xml
    <selectKey resultType="int" keyProperty="articleNo" order="AFTER">
        select last_insert_id()
    </selectKey>
    ```

​                   

  \- 태그들과 태그 속성 (sql, selectKey 포함) + 동적 쿼리 태그

```xml
<sql id="name">
```

  - include refid로 저장한 sql문 불러오기 

    - where: 뒤에 AND나 OR가 바로 붙는다면 지워준다.

    ```xml
    <where>
      <include refid="search"></include>
    </where>
    ```

    * if문

      ```xml
      <if test="조건"></if>
      ```

      ​                 

    * choose문

      ```xml
      <choose>
        <when test="">
        </when>
        
        <otherwise>
        </otherwise>
      </choose>
      ```

      ​                   

* 동적쿼리 태그(동적 SQL문): #을 더 현업에서 선호하는 이유

  * ${} : 파라미터가 바로 출력된다. 내부에 쿼리문을 넣을 경우 바로 실행된다.

  * #{} : ‘작은 따옴표’로 감싸진 String 값이 들어온다. **쿼리 주입**을 예방할 수 있다

​                      

### 테이블 제약조건

\- PK, FK 설정이유: 데이터의 무결성(Data Integrity)

* PK: 데이터의 무결성: NOT NULL + UNIQUE
* FK: 참조되는 키가 해당 relation에서 PK이므로 참조 무결성을 보장할 수 있다.

​                                   

\- 제약사항 종류: ex) ON DELELTE CASCADE / ON UPDATE RESTRICT

​	RESTRICT: 참조하는 부모테이블의 id값을 생신, 삭제 불가

​	CASCADE: 부모테이블의 id 값을 갱신 삭제할 때 자식 테이블도 모두 갱신, 삭제

​	SET NULL: 부모테이블의 id값을 갱신,삭제할 때 자식 테이블의 칼럼값은 NULL

​	NO ACTION: 부모테이블의 id값을 갱신, 삭제해도 반응하지 않음

​            



### index 특징, 사용법

> index: 추가적인 공간을 활용해 데이터베이스의 테이블의 검색 속도를 향상시키기 위한 자료구조

1. Clustered INDEX: 테이블마다 1개 생성 가능, 기본키에 INDEX 자동 생성

   ```sql
   CREATE CLUSTERED INDEX 인덱스명 ON 테이블명 (칼럼명);
   ```

2. Non-Clustered INDEX: 따로 저장공간을 활용해 여러 개의 인덱스 생성 가능

   ```sql
   CREATE INDEX 인덱스명 ON 테이블명 (칼럼명);
   ```

3. Composite INDEX 생성: 칼럼들을 종합한 인덱스 생성

   ```sql
   CREATE INDEX 인덱스명 ON (칼럼명1, 칼럼명2,…)
   ```

​                         

### view 특징, 사용법

>VIEW는 사용자에게 접근이 허용된 자료만을 제한적으로 보여주기 위해 하나 이상의 기본 테이블로부터 유도된, 이름을 가지는 **가상 테이블**이다.

1. VIEW 생성

   ```sql
   CREATE VIEW TOP5_Salary AS SELECT * FROM main.practice ORDER BY Sales DESC LIMIT 5;
   ```

2. VIEW 삭제

   ```sql
   DROP VIEW 이름 RISTRICT; // RISTRICT: 다른 곳에서 참조하지 않는 경우에만 삭제 가능
   ```

3. **VIEW 사용**

   >**편의성**: VIEW를 통해 재사용성 증가(복잡한 쿼리문을 ALIAS로 사용),
   >
   >**데이터 독립성**: 민감한 정보에 직접 접근하지 않고 조회문을 통해 공유
   >
   >**내용 변경 불가**: ALTER VIEW 사용 불가, 수정하기 위해선 삭제 후 재생성
   >
   >**테이블명 사용 불가**: 이미 있는 테이블 이름은 VIEW 이름으로 지정 불가

​                             

### Select

> 실행순서: FROM - WHERE - GROUP BY - HAVING - SELECT - ORDER BY - LIMIT

\- 연산자 (like, in, not in, is null 등)

​	- DISTINCT: 중복제거

​	- ALIAS: 별칭

​                   

### JOIN 

  \- 종류: INNER JOIN, LEFT/RIGHT OUTER JOIN, FULL OUTER JOIN(Mysql은 UNION 사용)

  \- 필수 키워드: ON 또는 USING(alias를 사용할 수 없다)

  \- JOIN 조건 명시에 따라: SELF JOIN, NATURAL JOIN, CROSS JOIN(FULL JOIN, CARTESIAN JOIN) 

  \- 사용방법: INNER JOIN은 MySQL 옵티마이저가 조인의 순서를 조절해 최적화하지만 OUTER JOIN은 이미 순서가 정해져있다.



서브쿼리

​	WHERE 절에서 사용: Nested Subquery

​	FROM 절에서 사용: Inline View

​	SELECT 절에서 사용: Scalar Subquery



서브쿼리의 활용

​	create table 테이블명 select * from tables : CREATE 하면서 동시에 값을 집어넣는 방법

​	insert into 테이블명 select * from where A: 조건 A에 맞는 정보를 모두 insert

​	



DDL(Data Definition Language, 데이터 정의어): CREATE, ALTER, DROP, RENAME

  \- auto commit 이므로 주의한다.

  \- CREATE: 데이터베이스 객체 생성 / DROP: 데이터베이스 객체 삭제 / ALTER: 데이터베이스 객체 수정

  \- 테이블 생성: CREATE TABLE 테이블명 ( column명 데이터타입 NOT NULL AUTO_INCREMENT, …, PRIMARY KEY(idx) )



DML(Data Manipulation Language. 데이터 조작어): INSERT(C) INTO ~ VALUES(), SELECT(R), UPDATE(U) ~ SET~ WHERE , DELETE(D) FROM ~ WHERE

​	- DELETE FROM 객체명 = 객체 내용 전체 삭제

​	



DCL(Data Control Language): 데이터 접근 권한 관련

​	- GRANT(권한 제공), REVOKE(권한 제거)





TCL(Transaction Control Language, 트랜잭션 제어어): 트랜잭션 = 데이터베이스 논리적 연산 단위

​	- start transaction; (굳이 안써도 알아서 해준다)

​	- commit;

​	- savepoint a;

​	- rollback to savepoint a;

​	- rollback;



그룹함수: MAX, MIN, COUNT, AVG(), SUM()



이외의 함수들:

​	- BINARY: mysql은 대소문자 구분을 못하기 때문에

​	- IF(A, B, C): A가 참이면 B 거짓이면 C

​	- IFNULL( column, value)

​	- NULLIF(a, b): a와 b가 같으면 NULL 표기

​	- DATE_ADD(A, INTERVAL B) ex) INTERVAL 5 HOUR

​	- DATE_FORMAT(A, “FORMAT”)

​	- REVERSE(A), REPLACE(A, B, C), SUBSTRING(A, start, length), LOWER(), UPPER(), LEFT(a,b), RIGHT(a, b)

​	- ABS(), CEIL(), FLOOR(), ROUND(), TRUNCATE(a, b), POW(a, b), MOD(a, b), GREATEST() , LEAST()



데이터모델링

​	- Entity(개체): 사용자와 관계가 있는 주요 객체, 데이터로 관리되어야할 정보들 (=명사적 표현)

​	- Attrinute(속성): 저장할 필요가 있는 실체에 관한 정보

​	- E-RM / E-R Diagram: Entity Relationship Model/Diagram

​		- 네모: 개체, 동그라미: 속성



모델링 단계: 개념적 - 논리적 - 물리적



기타 추가 키워드들: DESC, SHOW
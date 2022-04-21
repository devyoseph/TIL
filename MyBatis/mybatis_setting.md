## MyBatis 설정(API 참고)

* Pom.xml에 다름과 같은 라이브러리들이 추가되어있어야 한다.

```xml
<mysql-connector-java-version>8.0.28</mysql-connector-java-version>
	<mybatis-version>3.5.9</mybatis-version>
<mybatis-spring-version>2.0.7</mybatis-spring-version>
```

```xml
<dependency>
			<groupId>org.mybatis</groupId>
			<artifactId>mybatis</artifactId>
			<version>${mybatis-version}</version>
		</dependency>
		
		<!-- https://mvnrepository.com/artifact/org.mybatis/mybatis-spring -->
		<dependency>
			<groupId>org.mybatis</groupId>
			<artifactId>mybatis-spring</artifactId>
			<version>${mybatis-spring-version}</version>
		</dependency>
```

​            

​              

### 1. mybatis-config.xml

> src/main/resources 내부에 보통 집어넣는다.
>
> xml 형식에서 순서가 지정되어있기 때문에 마구잡이로 작성하지 않도록 주의한다.

```xml
<configuration>

	<properties resource="dbinfo.properties"/>

	<typeAliases>
		<typeAlias type="com.sofia.guestbook.model.GuestBookDto" alias="guestbook" />
		<typeAlias type="com.sofia.guestbook.model.FileInfoDto" alias="fileinfo" />
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
    
    <!--<environments default="development">
        <environment id="development">
            <transactionManager type="JDBC" />
            <dataSource type="JNDI">
                <property value="java:comp/env/jdbc/sofia" name="data_source"/>
            </dataSource>
        </environment>
    </environments>-->
    
    <mappers>
		<mapper resource="guestbook.xml" />
	</mappers>
	
</configuration>
```

​            

### 2. properties

* Database 접속 정보를 따로 빼두어서 관리하는 것이 보통이다.
* mybatis-config에 properties로 연결해준다.

​            

### 3. mapper

```xml
    <mappers>
		<mapper resource="guestbook.xml" />
		<mapper resource="member.xml" />
	</mappers>
```

* 설정파일에서 mapper를 이용해 xml을 연결할 수 있는데 guestbook.xml 은 java 객체와 mybatis를 연결해주는 역할을 한다.
* 중간에 매핑이 실패하면 그 뒤 문장이 모두 오류나므로 중간중간 테스트를 할 수 있도록 한다.

​            

### 4. SqlMapConfic.java

* util package에서 SqlSession을 만들어주어야 한다.

```java
package com.sofia.util;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class SqlMapConfig {
	
	private static SqlSessionFactory factory;

	static {
		try {
			String resource = "mybatis-config.xml";
			Reader reader = Resources.getResourceAsReader(resource);
			factory = new SqlSessionFactoryBuilder().build(reader);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static SqlSession getSqlSession() {
		return factory.openSession(); //생략시 openSession(false): 웬만하면 true를쓰지말자
	}
	
}

```

​               



### 5. mapping을 위한 xml 생성

* 위 DOCTYPE이 mapper.dtd인 것을 가져와야 작동함을 주의한다.(config와 구분한다)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper
PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper>


</mapper>
```

* mapper의 namespace는 DaoImpl이 있는 패키지를 넣어준다(권장사항).

```xml
<mapper namespace="com.sofia.guestbook.model.dao.MemberDao">
	
</mapper>
```

* insert의 id는 메소드의 이름으로 넣어준다.

```xml
<mapper namespace="com.sofia.guestbook.model.dao.MemberDao">
	<insert id="registerMember" parameterType="com.sofia.guestbook.model.MemberDto">

	</insert>
</mapper>
```

* parameterType은 데이터 형식이다
  * Dto: 내가 만들어둔 경로를 적어준다.
  * Map: (Mybatis API문서를 참조) map 만 써줘도 된다.(본래 java.util.~)

​                   

### 6. config에 Type Alias 생성

* 매핑할 때 매 번 풀 주소를 적어야 하는데 **mybatis-config**의 Alias를 설정해서 이를 줄일 수 있다.

```xml
	<typeAliases>
		<typeAlias type="com.sofia.guestbook.model.MemberDto" alias="member" />
		<typeAlias type="com.sofia.guestbook.model.GuestBookDto" alias="guestbook" />
		<typeAlias type="com.sofia.guestbook.model.FileInfoDto" alias="fileinfo" />
	</typeAliases>
```

​            

### 7. Alias를 사용한 매핑

> 원래 prepareStatement에서의 ? 부분을 #{getter 메소드 이름 }으로 바로 넣어줄 수 있다.

* Alias를 사용하지 않으면 다음과 같다.

```xml
<mapper namespace="com.sofia.guestbook.model.dao.MemberDao">
	<insert id="registerMember" parameterType="com.sofia.guestbook.model.MemberDto">
	insert into ssafy_member (userid, username, userpwd, email, joindate)
	values (#{userId}, #{userName}, #{userPwd}, #{email}, now())
	</insert>
</mapper>
```

* Alias를 사용하면 다음과 같다.

```xml
<mapper namespace="com.sofia.guestbook.model.dao.MemberDao">
	<insert id="registerMember" parameterType="member">
	insert into ssafy_member (userid, username, userpwd, email, joindate)
	values (#{userId}, #{userName}, #{userPwd}, #{email}, now())
	</insert>
</mapper>
```

​             

### 8. Dao 파일에 SqlSession 연결

* DaoImpl java 파일에 SqlSession을 연결하고 (try~catch 사용) 위에서 mapper에 매핑해준 **namespace**와 **id**를 `sqlSession.insert()`에 Dto와 함께 넣어준다.

```java
	@Override
	public void registerMember(MemberDto memberDto) throws SQLException {
		try(SqlSession sqlSession = SqlMapConfig.getSqlSession()){
					    sqlSession.insert("com.sofia.guestbook.model.dao.MemberDao.registerMember",memberDto);
      sqlSession.commit();
		}
	}
```

​                  

### 9. SqlSession Select 문 사용하기

* .insert()가 있고

* .selectOne()을  로그인시 사용한다.

  ```java
  	@Override
  	public MemberDto login(Map<String, String> map) throws SQLException {
  		try(SqlSession sqlSession = SqlMapConfig.getSqlSession()){
  			return sqlSession.selectOne("com.sofia.guestbook.model.dao.MemberDao.login",map);
  		}
  	}
  ```

* 이를 위해 member.xml 의 mapper에 등록해주어야 한다.

  ```xml
  <mapper namespace="com.sofia.guestbook.model.dao.MemberDao">
  	<insert id="registerMember" parameterType="com.sofia.guestbook.model.MemberDto">
  	insert into ssafy_member (userid, username, userpwd, email, joindate)
  	values (#{userId}, #{userName}, #{userPwd}, #{email}, now())
  	</insert>
  	
  	<select id="login" parameterType="map">
  	
  	</select>
  </mapper>
  ```

* resultType 을 memer(com.sofia.guestbook.model.MemberDto)로 설정하면

  * select 문에서 검색 결과로 내어주는 Column값들을 다시 setter 메서드와 매칭해서 그 데이터로 넣어준다.

  ```xml
  <select id="login" parameterType="map" resultType="member">
  	select userid, username
  	from ssafy_member
  	where userid = #{userId} and userpwd = #{userPwd}
  </select>
  ```

​             

### 10. resultType

* resultType을 설정하면 select문의 결과 column값들을 setter메서드와 연동해서 다시 넣어주고 해당 타입으로 반환해준다.

```xml
<select id="login" parameterType="map" resultType="com.sofia.guestbook.model.MemberDto">
	select userid, username
	from ssafy_member
	where userid = #{userId} and userpwd = #{userPwd}
</select>
```




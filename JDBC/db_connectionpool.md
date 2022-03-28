## DB 연결에서 발생할 수 있는 문제점

* 여러 사람들이 DB 연결을 유지하고 있으면 유지하기 위한 프로세스들이 실행된다.
* 만약 DB접속을 유지하고 있으면 다른 사람들이 DB를 사용할 수 없을 것이다
* DB 연결을 매 번 끊어주면 다시 새로운 사용자가 DB요청을 할 때 프로세스들이 실행되는데 시간의 딜레이가 발생한다.
* **이를 극복하기 위해 미리 연결한 다음, 필요할 때만 자원을 사용하는 방식으로 처리한다**
  * 사용 후에 자원을 반납한다. = pool 이라고 한다.

​         

## DB Connection pool

* 페이지를 처음 로드할 때 DB를 연결한 객체를 보관한다

  * JNDI(ava Naming and Directory Interface API): 경로(Directory)와 이름(Name)을 저장

    * `file:\\` = 보통은 생략하는 프토로콜

    * Root(C:\)

      ```powershell
      C:\\폴더명\\파일명.txt
      ```

​         

### JDBC에서의 적용

```java
package com.sofia.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DBUtil {
/*
매번 연결할 때마다 로그인하지 않는다 = Java에서 로그인할 필요가 없다

	private final String driverName = "com.mysql.cj.jdbc.Driver";
	private final String url = "jdbc:mysql://127.0.0.1:3306/sofiaweb?serverTimezone=UTC";
	private final String user = "sofia";
	private final String pass = "sofia1234";
즉 자바 상에서 DB 접근 정보가 필요하지 않다.
*/

	private static DBUtil instance = new DBUtil();
	
	private DBUtil() {}

	public static DBUtil getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws SQLException {
		try {
			Context context = new InitialContext(); //JNDI 에 있는 InitialContext() 사용
			Context rootContext = (Context) context.lookup("java:comp/env"); //root 경로 얻어오기
			DataSource dataSource = (DataSource) rootContext.lookup("jdbc/sofia");
      // 얻어온 root를 기준으로 객체 꺼내오기: dataSource 객체를 이용해 바로 연결할 수 있다.
			return dataSource.getConnection();
		} catch (NamingException e) {
			e.printStackTrace();
		}
		return null;
	}

	public void close(AutoCloseable... closeables) {
		for (AutoCloseable c : closeables) {
			if (c != null) {
				try {
					c.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
	
}
```

### 로그인 정보의 보관

* Webcontent 내부 META-INF에서 보관

<img src="db_connectionpool.assets/image-20220328144747264.png" alt="image-20220328144747264" style="zoom:50%;" />

* 비밀번호등 정보를 수정한다.
# MariaDB docker

### 1. Dockerfile

```docker
FROM mariadb

# Docker 초기 생성시에 데이터베이스가 제대로 생성되지 않는다.
# ENV MYSQL_DATABASE imagination_playground
ENV MYSQL_ROOT_PASSWORD yodel1234

# WORKDIR에서 이전에 폴더를 만들어 놓지않더라도 자동으로 생성해서 들어간다.
WORKDIR /etc/mysql/setDB

# 확인용 명령어
RUN pwd

# 초기 세팅 SQL 파일 Docker로 Copy
COPY ./setDB.sql /etc/mysql/setDB/setDB.sql
RUN ls -al

# 내부 포트 열기
EXPOSE 3306

# MariaDB Config Setting (table 소문자, 한국 시간, 한글 깨짐 수정 등)
RUN echo lower_case_table_names=1 >> /etc/mysql/conf.d/docker.cnf
RUN echo default-time-zone='+9:00' >> /etc/mysql/conf.d/docker.cnf
RUN echo collation-server = utf8mb4_general_ci >> /etc/mysql/conf.d/docker.cnf
RUN echo character-set-server = utf8mb4 >> /etc/mysql/conf.d/docker.cnf
RUN echo skip-character-set-client-handshake >> /etc/mysql/conf.d/docker.cnf
```

### 2. Docker-compose

```docker
# 프로젝트 Root 폴더
# 프로젝트Root/docker-compose.yml
version: '3.7'

services:

  frontend:
    image: frontend-react
    build:
      context: frontend/
      dockerfile: Dockerfile
    ports:
      - "80:80"
      - "443:443" 
    # [인증서 파일 저장 경로]:/var/www/html
    volumes:
      - /home/ubuntu/docker-volume/pem:/var/www/html
    container_name: "frontend"

  backend:
    image: backend-spring
    build:
      context: backend/
      dockerfile: Dockerfile
    ports:
      - "8443:8443"
    volumes:
      - /home/ubuntu/docker-volume/pem:/root
    container_name: "backend"

  mariadb:
    image: database-mariadb
    build: 
      context: db/
      dockerfile: Dockerfile
    ports :
      - "3306:3306"
    # volumes:
    #   - ./imagination_playground-20220810.sql:/docker-entrypoint-initdb.d/dump.sql
    container_name: "mariadb"
    restart: always
```

### 3. Dbeaver 연결

- MySql 내부 포트 설정 변경
    1. 설정 파일 이동
        
        ```bash
        $ cd /etc/mysql/
        ```
        
    2. mysql.conf에서 mysql.cnf를 들어간다.
        
        ```bash
        $ vi mysql.conf.d
        ```
        
    3. bind-address = 127.0.0.1 부분을 주석처리한다.
        
        ```bash
        # bind-address = 127.0.0.1
        ```
        
    4. mariaDB의 경우 다음 경로일 수 있다.
        
        ```bash
        $ vim /etc/mysql/mariadb.conf.d/50-server.cnf # vim 이 없으면 apt-get 업데이트 후 설치
        ```
        
    5. mysql 내부 설정 변경
        
        ```sql
        grant all privileges on *.* to 'root'@'%' identified by '비밀번호'; flush privileges;
        ```
        
    6. MySQL restart
        
        ```bash
        $ sudo /etc/init.d/mysql restart
        ```
        
- ubuntu 3306 포트 오픈

### - Dbeaver Workbench

- 데이터베이스 접속
    - 계정명: localhost
    - 포트: 3306
- SSH 연결
    - 포트: 22
    - ec2-user 인줄 알았지만 ubuntu인 경우였음
    - 비밀번호 pem키를 등록

### 4. dump 파일 넣기

- 내부 컨테이너 진입

```bash
$ docker exec -it mariadb /bin/bash
$ apt-get update
$ apt install vim
$ vim /etc/mysql/conf.d/docker.cnf
# 이후 맨 위 [mysqld] 집어넣기
```

- 오류주의: jenkins pipeline 단계에서 재구성하면 오류 발생
    
    ```bash
    $ chmod 755 /run/mysqld/mysqld.sock
    $ mysql -uroot -pyodel1234 < /etc/mysql/setDB/setDB.sql
    ```
    
    - docker 컨테이너로 생성하기 때문에 첫 생성 때 오류가 매우 많다.
- 먼저 mariaDB 컨테이너를 띄운 뒤 ubuntu 환경에서 dump 세팅을 완료한다.

### 5. mariaDB 접속 안되는 문제

```docker
{"message":"org.mybatis.spring.MyBatisSystemException: nested exception is org.apache.ibatis.exceptions.PersistenceException: \n### Error querying database.  Cause: org.springframework.jdbc.CannotGetJdbcConnectionException: Failed to obtain JDBC Connection; nested exception is java.sql.SQLNonTransientConnectionException: Could not connect to address=(host=localhost)(port=3306)(type=master) : Connection refused (Connection refused)\n### The error may exist in class path resource [mappers/hospital.xml]\n### The error may involve com.yodel.imaginaryPlayground.mapper.HospitalMapper.searchHospital\n### The error occurred while executing a query\n### Cause: org.springframework.jdbc.CannotGetJdbcConnectionException: Failed to obtain JDBC Connection; nested exception is java.sql.SQLNonTransientConnectionException: Could not connect to address=(host=localhost)(port=3306)(type=master) : Connection refused (Connection refused)","status":"ERROR"}
```

- classpath: 문제일 것이라 블러핑을 하지만 `src/java/resources` 는 표준 경로이기 때문에 문제가 없다.
- 결국 mariaDB 연결 문제이고 배포쪽은 아직 mysql쪽과 코드가 매우 유사하다.
    - 권한 설정
        - 권한을 부여하기 위해 내부 도커로 진입해서 root로 접근한다.
            
            ```bash
            $ docker exec -it mariadb bash # mariadb 도커 접속
            $ mysql -u root -p # 권한부여를 위해 root 계정으로 접속
            ```
            
        - 권한을 설정한 계정을 생성한다.
            
            ```sql
            CREATE user '계정이름'@'%' identified by '비밀번호';
            ```
            
            ```sql
            GRANT ALL PRIVILEGES ON *.* to 계정이름@'%' identified by '비밀번호';
            ```
            
            ```sql
            FLUSH PRIVILEGES;
            ```
            
            - 다시 CTRL+C로 나간다음 만든 계정으로 접속한다.
            
            ```bash
            mysql -u 계정이름 -p 비밀번호
            ```
            
            - 내부에서 데이터베이스 권한을 본다
            
            ```sql
            SHOW DATABASES; # 권한들을 보여준다.
            ```
            
        
        ### 1. 기타 오류 조심할 것
        
        - [application.properties](http://application.properties) 파일말고 배포용 설정파일을 따로 사용(ssl 설정)하기 때문에 거기다 내용 변경을 해야할 것을 명심한다.
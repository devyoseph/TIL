# docker - oracle, MYSQL 설치

### Oracle 설치

> 설치확인: http://localhost:8080/apex/
 - Workspace : internal
 - Username : ADMIN
 - Password : oracle
> 

```bash
$ docker search oracle
```

- 무료 버전인 `xe 버전` 설치

```bash
$ docker pull sath89/oracle-xe-11g
$ docker images # = docker image ls
```

- readme 가이드대로 실행(oracle 고유 포트: 1521)

```bash
$ docker run -d -p 8080:8080 -p 1521:1521 sath89/oracle-xe-11g
$ docker ps # 만약 안 떠있으면 docker start <container-name>
```

```bash
$ docker exec -it oracle bash # oracle 서버로 들어가기
```

**구조**

- docker > (Oracle VirualBox) > Ubuntu > oracle

### MySQL 설치

```bash
$ docker search mysql # mariadb : openSource 진영
```

```bash
$ docker pull mysql # 최신 버전(8)
$ docker pull mysql:5.7 # 현업에서는 안정화된 5버전 사용

$ docker images
```

```bash
$ docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=<설정할 비밀번호입력> --name mysql5 mysql
```

```bash
# 컨테이너 삭제 / 정리
$ docker images
$ docker stop mysql5
$ docker image rm mysql
```

**접근**

```bash
$ docker exec -it mysql5 bash

# 확인
$ cat /etc/issue
$ which mysql
```

```bash
#> mysql -u root -p
#> <위에서 설정한 비밀번호 입력>
```

```bash
mysql> show databases;
mysql> use mysql # mysql 데이터베이스 사용
mysql> show tables # mysql 내부 테이블 조회
mysql> quit
```
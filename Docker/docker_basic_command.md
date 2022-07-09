# docker 기본 명령어

> Ctrl+P, Ctrl+Q : `detach`, 컨테이너 실행 중 도커로 나오기
Ctrl+C : 오라클 VirtualBox 나가기
Ctrl+D : `stop`, 컨테이너 중단 후 도커로 나오기(= `exit` 명령어, kill)

`attach`: 실행 중인  컨테이너로 접근
> 

### 조회

```bash
$ docker ps -a # 이전 컨테이너까지 조회
$ docker container ps -a # 위와 같은 명령어

$ docker system df # 디스크 차지공간 조회

$ docker image ls # 이미지 조회
$ docker images # 위와 같은 명령어

$ docker-machine.exe ls # 도커 머신은 virtualbox 기반으로 작동, 내 pc IP와 별도의 IP로 동작
```

## Download Image & Start Docker Container

> `[https://hub.docker.com](https://hub.docker.com)`
python 등 필요한 것들을 다운로드 받을 수 있다.
> 

**pull, run, start, stop**

```bash
$ docker pull <docker-image-name[:tag-name]> # 이미지 다운로드

$ docker container run --name <container> -d -p 80:80 <image>
# 이미지 기반으로 컨테이너 실행

$ docker [start | stop | restart] <container-name>
$ docker container [pause | unpause] <container-name>

$ docker stop <container-name> # 중단
```

**exec, port, rename**

- `run` 자리를 `exec` 로 대체

```bash
$ docker container exec -it ub cat /etc/hosts # 하나의 명령 실행

$ docker start webserver
$ docker container exec -it webserver /bin/echo "Hello"

$ docker container port webserver # 사용 중인 포트 검색

$ docker container rename webserver nginxserver # 이름 변경
```

**명령어 기반으로 전체 종료**

```bash
$ docker stop `docker ps -q` # 실행 중인 전체 컨테이너 종료
```

**nginx 설치**

```bash
$ docker pull nginx # pull : image를 다운로드 받는 명령어
$ docker image ls
```

```bash
$ docker container run --name webserver -d -p 80:80 nginx
# nginx 이미지를 webserver 라는 이름으로 띄움

$ docker container ps -a # 확인
```

- `-d` : detach = foreground와 background를 분리 = 백그라운드로 실행
- `-it` : i = input, 화면에서 입력 받음, t = tty = standard out, 표준 출력
    - interactive하게 server를 실행
- `-itd` = `-it` + `-d`
- `80:80` : 현재 서버의 80포트를 내 서버의 80포트와 연결
- `6080:80` : 1000이상의 포트를 지정 (그 이하는 운영체제가 사용)
- `[localhost:6080](http://localhost:6080)` : 웹브라우저에서 해당 포트 번호로 이동

![Untitled](docker%20%E1%84%80%E1%85%B5%E1%84%87%E1%85%A9%E1%86%AB%20%E1%84%86%E1%85%A7%E1%86%BC%E1%84%85%E1%85%A7%E1%86%BC%E1%84%8B%E1%85%A5%2038472dc10a094201872d3926d07dfa76/Untitled.png)

```bash
$ docker container [top | stats] webserver # 컨테이너 정보 확인

$ docker container rm webserver # 컨테이너 삭제

# cf. prune
```

## Windows7 Oracle VirtualBox Port Forwarding

> Windows7과 Docker 사이에 Oracle VirtualBox가 있으므로 바로 도커 컨테이너로 진입하지 못하기 때문에 Port Forward로 bridge를 놓아준다.
> 

< **현재 상황 >**

- Nginx의 port 80과 docker의 port 80은 서로 연결되어있다.
- 하지만 Oracle VirtualBox로 인해 window의 80과 docker의 80은 연결된 상태가 아니다.
    - Windows7 > Oracle VirtualBox > 설정 > 네트워크 > 고급 > Port Forwarding
    

### 리눅스 설치

```bash
$ docker search ubuntu # 도커 이미지 검색: 설치 전 확인
$ docker search centos
```

```bash
$ docker pull ubuntu # 설치
$ docker pull centos
```

**centos 컨테이너 생성/실행**

```bash
$ docker container run -it --name "test1" centos /bin/cal
# test1이라는 이름으로 실행하고 /bin/cal 실행(달력)
# 실행 후 바로 종료

$ docker container run -it --name "cosh" centos /bin/bash
# /bin/bash = 'bash'만 써도 된다
# 실행 후 컨테이너 내부로 진입
```

- `-it` : input + output = interactive

**컨테이너 부팅 설정**

```bash
$ docker container run -it --restart=always --name "centsh" centos /bin/bash
```

**우분투 컨테이너 실행**

```bash
$ docker container -itd --name ubsh ubuntu bash

$ cat /etc/issue # 컨테이너 내부에서 명령 실행: 버전 확인

# Ctrl+P, Ctrl+Q (+ Ctrl+C) : 컨테이너를 중단하지 않고 docker로 빠져나옴
# Ctrl + C 하는 이유: Oracle VirtualBox를 빠져나오지 못해서 빠져나오는 명령어
# exit 으로 나오면 컨테이너 중단
```

**컨테이너 중단**

```bash
$ docker stop ubuntush # container 생략 가능
```

**실행 중인 컨테이너에 들어가기**

- attach

```bash
$ docker container attach ubsh

# Ctrl+P, Ctrl+Q
```

## File Copy & Share

> 컨테이너와 클라이언트 사이에서 파일 이동
> 

**형식**

```bash
$ docker container cp <container-name>:<path> <client-path>
$ docker container cp <client-file> <container-name>:<path>
```

**예시**

```bash
$ docker container cp nginxserver:/etc/nginx/nginx.conf .
$ docker container cp ~/.profile ubsh:/home/jade/
```

**실습**

```bash
$ docker ps # 떠 있는 컨테이너 조회
$ docker start cosh # centos 기반의 컨테이너 실행
$ docker attach cosh # 실행한 컨테이너로 진입
```

```bash
$ cat /etc/issue # ubuntu 라는 언급이 없음 = centos
```

**# Share Directory**

> C 드라이브의 파일 하나를 container에 공유할 수 있다.
> 

```bash
$ docker run -v <localpath>:<container-path>
```

### 리눅스 명령어 사용

```bash
$ for i in `docker ps -q`; do echo $i; done
# shell 의 반복문을 이용한 docker 명령어 활용
```
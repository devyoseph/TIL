# docker-compose

### Vue 커스텀

```yaml
# 프로젝트 Root 폴더
# 프로젝트Root/docker-compose.yml
version: '3.7'

services: 
  frontend:
    image: frontend-vue
    build:
      context: frontend/
      dockerfile: Dockerfile
    ports:
      - "80:80"
      - "443:443" 
    # [인증서 파일 저장 경로]:/var/www/html
    volumes:
      - /home/ubuntu/docker-volume/ssl:/var/www/html
    container_name: "frontend"
  
  backend:
    image: backend-spring
    build:
      context: backend/
      dockerfile: Dockerfile
    ports:
      - "8443:8443"  
		# [인증서 파일 저장 경로]:/root 
    volumes:
      - /home/ubuntu/docker-volume/ssl:/root
    container_name: "backend"
```

### React 커스텀

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
      - /home/ubuntu/docker-volume/ssl:/var/www/html
    container_name: "frontend"
  
  backend:
    image: backend-spring
    build:
      context: backend/
      dockerfile: Dockerfile
    ports:
      - "8443:8443"  
		# [인증서 파일 저장 경로]:/root 
    volumes:
      - /home/ubuntu/docker-volume/ssl:/root
    container_name: "backend"
```

### REACT 최종 적용 파일

![Untitled](docker-compose%20fb8069e914534cacb19ae68b73baddb1/Untitled.png)

```docker
# 내가 실제 적용한 파일은 ssl이 디렉토리가 아니라서 pem 디렉토리를 만들어서 내부에 집어넣음
# 프로젝트 Root/docker-compose.yml
version: '3.7'

services:

  frontend:
    image: frontend-react
    build:
		# 폴더 경로가 바로 frontend가 아닌 내부 프로젝트 이름으로된 폴더
      context: frontend/imaginary-playground
      dockerfile: Dockerfile
		# 리액트로 컨테이너를 만들면 자동으로 80포트로 띄워준다. 서로 연결한다.
    ports:
      - "80:80"
      - "443:443" 
    # [인증서 파일 저장 경로]:/var/www/html
		# 권한 설정 문제 아래 참고
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
```

에러1

```docker
+ docker-compose down
yaml.scanner.ScannerError: while scanning for the next token
found character '\t' that cannot start any token
  in "./docker-compose.yml", line 13, column 1
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
ERROR: script returned exit code 1
Finished: FAILURE
```

```docker
docker-compose.yml 파일 내부 띄어쓰기나 주석 제거하기!
```

에러2

```docker
Step 1/3 : FROM openjdk:11
 ---> 47a932d998b7
Step 2/3 : COPY build/libs/backend-0.0.1-SNAPSHOT.jar app.jar
 ---> Using cache
 ---> 620a9a265231
Step 3/3 : ENTRYPOINT ["java","-jar","app.jar","--spring.config.name=application-prod"]
 ---> Using cache
 ---> f9f33d9aaef7
Successfully built f9f33d9aaef7
Successfully tagged backend-spring:latest
Creating backend ... 
Creating backend ... done
[Pipeline] sh
+ docker images -f dangling=true -q
+ docker rmi
"docker rmi" requires at least 1 argument.
See 'docker rmi --help'.

Usage:  docker rmi [OPTIONS] IMAGE [IMAGE...]
```

```docker
파이프라인의 다음 명령어 삭제
sh 'docker rmi $(docker images -f "dangling=true" -q)'
```

에러3

컨테이너에 port가 뜨지 않고 바로죽는다면 포트를 바꿔본다.

```docker
8080 -> 8443
```

에러4

- 권한 설정 문제
- 페이지 접속시 Forbidden이 뜨는 경우 docker-compose 단계에서 volume에 설정한 디렉토리/파일에 접근하지 못해서 생기는 문제이다. (2가지 해결법)
    - `ls -al`을 이용해 나오는 접근 유저:그룹을 확인하고 현재 띄우려는 컨테이너에 root 권한 등 부여
        
        ```docker
        user: root;
        ```
        
    - ubuntu 내에서 폴더 자체에 대한 권한 변경
        
        ```docker
        $ chmod 755 /home/ubuntu/ # 좀 더 상세히 해도 가능하다.
        ```
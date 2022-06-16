# Docker / Jenkins

​           

### 1. 다운로드

* 설치 경로

  ```
  https://docs.docker.com/get-docker/
  ```

* 버전 확인(콘솔창)

  ```bash
  $ docker --version
  ```

* Jenkins 설치(일반)

  ```
  $ docker pull jenkins/jenkins:lts-jdk11
  ```

  ![image-20220616132546343](/Users/yang-yoseb/workplace/TIL/Docker/docker_basic.assets/image-20220616132546343.png)

* Jenkins 설치(M1)

  ```bash
  $ docker pull jenkins4eval/jenkins
  ```

* Jenkins 이미지 확인

  ```bash
  $ docker images | grep jenkins
  ```

* 실행(windows): mac M1의 경우 추가 세팅을 진행한다.

  ```bash
  $ docker run -d -p 9090:8080 -p 50000:50000 -v
  ```

  ​                                

### 2. Jenkins 컨테이너 실행

> 컨테이너 생성시 jenkins 내부에서 docker 명령어를 사용할 수 있도록 연결한다.

* Jenkins용 도커 볼륨과 네트워크 생성시 관리가 수월해지지만 스킵한다

  ```bash
  # ARM CPU
  $ docker run -d -it \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --name jenkins -p 9090:8080 -p 50000:50000 jenkins4eval/jenkins
  ```

  ```bash
  $ docker ps -a | grep jenkins
  ```

* 접속(windows):

  * http://localhost:9090/

    <img src="/Users/yang-yoseb/workplace/TIL/Docker/docker_basic.assets/image-20220616134926416.png" alt="image-20220616134926416" style="zoom:25%;" />

  * Jenkins 설치시 발급한 비밀번호 입력, 잊었다면

    ```bash
    $ docker logs jenkins
    ```

* 플러그인 설치: Install suggested plugins 클릭

  <img src="/Users/yang-yoseb/workplace/TIL/Docker/docker_basic.assets/image-20220616135245853.png" alt="image-20220616135245853" style="zoom:25%;" />

* 설치완료

  <img src="/Users/yang-yoseb/workplace/TIL/Docker/docker_basic.assets/image-20220616135924951.png" alt="image-20220616135924951" style="zoom: 25%;" />

​           

#### - 플러그인 설치: Gitlab

* 다음 주소에서 `gitlab` 검색

```
http://localhost:9090/pluginManager/
```

* 설치 목록

  <img src="/Users/yang-yoseb/workplace/TIL/Docker/docker_basic.assets/image-20220616140212085.png" alt="image-20220616140212085" style="zoom: 25%;" />

  ​                  

#### - 플러그인 설치: docker

* `docker` 검색

* 설치 목록

  <img src="/Users/yang-yoseb/workplace/TIL/Docker/docker_basic.assets/image-20220616140442276.png" alt="image-20220616140442276" style="zoom:25%;" />

​             

### 3. Jenkins 컨테이너 안 도커 설치

* root로 들어가 `apt-get` 등 설치

  ```bash
  $ docker exec -it -u root jenkins bash
  ```

* docker-ce가 설치 안될 때 

  >E: Unable to locate package docker-ce

  ```bash
  $ curl https://get.docker.com/ | bash -
  ```

* docker 관련 설치

```bash
$ apt-get update && \
apt-get -y install apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common && \
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable" && \
apt-get update && \
apt-get -y install docker-ce
```

* 권한부여

```bash
$ groupadd -f docker

$ usermod -aG docker jenkins

$ chown root:docker /var/run/docker.sock
```

​             

### 4. 도커라이징 및 배포

* Index.html

  ```html
  <!DOCTYPE html>
  <html lang="en">
  <head>
      <meta charset="UTF-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>배포!</title>
  </head>
  <body>
      <h2>배포!!</h2>
  </body>
  </html>
  ```

* docker file

  ```dockerfile
  FROM nginx:stable-alpine as production-stage
  COPY ./ /usr/share/nginx/html
  EXPOSE 80
  CMD ["nginx", "-g", "daemon off;"]
  ```

​              

#### - Gitlab 저장소에 위 파일을 업로드

![image-20220616161759746](/Users/yang-yoseb/workplace/TIL/Docker/docker_basic.assets/image-20220616161759746.png)
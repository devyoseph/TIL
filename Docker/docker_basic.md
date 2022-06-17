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

    <img src="docker_basic.assets/image-20220616162355780.png" alt="image-20220616162355780" style="zoom: 25%;" />

  * Jenkins 설치시 발급한 비밀번호 입력, 잊었다면

    ```bash
    $ docker logs jenkins
    ```

* 플러그인 설치: Install suggested plugins 클릭

  <img src="docker_basic.assets/image-20220616162415427.png" alt="image-20220616162415427" style="zoom:25%;" />

* 설치완료

  <img src="docker_basic.assets/image-20220616162425605.png" alt="image-20220616162425605" style="zoom:25%;" />

​           

#### - 플러그인 설치: Gitlab

* 다음 주소에서 `gitlab` 검색

```
http://localhost:9090/pluginManager/
```

* 설치 목록

  <img src="docker_basic.assets/image-20220616162437005.png" alt="image-20220616162437005" style="zoom:25%;" />

  ​                  

#### - 플러그인 설치: docker(mac M1은 필수 아님)

* `docker` 검색

* 설치 목록

  <img src="docker_basic.assets/image-20220616162449707.png" alt="image-20220616162449707" style="zoom:25%;" />

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

#### - SSH 키 등록

```bash
$ docker exec -it -u jenkins jenkins bash
```

```bash
$ ssh-keygen # 이후 전부다 엔터 누르고 Key 값을 저장
```

```bash
$ cat ~/.ssh/id_rsa.pub # 생성된 public key 출력
```

​             

* GitLab에 Jenkins 계정으로 로그인 및 SSH Key 입력

  <img src="docker_basic.assets/image-20220616171800849.png" alt="image-20220616171800849" style="zoom:33%;" />

* SSH 항목으로 가서 추가

  <img src="docker_basic.assets/image-20220616171952924.png" alt="image-20220616171952924" style="zoom: 25%;" />

* 

### 4. 도커라이징

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

#### 1) Gitlab 저장소에 위 파일을 업로드

<img src="docker_basic.assets/image-20220616162459065.png" alt="image-20220616162459065" style="zoom:50%;" />

​             

#### 2) Jenkins에 웹브라우저로 진입

* 새로운 Item 클릭

<img src="docker_basic.assets/image-20220616162723834.png" alt="image-20220616162723834" style="zoom:25%;" />

* 적당한 이름으로 프로젝트 생성

<img src="docker_basic.assets/image-20220616162840009.png" alt="image-20220616162840009" style="zoom:25%;" />

* 중간 쯤에 있는 **Git** 체크 후, 레파지토리 URL을 적어주고 인증을 위해 아래 Add 클릭

  * 여기서 2개의 깃 주소 중 **SSH 주소**를 입력한다

  <img src="docker_basic.assets/image-20220616163429728.png" alt="image-20220616163429728" style="zoom: 25%;" />

  * Add를 누르고 SSH private Key 입력

    <img src="docker_basic.assets/image-20220616172303011.png" alt="image-20220616172303011" style="zoom:25%;" />

  * jenkins에서 다시 명령어 입력

    ```bash
    $ cat ~/.ssh/id_rsa
    ```

    <img src="docker_basic.assets/image-20220616172506898.png" alt="image-20220616172506898" style="zoom:25%;" />

    * 주의: `---`부분부터 포함해서 긁어온다.

      ```
      -----BEGIN OPENSSH PRIVATE KEY-----
      생략
      -----END OPENSSH PRIVATE KEY-----
      ```

  * 입력 모습

    <img src="docker_basic.assets/image-20220616172641515.png" alt="image-20220616172641515" style="zoom:25%;" />

* git push 될 때마다 빌드 해주는 옵션

  <img src="docker_basic.assets/image-20220616163727518.png" alt="image-20220616163727518" style="zoom:25%;" />

* Build 에서 Execute Shell을 사용

  <img src="docker_basic.assets/image-20220616163857231.png" alt="image-20220616163857231" style="zoom:25%;" />

* 아래 명령어 입력

  ```bash
  docker build -t hello:latest .
  docker run -d -p 80:80 hello
  ```

  <img src="docker_basic.assets/image-20220616164046704.png" alt="image-20220616164046704" style="zoom: 50%;" />

* Save 버튼 클릭

​             

### 5. 배포

* Build Now 클릭

  <img src="docker_basic.assets/image-20220616164159340.png" alt="image-20220616164159340" style="zoom:25%;" />

* 만약 다음 오류 발생 시 root에서 다음 명령 수행

  ```
  Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Post
  ```

  ```bash
  $ sudo chmod 666 /var/run/docker.sock
  ```

* fetch 오류 발생시 root에서 다음 실행

  ```bash
  $ rm -rf /var/jenkins_home/workspace
  ```

  ​         

### 6. 이외의 시도

```bash
$ $ sudo apt-get install -y curl
```

```bash
$ sudo apt install nodejs
```


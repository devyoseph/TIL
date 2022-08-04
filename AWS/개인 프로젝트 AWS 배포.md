# 개인 프로젝트 AWS 배포

​                

#### <레퍼런스>

```
https://dev2som.tistory.com/141
https://crispyblog.kr/development/common/10
AWS 인바운드: https://dbjh.tistory.com/65
```

​  

### 4. 인스턴스 SSH 연결

* 인스턴스 연결 버튼 클릭

* Git Bash 환경에서 SSH 접속
  
  ```bash
  $ cd {pem키가 있는 곳으로 들어가기}
  $ chmod 400 {내가정한이름}
  $ ssh -i "내가정한이.pem" ubuntu@{AWS에서 알려준 주소}
  ```
  
  ![](assets/2022-08-04-12-58-06-image.png)

    

* SSH 클라이언트에 들어가기

![](assets/2022-08-04-13-10-44-image.png)

<br>

* 접속 완료
  
  ![](assets/2022-08-04-13-18-24-image.png)

<br>

### 5. 초기세팅

```bash
$ sudo apt-get update # apt-get 업데이트
```

```bash
$ sudo apt-get install docker.io # 도커 설치
$ sudo ln -sf /usr/bin/docker.io /usr/local/bin/docker # 링크 생성
$ docker -v # 버전확인
$ sudo chmod 666 /var/run/docker.sock # docker sock 접근 해제, 안되면 직접 찾아가
```

```url
https://hub.docker.com/r/jenkins/jenkins
```

* 위 경로에서 lts버전을 확인할 수 있다.
  * lts와 lts-jdk11 의 차이점은 일반 lts은 jdk8로 실행. 이후 오라클 라이센스문제로 한동안 도커로 안나왔지만 11부터 다시 도커로 나온다.

![](assets/2022-08-04-14-32-44-image.png)

* 만약 root user 권한이 아닌 현재 유저의 권한으로 docker 명령어를 사용하려면, 해당 user가 docker를 이용할 수 있도록 설정하도록하자. root가 아닌 user로 docker 명령어를 실행하게 될 경우 에러문구가 나올것이다.
  
  ```bash
  $ echo $USER
  $ sudo usermod -aG docker $USER # 현재 유저 docker 권한 추가
  $ docker restart # 도커재시작
  ```
  
  ```bash
  $ docker images # 
  ```

* 도커에 젠킨스 설치
  
  ```bash
  $ docker pull jenkins/jenkins:lts-jdk11
  
  $ docker run -d --name jenkins -p 9090:8080 -v /jenkins:/var/jenkins_home -v /usr/bin/docker:/usr/bin/docker -v /var/run/docker.sock:/var/run/docker.sock -u root jenkins/jenkins:lts
  
  $ sudo docker image ls   
  
  # docker container rm jenkins : 잘못 생성했을 때 사용
  # docker rm -f jenkins : ㅅ
  ```

* **-v /jenkins:/var/jenkins_home**
  
  * 젠킨스 컨테이너의 설정을 호스트 서버와 공유, 서버가 삭제되는 경우에도 설정을 유지

* **-v /usr/bin/docker:/usr/bin/docker -v /var/run/docker.sock:/var/run/docker.sock**
  
  * 젠킨스 컨테이너 내부에서도 호스트 서버의 도커를 사용할 수 있도록 함
  
  * **DooD(Docker out of Docker)** 방식이라고 한다.

* -p 8080:8080
  
  * 젠킨스 9090을 호스트의 8080과 연결

<br>

### 6. 포트 포워딩

* 위의 경우, **로컬의 9090포트로** 들어오는 요청을 **도커엔진** 위에 떠있는 jenkins 컨테이너(8080을 일반적으로 사용함)로 포트포워딩 하는데, 9090 포트로 들어오는 요청이 정상적으로 들어올 수 있게 인바운드 허용을 해줘야한다.

* AWS 관리페이지에서 [네트워크 및 보안] - [보안 그룹]
  
  ![](assets/2022-08-04-17-28-49-image.png)

* 둘 중 보안 그룹 이름이 더 긴 것을 선택해 체크
  
  * 보안 그룹 ID(파란색)을 클릭하면 인바운드 규칙 설정을 할 수 있다.

* 인바운드 규칙 허용에서 `9090`포트의 접근을 허용해준다.
  
  ![](assets/2022-08-04-17-33-44-image.png)

* IP접근: AWS에서 발급하는 `[IP주소]:9090` 으로 접속한다.
  
  ![](assets/2022-08-04-17-47-14-image.png)

 <br>

### 7.  Jenkins

* jenkins 접속화면
  
  ![](assets/2022-08-04-20-59-33-image.png)

* docker에서 jenkins 내부 컨테이너의 비밀번호 파일 값 읽기
  
  ```bash
  $ docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
  ```

* 만약 직접 jenkins 접속하고 싶다면 다음 명령어 사용
  
  ```bash
  # 도커 컨테이너 내부로 접속
  $ docker exec -it  도커컨테이너ID /bin/bash
  
  # example
  $ docker exec -it  6832359260fd /bin/bash
  ```

<br>

* 설치: install suggested plugins
  
  ![](assets/2022-08-04-21-05-00-image.png)

* 설치 진행
  
  ![](assets/2022-08-04-21-06-11-image.png)

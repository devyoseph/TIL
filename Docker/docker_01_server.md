# 01 서버를 관리한다는 것

> **서버의 상태를 관리하기 위한 발전**
> 자체 서버 운영 → 설정 관리 도구 등장 → 가상머신 등장 → 클라우드 등장 → PaaS 등장 → 도커 등장 → 쿠버네티스 등장 → 서비스메시 등장

​                    

## 자체서버

* Node.js

  <img src="docker_01_server.assets/image-20220708132255627.png" alt="image-20220708132255627" style="zoom:80%;" />

  * 만약 Node 버전을 바꾼다면 위 포인트 이후 모두를 신경써주어야 한다.

​                  

## 시도

> 1. PPT등으로 공유 업데이트한 경우 공유가 안되고 신뢰성이 떨어짐
> 2. 상태관리툴을 사용: CHEF, puppet, ANSIBLE → 코드로 서로 공유, 하지만 어려움
> 3. Jenkins, Wordpress, Chat 등 가상머신 사용 → 느리다, 설정 변경이 어렵다
> 4. 클라우드: AWS, Google Cloud, Azure
> 5. PaaS: Heroku, Netlify, AWS Elastic Beanstalk 등

#### - PaaS

<img src="docker_01_server.assets/image-20220708133120542.png" alt="image-20220708133120542" style="zoom:80%;" />

<img src="docker_01_server.assets/image-20220708133131885.png" alt="image-20220708133131885" style="zoom: 67%;" />

​                       

## 도커의 등장

<img src="docker_01_server.assets/image-20220708134409401.png" alt="image-20220708134409401" style="zoom:80%;" />

* 가상머신 같은 것인가? = 반은 맞고 반은 틀리다
  * 가상머신처럼 독립적으로 실행되지만
  * 가상머신보다 빠르고
  * 가상머신보다 쉽고
  * 가상머신보다 효율적

​                

### - 자원격리

> 리눅스 기능을 이용한 빠르고 효율적인 서버 관리

* 프로세스를 가상으로 분리
* 파일, 디렉토리를 가상으로 분리
* CPU, Memory, I/O 그룹별로 제한

​              

## VM vs Docker

![image-20220708134453901](docker_01_server.assets/image-20220708134453901.png)

​                     

## 도커가 가져온 변화

<img src="docker_01_server.assets/image-20220708134539793.png" alt="image-20220708134539793" style="zoom:80%;" />

​                   

## 도커의 사용

* 한 두개의 컨테이너를 관리하는 것 쉽지만 컨테이너가 많아지면 얘기가 다르다.

  <img src="docker_01_server.assets/image-20220708134800542.png" alt="image-20220708134800542" style="zoom:67%;" />

​                    

### - 쿠버네티스의 등장

![image-20220708134850797](docker_01_server.assets/image-20220708134850797.png)
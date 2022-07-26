# AWS pem KEY로 접근하기

​                 



## 배포 흐름

* EC2 접속
* EC2 기본 설치
* MySQL 세팅
  * root 비밀번호 바꾸기
* Nginx 세팅
* https 세팅
  * 이젠 기본!
  * 특히 웹기술 팀은 꼭 먼저 하기!
  * 도메인 개당 발급 횟수 제한 있음
* 배포

​              

### 1) EC2 접속하기

```bash
$ ssh -i <pem키> ubuntu@<public ip>
```


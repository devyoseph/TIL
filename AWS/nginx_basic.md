### 8. Nginx

* 설치

  ```bash
  $ docker pull nginx # 설치
  $ docker images # 확인
  ```

  ![image-20220805225401544](개인 프로젝트 AWS 배포.assets/image-20220805225401544.png)

* 작동

  ```bash
  $ mkdir site-content # nginx 마운트 폴더
  ```

  ```bash
  docker run --name webserver 
  -d 
  --restart always 
  -p 80:80
  -v ~/site-content:/usr/share/nginx/html nginx
  ```

  ```bash
  $ docker run --name webserver -d --restart always -p 80:80 -v ~/site-content:/usr/share/nginx/html nginx
  ```

  * `-d`: detach - 백그라운드로 실행
  * `-p`: HTTP 80번포트에 대한 엑세스 허가

​              

### 9. Nginx 세팅

```
https://bitgadak.tistory.com/7
```

* 1.20.2 기준 Docker run을 통해 컨테이너를 시작하면 nginx가 시작하면서 내부 설정파일을 불러온다.
  * `/etc/nginx/nginx.conf`
  * 이 설정 파일을 직접 수정해서 nginx 세팅을 바꿀 수도 있다.
* 하지만 위 세팅 파일 옵션 중 하나가 다음과 같은 세팅 파일을 자동으로 추가해준다.
  * `/etc/nginx/conf.d` 디렉토리에 존재하는 `*.conf`의 설정 파일들

​             

#### - Dockerfile을 이용해 설정파일(.conf) 만들기

> 위와 같은 성질을 이용하여 Dockerfile을 이용해 필요한 파일이 들어간 새로운 이미지를 만든다.

* `jenkins.conf`
  * 컨테이너 실행시 `/etc/nginx/conf.d/` 디렉토리 내부에 들어갈 젠킨스를 위한 설정파일이다.

​            

```dockerfile
upstream jenkins {
    server jenkins; # docker 로 띄운 jenkins 컨테이너의 이름
    keepalive 32;
}

# websocket 을 위한 설정
map $http_upgrade $connection_upgrade {
  default upgrade;
  '' close;
}

server {
    listen       80;
    listen       443 ssl;
    server_name  http://ec2-52-78-199-17.ap-northeast-2.compute.amazonaws.com/; # 요청이 이 도메인으로 온다면 처리

    # 인증서를 집어넣는 위치
    ssl_certificate     /etc/nginx/jenkins-chained.crt;
    ssl_certificate_key /etc/nginx/jenkins.key;

    # Jenkins 가 추가로 필요한 header 가 있다면 허용
    ignore_invalid_headers off;

    location / {
        proxy_pass         http://jenkins;
        proxy_redirect     default;
        proxy_http_version 1.1;

        # websocket 을 위한 설정
        # Connection 헤더와 Upgrade 헤더가 젠킨스까지 잘 타고 가야한다
        proxy_set_header   Connection        $connection_upgrade;
        proxy_set_header   Upgrade           $http_upgrade;

        proxy_set_header   Host              $host;
        proxy_set_header   X-Real-IP         $remote_addr; # 클라이언트 주소 전달
        proxy_set_header   X-Forwarded-For   $proxy_add_x_forwarded_for # 들어오는 X-Forwarded-For 헤더에 $remote_addr 이 콤마로 추가
        proxy_set_header   X-Forwarded-Proto $scheme;
        proxy_max_temp_file_size 0; # 파일 다운로드 제한 해제 (세팅 안하면 1024MB 이상 파일 다운X)

        #this is the maximum upload size
        client_max_body_size       10m;
        client_body_buffer_size    128k;

        proxy_connect_timeout      90;
        proxy_send_timeout         90;
        proxy_read_timeout         90;
        proxy_buffering            off;
        proxy_request_buffering    off; # HTTP CLI commands
    }
}
```



​                     


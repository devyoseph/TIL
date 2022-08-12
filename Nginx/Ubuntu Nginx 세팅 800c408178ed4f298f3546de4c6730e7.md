# Ubuntu Nginx 세팅

> 우분투 80포트에서 잡아주는 Nginx를 세팅한다.
`sudo vim` 을 적절히 활용한다.(권한 때문에 내부에서 수정하고 저장하는게 편리)
> 

### 1. 설정파일

- 메인 설정파일의 위치는 `/etc/nginx/nginx.conf` 이다.
    - 내부 설정을 보면 다음과 같다.
        
        ```bash
        include /etc/nginx/conf.d/*.conf;
        include /etc/nginx/sites-enabled/*;
        ```
        
        - 다른 위치의 설정 파일을 끌어오는 것을 알 수 있다.
- 끌어오는데 특이한 점이 그 설정 파일들이 **필수**라는 것
    - 두 개의 위치가 있다. 그 내부 default 파일이 각각 있는데 지우면 오류가 뜬다.
    - 되도록 enabled 내부 default를 사용해 설정을 한다.
        
        ```bash
        /etc/nginx/sites-enabled/default
        /etc/nginx/sites-available/default
        ```
        

### - 왜 설정파일이 필수인가?

- 메인 설정파일 `nginx.conf` 내부에 우리가 원하는 ‘80포트의 설정이 존재하지 않는다’
    - 즉 커스텀해야한다.
- 이번 프로젝트에서는 `sites-enabled/default` 내부에 설정값을 올렸다.

### 설정 파일

> 간단해보이지만 `/` 나 `-s` 표기 방식의 차이 하나로 오류가 발생한다.
내부 정보들을 잘 이해하고 있어야 디버깅 시간이 줄어든다.
> 

```bash
server {
		# 80 포트를 열어주는 설정, 만약 이 설정을 처음 넣었다면?
		# systemctl restart nginx 로 서버를 다시 띄워주어야 포트로 오는 신호를 인식한다.
    listen 80;
    #listen [::]:80; # 오류가 발생할 때가 있어서 주석처리 [1]

    # server_name 도메인;
    server_name i7d204.p.ssafy.io;
		
		# 중간에 디버깅할 수 있는 곳이 이곳이므로 메모장에 경로 붙여놓고 지속적으로 사용한다.
    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log;
}

server {
				# location 규칙에 따라서 아래 uri랑 매칭안된 uri에 한해서 3000으로 보내준다.
        location / {
                proxy_pass http://localhost:3000;
        }
				
				# api로 시작하는 요청은 8443포트로 보내준다
        location /api {
                proxy_pass https://localhost:8443;
        }
				
        location /jenkins {
                rewrite ^ http://i7d204.p.ssafy.io:9090;
        }
				
				# 443으로 오는 포트 받으면 인증서 발급
        listen [::]:443 ssl ipv6only=on;
        listen 443 ssl;
        ssl_certificate /etc/letsencrypt/live/i7d204.p.ssafy.io/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/i7d204.p.ssafy.io/privkey.pem;
        include /etc/letsencrypt/options-ssl-nginx.conf;
        ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;
}

server {
				# HTTP로 오면 HTTPS로 바꾸기 위해 REDIRECT
        if ($host = i7d204.p.ssafy.io) {
                return 301 https://$host$request_uri;
        } # managed by Certbot

        listen 80;
        listen [::]:80;

        server_name i7d204.p.ssafy.io;
        return 404; # managed by Certbot
}
```

### 2. nginx 디버깅

`/var/log/nginx` : 여기서 access 내역과 error 내역을 확인할 수 있다.

### 오류

1.  `listen [::]:80;` 주석처리

```bash
2022/08/12 11:15:10 [warn] 504489#504489: conflicting server name "i7d204.p.ssafy.io" on 0.0.0.0:80, ignored
2022/08/12 11:15:10 [warn] 504489#504489: conflicting server name "i7d204.p.ssafy.io" on [::]:80, ignored
2022/08/12 11:15:11 [warn] 504501#504501: conflicting server name "i7d204.p.ssafy.io" on 0.0.0.0:80, ignored
2022/08/12 11:15:11 [warn] 504501#504501: conflicting server name "i7d204.p.ssafy.io" on [::]:80, ignored
```

1. 프론트에서 백엔드 통신이 안되는 경우

```bash
10:20:50 [crit] 500166#500166: *104 SSL_do_handshake() failed (SSL: error:14201044:SSL routines:tls_choose_sigalg:internal error) while SSL handshaking, client: 45.79.158.244, server: 0.0.0.0:443
```

- 해결
    - 코드를 자세히보면 url 세팅이 다름을 알 수 있다.
        - 프론트: http 사용,  https를 보내면 오류가 발생한다
        - 백엔드: https 사용, http를 보내면 오류가 발생한다(톰캣 내부에서 ssl 처리해줌).
        
        ```bash
         location / {
                        proxy_pass http://localhost:3000;
                }
        				
        				# api로 시작하는 요청은 8443포트로 보내준다
                location /api {
                        proxy_pass https://localhost:8443;
                }
        ```
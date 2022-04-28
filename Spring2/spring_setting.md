**Spring Framework**

- JAVA
- root-context.xml
- server-context.xml
- was(tomcat)
- web.xml

**스프링 프로젝트를 실행하면**

1. WAS(톰캣)을 실행시키면  설정파일을 읽어온다. (server.xml)
2. meta-inf에 있는 context.xml을 읽는다.
3. 프로젝트의 web.xml 을 읽는다.
   1. 비 웹 → root-context.xml 에서 모델 관련 설정 읽는다.
      - dataSource
      - MyBatis
      - Transaction
      - AOP, Auto Proxy
      - 컴포넌트 스캔 (컨트롤러 제외)
   2. 웹
      1. filter, filter-mapping
      2. servlet, servlet-mapping
      3. DispatcherServlet → servlet-context.xml 에서 웹 관련 읽어온다.
         - component scan (컨트롤러)
         - resources, 리소스 매핑 
         - 뷰 리졸버, prefix, suffix
         - 인터셉터, preHandle, postHandle
         - 파일 업로드, 다운로드

**Spring Boot**

- JAVA
- ~~root-context.xml~~
- ~~server-context.xml~~
- ~~was(tomcat)~~
- ~~web.xml~~
- application.properties
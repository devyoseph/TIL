## Spring 실행순서

​             

1. Tomcat 이 실행되며 설정 파일들이 실행
2. Tomcat 내부 server.xml 내부에 실행해야할 프로젝트들이 써져있다.
3. META-INF(src-main) 내부 content.xml 파일을 열어 내용을 확인
4. 프로젝트 내부 web.xml 실행
5. web.xml 내부 ContextLoaderListener 실행
6. root-context xml (non- web)에 의해 SERVICE, DAO, VO
7. Client 요청에 의해 DispatcherServlet에 의해 servlet-context.xml 실행
   * Dispatcher의 작동방식: 프론트 컨트롤 방식
8. 로그인 등으로 url 정보가 Dispatcher로 이동
9. HandlerMapping에 url 전달해 해당하는 Controller 검색
10. 해당 Controller로 이동 후 Service - Dao - Model 과정을 거쳐 Model And View 값을 도출
11. Model값이 파라미터로 이동
12. ViewResolver를 통해 전체 주소를 생성하고 Dispatcher로 이동
13. Server가 client에게 이 주소로 forward 이동하도록 함
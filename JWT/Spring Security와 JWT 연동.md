# Spring Security와 JWT 연동

> SpringSecurity에서 제시해놓은 객체를 Override하는 경우가 많다.



### 1. DTO

* `User` 또는 `UserDto` 등의 DTO Class를 만들고 Spring Security에서 제공하는 `UserDetails`를 구현(`implements`)한다.
  
  ```java
  import org.springframework.security.core.userdetails.UserDetails;
  
  
  public class UserDto implements UserDetails {
      //Override 해야할 메서드가 존재한다.
      
      private List<String> roles = new ArrayList<>(); //권한들을 저장해 놓은 리스트
      // 유저에게는 여러 개의 권한을 부여해 그 권한에 따라 이동할 수 있는 사이트를 제한할 수 있다.
      
      @Override //원하는 권한을 부여해주는 메서드
      public Collection<? extends GrantedAuthority> getAuthorities() {
          return this.roles.stream().map( SimpleGrantedAuthority :: new ).collect( Collectors.toList() );
      }
  }
  ```



### 2. UserDetailService

* Spring Security에서 명시해놓은 Service를 구현(`implements`)해서 가져와야한다.
  
  ```java
  @RequiredArgsConstructor
  //@Service
  public class CustomUserDetailService implements UserDetailsService{
      
      private Logger logger = LoggerFactory.getLogger(CustomUserDetailService.class);
      
      //본인이 사용하는 User 관련 서비스를 연결한다.
      private final UserService userService;
      
      @Override
      public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {
  
          // 서비스 중 유저의 정보를 모두 가져오는 경우(Dto 사용)
          // 그 내부 Override해서 가져온 권한에 값들을 넣어준다.
          UserDto user = userService.detailUser(Integer.parseInt(userId));
          List<String> list = new ArrayList<>();
          list.add(user.getType());
  
          // UserDto 내부에 권한을 집어넣는다. 권한은 여러개 배분할 수 있지만 이번 프로젝트에서는 DB에 있는 한 권한만 추가한다.
          user.setRoles(list);
  
          return user;
      }
  }
  
  ```
  
  

### 3. JWT 객체 생성

* jwt 토큰을 생성(유효기간, id값 저장 등)/파싱/유효성검사 기능이 있는 객체를 생성한다.
  
  ```java
  import io.jsonwebtoken.*;
  import lombok.RequiredArgsConstructor;
  import org.slf4j.*;
  import org.springframework.beans.factory.annotation.Value;
  import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
  import org.springframework.security.core.Authentication;
  import org.springframework.security.core.userdetails.UserDetails;
  import org.springframework.security.core.userdetails.UserDetailsService;
  import org.springframework.stereotype.Component;
  
  import javax.annotation.PostConstruct;
  import javax.servlet.http.HttpServletRequest;
  import java.util.Base64;
  import java.util.Date;
  import java.util.List;
  
  @RequiredArgsConstructor
  @Component
  public class JwtTokenProvider { // JWT 토큰을 생성 및 검증 모듈
  
      private static Logger logger = LoggerFactory.getLogger(JwtTokenProvider.class);
  
      @Value("${spring.jwt.secret}")
      private String secretKey;
  
      private long tokenValidMilisecond = 1000L * 60 * 60; // 1시간만 토큰 유효
  
      private final UserDetailsService userDetailsService;
  
      @PostConstruct //암호키 생성
      protected void init() {
          secretKey = Base64.getEncoder().encodeToString(secretKey.getBytes());
      }
  
      // Jwt 토큰 생성
      public String createToken(String userId, List<String> roles) {
          Claims claims = Jwts.claims().setSubject(userId); // id 구분자 넣기
          claims.put("roles", roles); // 권한 넣기
          Date now = new Date();
          return Jwts.builder()
                  .setClaims(claims) // 데이터
                  .setIssuedAt(now) // 토큰 발행일자
                  .setExpiration(new Date(now.getTime() + tokenValidMilisecond)) // 유효시간 설정
                  .signWith(SignatureAlgorithm.HS256, secretKey) // 암호화 알고리즘, secret값 세팅
                  .compact();
      }
  
      // Jwt 토큰으로 인증 정보를 조회
      public Authentication getAuthentication(String token) {
          UserDetails userDetails = userDetailsService.loadUserByUsername(this.getUserPk(token));
          return new UsernamePasswordAuthenticationToken(userDetails, "", userDetails.getAuthorities());
      }
  
      // Jwt 토큰에서 회원 구별 정보 추출
      public String getUserPk(String token) {
          return Jwts.parser().setSigningKey(secretKey).parseClaimsJws(token).getBody().getSubject();
      }
  
      /**
       * <pre>
       * Request의 Header에서 token 파싱 : "X-AUTH-TOKEN: jwt토큰"
       * </pre>
       *
       * @param req
       * @return
       */
      public String resolveToken(HttpServletRequest req) {
          return req.getHeader("X-AUTH-TOKEN");
      }
  
      /**
       * <per>
       * Jwt 토큰의 유효성 + 만료일자 확인
       * </per>
       *
       * @param jwtToken
       * @return
       */
      public boolean validateToken(String jwtToken) {
          try {
  
              logger.debug( "[JwtTokenProvider >> validateToken]" );
  
              Jws<Claims> claims = Jwts.parser().setSigningKey(secretKey).parseClaimsJws(jwtToken);
              return !claims.getBody().getExpiration().before(new Date());
          } catch (SignatureException e) {
              logger.error("Invalid JWT signature", e);
              return false;
          } catch (MalformedJwtException e) {
              logger.error("Invalid JWT token", e);
              return false;
          } catch (ExpiredJwtException e) {
              logger.error("Expired JWT token", e);
              return false;
          } catch (UnsupportedJwtException e) {
              logger.error("Unsupported JWT token", e);
              return false;
          } catch (IllegalArgumentException e) {
              logger.error("JWT claims string is empty.", e);
              return false;
          }catch (Exception e) {
              return false;
          }
      }
  }
  
  
  ```



### 4.

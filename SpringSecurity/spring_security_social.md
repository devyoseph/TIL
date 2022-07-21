1. Spring Security

2. OAuth2 Client

   ```
   	implementation 'org.springframework.boot:spring-boot-starter-oauth2-client'
   	implementation 'org.springframework.boot:spring-boot-starter-oauth2-resource-server'
   ```

3. Json Web Token(JWT)

```java
import lombok.Data;

@Data
public class UserDto {

    private int id;
    private String email;
    private String username;
    private String joinDate;    // Date 였는지 타입 확인
    private String provider;
    private String providerId;
    private String profileUrl;
    private String gender;
    private String type;

}
```

4. 
## REST API 실전예제

* Controller

```java
package com.site.hw.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.site.hw.dto.User;
import com.site.hw.model.service.UserService;

// REST API 의 컨트롤러 설정
@RestController
// /userapi 로 들어오는 모든 요청
@RequestMapping("/userapi")
// 모든 경로, 모든 Method 타입에 대해 CORS 설정
@CrossOrigin(origins = "*", methods = {RequestMethod.GET , RequestMethod.POST, RequestMethod.DELETE, RequestMethod.PUT})
public class UserRestController {

	@Autowired
	UserService us;
	
	// 모든 사용자 리스트 조회
	@GetMapping("/user")
	public ResponseEntity<?> selectAll() {
		try {
			List<User> users = us.selectAll();
			if (users != null && users.size() > 0) {
				return new ResponseEntity<List<User>>(users, HttpStatus.OK);
			} else {
				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
			}
		} catch (Exception e) {
			return exceptionHandling(e);
		}
	}
	
	// 사용자 ID로 조회
	@GetMapping("/user/{id}")
	public ResponseEntity<?> select(@PathVariable String id) {
		try {
			User user = us.searchById(id);
			if (user != null) {
				return new ResponseEntity<User>(user, HttpStatus.OK);
			} else {
				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
			}
		} catch (Exception e) {
			return exceptionHandling(e);
		}
	}
	
	// 사용자 name으로 조회
	@GetMapping("/user/search")
	public ResponseEntity<?> search(@RequestParam String name) {
		try {
			List<User> users = us.searchByName(name);
			if (users != null && users.size() > 0) {
				return new ResponseEntity<List<User>>(users, HttpStatus.OK);
			} else {
				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
			}
		} catch (Exception e) {
			return exceptionHandling(e);
		}
	}
	
	// 사용자 등록
	@PostMapping("/user")
	public ResponseEntity<?> insert(User user) {
		try {
			int result = us.insert(user);
			return new ResponseEntity<List<User>>(us.selectAll(), HttpStatus.CREATED);

		} catch (Exception e) {
			return exceptionHandling(e);
		}
	}
	
	// 사용자 update
	@PutMapping("/user/{id}")
	public ResponseEntity<?> update(@PathVariable String id, @RequestBody User user) {
		try {
			int result = us.update(user);
			return new ResponseEntity<List<User>>(us.selectAll(), HttpStatus.OK);

		} catch (Exception e) {
			return exceptionHandling(e);
		}
	}
	
	// 사용자 삭제
	@DeleteMapping("/user/{id}")
	public ResponseEntity<?> delete(@PathVariable String id) {
		try {
			int result = us.delete(id);
			return new ResponseEntity<List<User>>(us.selectAll(), HttpStatus.OK);

		} catch (Exception e) {
			return exceptionHandling(e);
		}
	}
	
	private ResponseEntity<String> exceptionHandling(Exception e) {
		e.printStackTrace();
		return new ResponseEntity<String>("Sorry: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
	}

}

```


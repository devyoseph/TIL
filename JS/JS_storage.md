# Web Storage

```javascript
   if (confirm("투표 생성?")) {
      localStorage.setItem("question", question);
      localStorage.setItem("answers", JSON.stringify(answerArr)); //배열은 넣을 수 없고 문자열만 가능하다 = JSON 파일로 문자열 변환

      opener.location.reload();
      self.close();
    }
```

​        

## Web Storage - localStorage

* 데이터를 사용자 로컬에 보관하는 방식
* 저장 / 덮어쓰기 /삭제 등 조작 가능
* JS로만 조작
* 모바일에서도 사용 가능

### Cookie와 차이점

* 유효기간X, 영구적
* 5MB까지 사용 가능(쿠키는 4KB까지)
* 네트워크 요청 시 서버로 전송X
* 서버가 HTTP 헤더를 통해 스토리지 객체를 조작할 수 없음
* 웹스토리지는 origin(프로토콜, 도메인, 포트)가 다르면 접근 불가

​          

## LocalStorage, SessionStorage

* 키(key)와 값(value)을 하나의 세트로 저장
* 도메인과 브라우저별로 저장
* 값은 반드시 문자열로 저장됨

​      

* **공통 메소드와 프로퍼티**
  * setItem(key, value): key-value 쌍으로 저장
  * getItem(key): key에 해당하는 **value**를 리턴
  * removeItem(key): key에 해당하는 값 삭제
  * clear(): 모든 값 삭제
  * key(index): index에 해당하는 key
  * length: 저장된 항목의 개수

​          

### 데이터 추가/출력 방법

```javascript
<script>
	
  function init(){
		//localStorage data 추가방법 3가지  
  	localStorage.Test = "Sample";
  	localStorage["Test"] = "Sample";
  	localStorage.setItem("Test", "Sample");
	}
	
	//취득 data 출력
	document.querySelector("#result").innerHTML = val;

	//삭제
	localStorage.removeItem("Test");

	//전체 삭제
	localStorage.clear();

</script>
```

​           

### sessionStorage

* 현재 떠 있는 탭에서만 유지, 같은 페이지더라도 탭이 다르면 다른 곳에 저장
* **페이지 새로고침 시에는 유지**, 탭을 닫으면 제거

```javascript
//SessionStorage 사용법: localStorage -> sessionStorage 로 변환

sessionStorage.setItem("key", value);
sessionStorage.getItem("key");
sessionStorage.removeItem("key");
sessionStorage.clear();
```

​         

## 둘의 차이점

* SessionStorage과 차이점
  * localStorage: 세션이 끊겨도 사용 가능
  * sessionStorage: 같은 세션만 사용 가능
* localsession은 세션이 끊기거나 동일한 세션이 아니더라도 사용 가능하다.


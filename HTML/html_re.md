# HTML

* W3C(World Wide Web Consortium) : HTML5를 웹 표준으로 권고
* HTML 특징
  * 멀티미디어 요소 재생
    * 멀티미디어 재생을 외부 플러그인 없이도 사용할 수 있도록 함
  * 서버와 통신
    * 서버와 클라이언트 사이에 소켓 통신 가능
  * Semantic tag 추가
  * 웹 사이트 검색엔진이 좀 더 빠르게 검색할 수 있도록 특정 tag에 의미를 부여

​          

* 문서 구조

  ```html
  <!DOCTYPE html> <!--현재 문서가 HTML 문서임을 정의-->
  ```

  * 시작 tag와 종료 tag가 있고 <tag> 사이에 문서 내용을 정의
  * 각 <tag>는 고유의 의미를 가지고 있으며 Web Browser는 이 의미에 따라 문서를 화면에 표시



* 작동원리
  * 서버는 클라이언트 요청 내용을 분석해 결과값을 HTML로 전송
  * 서버는 결과값을 전송한 후 클라이언트와 연결 종료
  * 클라이언트는 서버로부터 전달받은 HTML을 Web Browser에 표시
  * 각 Web Browser는 브라우저 엔진이 내장되어 있고 이 엔진이 tag를 해석해 화면에 표현

​        

​        

## HTML 개요

* HTML은 마크업 언어를 웹 문서로 작성하여 tag를 사용해 문서의 구조 등을 기술하는 언어

* tag와 속성

  * HTML 문서는 <tag>로 만들어진다
  * 전체 구성: <html> <head> <body>
  * 각각의 tag는 속성과 속성의 값이 존재한다.

* 주석

  ```html
  <!-- 주석 -->
  ```

  * 단축키: `ctrl` + `/`

​         

### Global attribute(글로벌 속성)

> 어느 태그에나 넣어서 사용할 수 있는 속성

| 글로벌 속성 | 설명                                                         |
| ----------- | ------------------------------------------------------------ |
| class       | tag에 적용할 스타일 이름 지정                                |
| dir         | 내용의 텍스트 방향 지정                                      |
| id          | tag에 유일한 ID 지정                                         |
| style       | 인라인 스타일을 적용하기 위해 사용                           |
| title       | tag에 추가 정보를 지정. tag에 마우스 포인터를 위치시킬 경우 title의 값 표시 |

​                

​                        

## 요소(Element)

* Root 요소
* Head 요소

​        

### Root 요소

> <html> tag는 HTML 문서 전체를 정의
>
> <html>은 <head>와 <body>로 구성

​         

### Head 요소

> HTML의 머리 부분

* 구성: <title>, <meta>, <style>, <script>, <link>

* title : 문서의 제목을 의미, 브라우저 제목 표시줄에 tag 내용이 나타남

* meta : 문서의 작성자, 날짜, 키워드 등 브라우저의 본문에 나타나지 않는 일반 정보를 나타냄

  * 속성: name, content, http-equiv, charset

    ```html
    <meta name ="name" content="value">
    <!-- name 속성에는 description, keyword, author 등이 있다-->
    
    <meta http-equiv="refresh" content="30">
    ```

  ​               

    

### Body

* 보여질 내용을 작성

  * id 속성은 중복X, class는 중복O

* Heading: <h1>~<h6>

* 특수문자

  * `&nbsp;` : 공백
  * `&lt;` : less than(<)
  * `&gt;` : greater than(>)
  * `&amp;` : Ampersand(&)
  * `&quot;` : Quotation mark(")
  * `&copy` : Copyright (&copy;)
  * `&reg;` : registered trademark(&reg;)

* **포맷팅 요소**

  * 화면에는 동일하게 출력되지만 의미가 다르다

  | tag명          | 설명                                         |
  | -------------- | -------------------------------------------- |
  | <abbr>         | 생략된 약어 표시(Title 속성 함께 사용)       |
  | <address>      | 연락처 정보 표시                             |
  | <blockquote>   | **긴 인용문구, 좌우 들여쓰기**               |
  | <q>            | 짧은 인용문구, 좌우 따옴표 붙음              |
  | <cite>         | 웹 문서나 포스트에서 참고 내용 표시          |
  | <pre>          | **공백, 줄바꿈등 입력된 그대로 화면에 표시** |
  | <code>         | 컴퓨터 인식을 위한 소스 코드                 |
  | <mark>         | 특정 문자열 강조                             |
  | <hr>           | **구분선**                                   |
  | <b>, <strong>  | 굵은 글씨                                    |
  | <i>, <em>      | 이탤릭                                       |
  | <big>, <small> | 큰 글자, 작은 글자                           |
  | <sup>, <sub>   | **위 첨자, 아래 첨자**                       |
  | <s>, <u>       | **취소선, 밑줄(underline)**                  |

  ```html
  	<pre>
  		<code>
  			function test(){
  				alert("함수가 그대로 출력");
  			}
  		</code>
  	</pre>
  ```



* **목록형 요소** : 하나 이상의 하위 tag를 포함한다

  | tag명 | 설명                      | 속성     | 속성값 | 설명            |
  | ----- | ------------------------- | -------- | ------ | --------------- |
  | <ul>  | 번호 없는 목록            | type     | 1      | 숫자(기본값)    |
  | <ol>  | 번호 있는 목록            | type     | a      | 영문 소문자     |
  | <li>  | 목록 항목의 하위 태그     | type     | A      | 영문 대문자     |
  | <dl>  | 용어 정의와 설명을 목록화 | type     | i, l   | 로마숫자(소/대) |
  | <dt>  | 용어 목록의 정의 부분     | start    | 숫자   | 시작 번호       |
  | <dd>  | 용어 목록의 설명부분      | reversed |        | 역순 표시       |

  ```html
  <ol type="i" start="100">
    <li>사과 &amp; 귤</li>
    <li>감자</li>
  </ol>
  ```

  * 실습

    ```html
    	<big>html study</big>
    	<ul>
    		<li>index - 숫자</li>
    			<ol type="1">
    				<li>HTML5와 CSS3의 소개</li>
    				<li>HTML 기본</li>
    				<li>HTML 마크업 요소</li>
    				<li>CSS 기본</li>
    				<li>CSS 이해</li>
    			</ol>
    		<li>index - 알파벳</li>
    			<ol type="a">
    				<li>HTML5와 CSS3의 소개</li>
    				<li>HTML 기본</li>
    				<li>HTML 마크업 요소</li>
    				<li>CSS 기본</li>
    				<li>CSS 이해</li>
    			</ol>
    	</ul>
    ```



* **table**

  > HTML table 모델은 데이터를 행(row)과 열(column)의 셀(cell)에 표시

  ```html
  <caption>테이블</caption>
  <table>
    <colgroup>
      <col span="2" style="background-color: skyblue">
    </colgroup>
    <thead>
      <tr>
        <th>id</th>
        <th>name</th>
        <th>age</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>1</td>
        <td>홍길동</td>
        <td>19</td>
      </tr>
    </tbody>
    <tfoot>	</tfoot>
  </table>
  ```

  * 제목: <caption>
  * 행 그룹 요소: <thead>, <tbody>, <tfoot>
  * 열 그룹 요소: <colgroup>
  * 열 태그: <col> , span 타입 = 열 개수 지정 
  * 행 표시: <tr>
  * 강조 표시: <th>
  * 내용 표시: <td>
  * 그룹: <colgroup>, <rowspan>
  * 속성: HTML5부터는 지원X, CSS로 적용한다.
    * frame : 특정 선을 보여줄지 결정
    * rules : 셀과 셀 사이 줄을 보여줄지 결정
    * align : background, bgcolor, border 속성 등

​         

​          

### img

* src속성 : 이미지 경로 지정(상대 경로, 절대 경로)

* height / width : 이미지 사이즈 결정

* alt : 이미지가 없는 경우 대신 보여질 텍스트

* 이미지 관련 태그 <figure> :  설명 글을 붙여야 할 태그

  * <figcaption> : 설명 내용

  ```html
  <figure>
  	<img scr="경로" title="배경입니다">
  	<figcaption>배경이 좋네요<figcaption>
  </figure>
  ```

   

​        

### a 태그 (Anchor)

* href 속성을 사용해 이동할 문서의 URL이나 문서의 책갈피 지정

* target 속성 : 하이퍼링크를 클릭했을 때 현재 윈도우 또는 새로운 윈도우로 이동할지 지정

  | 속성 값 | 설명                                                         |
  | ------- | ------------------------------------------------------------ |
  | _blank  | 링크 내용이 새 창이나 새 탭에서 열린다                       |
  | _self   | 링크가 있는 화면에서 열린다                                  |
  | _parent | 프레임을 사용했을 때 링크 내용을 부모 프레임에 표시          |
  | _top    | 프레임을 사용했을 때 프레임에서 벗어나 링크 내용을 전체 화면으로 표시 |

* 같은 페이지 안에서 이동하는 법: 특정 id나 class의 이름을 적는다

  ```html
  <a href="#content">내용1</a>
  
  <p>
    매우 긴 내용
  </p>
  
  <p id="content">
    이동하고자 하는 내용
  </p>
  ```

* **<map>  :  하나의 이미지 안에 여러 개의 link**

  * <area> : <a> 태그 대신 사용, href, target, shape 속성

    * shape 속성의 값 = default, rect, circle, poly

    ```html
    <img src="../경로">
    
    <map name="Logo">
    	<area shape="rect" coords="5,5,185,80" href="http://www.naver.com" target="_blank">
    </map>
    ```

    

​         

### iframe 요소

> 화면의 일부분에 다른 문서를 포함

* src 속성을 통해 외부 문서의 경로 지정
* height, width 속성으로 사이즈 지정
* name으로 프레임 이름 지정

```html
<iframe src="java.html" name="javascript" width="500" height="300"></iframe>
```

​       

​         

### form control 요소

* 사용자로부터 데이터를 입력 받아 서버에서 처리하기 위한 용도로 사용(전송:submit)
*  <form> 태그 하위에 위치해야 서버로 전송

#### form 속성

| 속성          | 설명                                                         |
| ------------- | ------------------------------------------------------------ |
| method        | 사용자가 입력한 내용을 서버 쪽 프로그램으로 어떻게 넘겨줄지 지정 |
| method="get"  | 주소 표시줄에 사용자가 입력한 내용 표시. 256~2048bytes의 데이터만 전송 |
| method="post" | HTTP 메세지의 Body에 담아서 전송하기 때문에 전송 내용 길이 제한X<br />사용자가 입력한 내용이 표시X |
| name          | form의 이름 지정                                             |
| action        | <form> 태그 안 내용을 처리해줄 서버상 프로그램 지정(URL)     |
| target        | <action> 태그에서 지정한 스크립트 파일을 현재 창이 아닌 다른 위치에 열도록 지정 |
| autocomplete  | 자동완성 기능, 기본값 on                                     |

​        

* **form 컨트롤 요소**

| tag명                               | 설명                                                         |
| ----------------------------------- | ------------------------------------------------------------ |
| <form>                              | 사용자에게 입력 받을 항목 정의, 여러 개 control 요소 포함    |
| <input>                             | 텍스트 box, 체크 box, 라디오 버튼 등 사용자가 데이터를 입력할 수 있도록 함 |
| <textarea>                          | 여러 줄의 문자 입력, cols / rows 속성으로 박스 크기 조정, disabled 속성으로 수정불가 내용 표시 |
| <button>                            | 버튼을 표시                                                  |
| <select><br /><option value="내용"> | select 태그 : 셀렉트 박스, size(dropdown 항목 개수 지정) / multiple(ctrl 키를 누른 상태로 여러 항목 선택) <br />option 태그 : selected(화면에 표시될 때 기본으로 선택되어 있는 옵션), value(전송할 값)<br /><optgroup label="그룹명"> option을 그룹으로 보여주기 위한 태그 |
| <optgroup>                          | select box의 각 항목 그룹화                                  |
| <option>                            | select box의 각 항목 정의                                    |
| <label>                             | for 속성을 이용해 다른 control 요소와 텍스트 연결            |
| <fieldset>                          | 입력 항목들을 그룹화                                         |
| <legend>                            | <fieldset>의 제목 지정                                       |
| <progress><br /><meter>             | 작업의 진행 상태 표시, value, max<br />progress와 비슷, low / high / optimum : 낮은 높은 최적 값을 지정(그에 따라 색이 달라짐) |

```html
	<h2>form control - label</h2>
	<fieldset>
		<legend>필수 입력</legend>
	<form method="post" action="Login.jsp">
		<ul type="none">
			<li>
				<label for="userid">아이디 :</label>
				<input type="text" id="userid" name="userid">
			</li>
			<li>
				<label for="pass">비밀번호 :</label>
				<input type="password" id="pass" name="pass">
			</li>
			<li><input type="submit" value="로그인"><input type="reset"></li>
		</ul>
	</form>
	</fieldset>
```

*  input 태그 속성들

| type           | 설명                                                         |
| -------------- | ------------------------------------------------------------ |
| text           | 한 줄의 텍스트 입력, name/size/value/maxlength               |
| password       | 비밀번호, name/size/value/maxlength                          |
| search         | 검색 상자                                                    |
| tel            | 전화번호                                                     |
| url            | URL                                                          |
| email          | email                                                        |
| datetime       | 국제 표준시(UTC)                                             |
| datetime-local | 사용자 지역을 기준으로 날짜와 시간                           |
| date           | 사용자 지역을 기준으로 날짜(년/월/일), min/max/step/value(초기값) |
| month          | 사용자 지역을 기준으로 날짜(년/월)                           |
| week           | 사용자 지역을 기준으로 날짜(년/주)                           |
| time           | 사용자 지역을 기준으로 날짜(시,분,초,분할 초)                |
| number         | 숫자 조절표, min/max/step/value(초기값)                      |
| range          | 숫자 조절 막대, min/max/step/value(초기값)                   |
| color          | 색상 표                                                      |
| checkbox       | checkbox                                                     |
| radio          | radio box                                                    |
| file           | 파일 첨부 버튼                                               |
| submit         | 서버 전송 버튼                                               |
| image          | submit + image (submit인데 이미지로 그냥 대체할 수 있다고 생각) |
| reset          | 리셋 버튼                                                    |
| button         | 기능이 없는 버튼, value/onclick                              |
| hidden         | 사용자에게 보이지 않지만 서버로 넘겨지는 값                  |

```html
<input type="button" value="버튼" onclick="alert('일반 버튼입니다')">
```

​       

* 사용자 입력을 위한 input

| 속성                     | 설명                                                         |
| ------------------------ | ------------------------------------------------------------ |
| autofocus                | 페이지 로딩 후 마우스 커서 표시                              |
| placeholder              | 텍스트 입력시 적당한 힌트 표시                               |
| readonly                 | =true, 등으로 지정                                           |
| required                 | submit 하기 전에 필수적으로 입력해야 하는 부분 체크          |
| min,max,step             |                                                              |
| size,minlength,maxlength |                                                              |
| Height,width             |                                                              |
| list                     | <datalist> 에 미리 정의해 놓은 옵션 값을 <input> 안에 나열해 보여줌 |
| multiple                 | type이 `email`이나 `file` 등 두 개 이상일 때 두 개 이상 값을 입력 |

```html
<input type="text" list="datalist id"> <!--만들어 놓은 틀을 불러옴-->

<datalist id = "datalist id"> <!--미리 만들어놓은 틀-->
	<option>1</option>
  <option>2</option>
</datalist>
```

​            



### 공간 분할 태그

* div : block 형식으로 공간 분할, 웹사이트의 레이아웃(전체 틀)을 만들 때 사용, div 태그를 사용해 각각 CSS를 적용
* span : inline 형식으로 공간을 분할
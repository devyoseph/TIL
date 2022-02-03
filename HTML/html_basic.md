# Web

​    

## HTML

> **Hyper Text** Markup Language:
>
> * 참조(하이퍼링크)를 통해 사용자가 한 문서에서 다른 문서로 즉시 접근할 수 있는 텍스트

​    

### 현재의 웹 표준

| W3C   | WHATWG               |
| ----- | -------------------- |
| HTML5 | HTML Living Standard |

​	    

### 브라우저

> 익스플로러는 브라우저가 아니다. 크롬만이 브라우저이다.

* Can I Use

  > HTML 기술을 도입할 때 지원 가능한지 확인하는 사이트
  >
  > https://caniuse.com/

​    

### Visual Studio Code 세팅

* Open in browser
* Auto rename tag
* Hightlight Matching Tag

​    

#### Markup Language

* 태그 등을 이용하여 문서나 데이터의 구조를 명시하는 언어
  * ex) HTML, Markdown

​    

### HTML 기본 구조

* html: 문서의 최상위(root)요소

* head: 문서 메타데이터 요소

  * 메타 데이터를 표현하는 새로운 규약

    ​	ex) OG(Open Graph Protocol): 링크를 보낼 때 카드형식으로 나타나는 것

    ```html
    <meta property="og:image" content="https://www.youtube.com/img/desktop/yt_1200.png">
    ```

  * 문서 제목, 인코딩, 스타일, 외부 파일 로딩 등

    > \<title> \<meta> \<link> \<script> \<style>

  * 일반적으로 브라우저에 나타나지 않는 내용

* body: 문서 본문 요소

  * 실제 화면 구성과 관련된 내용

```html
<!DOCTYPE html>
<html lang="ko">

<head>
 	<meta charset="UTF-8">
  <title>Document</title>
</head>

<body>
</body>

</html>
```

​    

### DOM(Document Object Model) 트리

* 텍스트 파일인 HTML 문서를 브라우저에서 렌더링 하기 위한 구조
  * HTML 문서에 대한 모델을 구성함
  * HTML 문서 내의 각 요소에 접근/수정에 필요한 프로퍼티와 메서드를 제공함

```html
<body>
 	<h1> 웹문서 </h1>
  <ul>
    <li>HTML</li>
    <li>CSS</li>
  </ul>
</body>
```

* 마크업 스타일 가이드(2 space)

​      

#### 요소(element)

> HTML의 요소는 태그와 내용(contents)로 구성되어 있다.

```html
<h1> 여는 태그
  내용
</h1> 닫는 태그
```

​      

* 내용이 없는 태그들

  > br, hr, img, link, meta

​       

* 요소는 중첩(nested)될 수 있음
  * 요소의 중첩을 통해 하나의 문서를 구조화
  * 여는 태그와 닫는 태그의 쌍을 잘 확인해야함
    * 오류를 반환하는 것이 아닌 그냥 레이아웃이 깨진 상태로 출력되기에 디버깅이 힘들어 질 수 있음

​      

#### 속성(attribute)

* "쌍따옴표" 사용

  * 태그별로 사용할 수 있는 속성이 다르다

    ​     \- 속성을 통해 태그의 부가적인 정보 설정

    ​	 \- HTML Global Attribute: 태그와 상관없이 사용 가능 

* 속성명과 속성값 사이 **공백은 NO**

```html
<a 속성명="속성값"></a>
```

​     

##### [ HTML Global Attribute ]

* 모든 HTML 요소가 공통으로 사용할 수 있는 대표적인 속성

  * id : 문서 전체에서 유일한 고유 식별자 지정

  * class : 공백으로 구분된 해당 요소의 클래스 목록

  * data-* : 페이지에 개인 사용자 정의 데이터 저장

  * style : inline  스타일

  * title : 요소에 대한 추가 정보 지정

  * tabindex : 요소의 탭 순서

    > 탭을 눌렀을 때 다음 탭의 위치를 지정

​      

#### [ 시맨틱 태그 ]

* HTML5에서 의미론적 요소를 담은 태그 등장

  * 기존 영역을 의미하는 div 태그를 대체

    >header : 문서 전체나 섹션의 헤더(머리말)
    >
    >nav : 내비게이션
    >
    >aside : 사이드에 위치한 공간
    >
    >section : 문서의 일반적인 구분, 컨텐츠의 그룹을 표현
    >
    >article : 문서, 페이지, 사이트 안에서 독립적으로 구분되는 영역
    >
    >footer : 문서 전체나 섹션의 푸터(마지막 부분) 

    ​     

* Non semantic 요소

  > div span 등이 있으며 h1, table 태그들도 시맨틱 태그로 볼 수 있음

  * 시맨틱 요소를 사용하는 이유: 의미를 가지는 태그를 사용해 가독성을 높히고 유지보수를 쉽게 함

​      

​    

## HTML 문서 구조화

​    

### 인라인 / 블록 요소

* CSS에서 다루는 내용

​    

### 텍스트 요소

> *시멘틱 태그를 위주로 암기

| 태그                                  | 설명                                                   |
| ------------------------------------- | ------------------------------------------------------ |
| ```<a></a>```                         | href 속성을 활용해 다른 URL로 연결하는 하이퍼링크 생성 |
| ```<b></b>``` ```<strong></strong>``` | 굵은 글씨 요소, 중요한 내용 강조                       |
| ```<i></i>``` ```<em></em>```         | 기울임 글씨 요소, 중요한 내용 강조                     |
| ```<br>```                            | 텍스트 내에 줄 바꿈 생성                               |
| ```<img>```                           | src 속성을 활용하여 이미지 표현                        |
| ```<span></span>```                   | 의미 없는 인라인 컨테이너                              |

​    

### 그룹 컨텐츠

| 태그                            | 설명                                                         |
| ------------------------------- | ------------------------------------------------------------ |
| ```<p></p>```                   | 하나의 문단(paragraph), 블록                                 |
| ```<hr>```                      | 문단 레벨 요소에서의 주제의 분리를 의미, 수평선 표현(A Horizontal Rule) |
| ```<ol></ol>``` ```<ul></ul>``` | 순서가 있는(ordered) 리스트 , 순서가 없는(unordered) 리스트  |
| ```<pre></pre>```               | HTML에 작성한 내용을 그대로 표현, 보통 고정폭 글꼴이 사용되며 공백 유지 |
| ```<blockquote></blockquote>``` | 텍스트가 긴 인용문, 주로 들여쓰기 한 것으로 표현             |
| ```<div></div>```               | 의미 없는 블록 레벨 컨테이너                                 |

​       

#### table

* table의 각 영역을 명시하기 위해 \<thead> \<tbody> \<tfoot> 요소를 활용

  > thread = 상단 부분
  >
  > tr : 가로 줄 구성(row)
  >
  > th : 테이블 헤더부분(header)
  >
  > td : 셀 부분

* colspan, rowspan

  > caption : 테이블명 (테이블 아래 이름 부분)

```html
  <body>
    <table>
      <thead>
        <tr>
          <th>ID</th>
          <th>Name</th>
          <th>Major</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>1</td>
          <td>김철수</td>
          <td>컴퓨터 사이언스</td>
        </tr>
        <tr>
          <td>2</td>
          <td>홍길동</td>
          <td>비즈니스</td>
        </tr>
      </tbody>
      <tfoot>
        <tr>
          <td>총계</td>
          <td colspan="2">2명</td>
        </tr>
      </tfoot>
      <caption>학생 명단</caption>
    </table>
  </body>
```

* 기본 구조
  * thead / tbody / tfoot
  * tr - th , tr - colspan, rowspan

​    

### *** form

> ```<form>```은 **정보(데이터)를 서버에 제출하기 위한 영역**

* \<form> 기본 속성
  * action : form을 처리할 서버의 URL
  * method : form을 제출할 때 사용할 HTTP 메서드 (GET, POST)
  * enctype : method가 post인 경우 데이터 유형
    * application/x-www-form-urlencoded : 기본값
    * multipart/form-data : 파일 전송시 (input type이 file인 경우)
    * (text/plain): HTML5 디버깅 용 (잘 사용X)

​     

### ** input

* 다양한 타입을 가지는 입력 데이터 유형과 위젯이 제공

* ```<input>``` 대표적인 속성

  * name : form control에 적용되는 이름 (이름/값 페어로 전송됨)
  * value : form control에 적용되는 값 (이름/값 페어로 전송됨)

  ​      

  * type

    * ```type="submit"```

      ```html
      <input type="submit" value="제출"> <!--form tag 내부에 입력 받은 data를 form action 주소로 보냄-->
      ```

      ```html
      <form action="ssafy">  현재 접속중인 주소/ssafy
      <form action="/ssafy"> 메인 도메인/ssafy  
      ```

    * checkbox : 다중 선택, radio : 단일 선택

    * hidden : 사용자에게 보이지 않는 input

    ​    

  * 단일 속성: required(필수 입력), readonly(읽기만 하는 값), autofocus(자동 포커스), autocomplete(자동 완성), disabled 등

    > 속성명="속성값" 형태가 아닌, **속성명만** 적음 

    ​              

    ​     

* label

  * label을 클릭하면 input 으로 영역을 확장해서 활성화 할 수 있음

    ```html
      <label for="agreement">개인정보 수집에 동의합니다</label>
      <input type="checkbox" name="agreement" id="agreement">
    ```

    > label의 for + input의 id

    ​    

* 실습

```html
<form action="">
    <h2>Form 활용 실습</h2>
    
    <label for="id">아이디</label>
    <input type="text" name="id" id="id">
    
    <label for="password">비밀번호</label>
    <input type="password" value="" id="password">
  
    <label for="email">이메일</label>
    <input type="email" id="email">

    <label for="number">number 입력</label>
    <input type="number" id="number" step="5">

    <label for="file">File</label>
    <input type="file" id="file">

    <label for="check">HTML</label>
    <input type="checkbox" id="check" name="language">
    <label for="check2">Python</label>
    <input type="checkbox" id="check2" name="language">

    <hr>
    <!--라디오버튼의 경우: name이 같아야 적용된다-->
    <label for="check3">남자</label>
    <input type="radio" id="check3" value="남자" name="gender">
    <label for="check4">여자</label>
    <input type="radio" id="check4" value="여자" name="gender">

    <div>
      <label for="agreement">개인정보 수집에 동의합니다</label>
    </div>
    <input type="checkbox" name="agreement" id="agreement">
  
    <div>
      <label for="final">최종 제출을 확인합니다.</label>
    </div>
    
    <input type="checkbox", name="final", id="final">
  
    <input type="submit" value="제출">
  </form>
```

​    

* 실습2: **select 활용해서 목록 상자 만들기**

```html
  <form action="">
    
    <header>
      <h2>SSAFY 학생 건강 설문</h2>  
    </header>

    <section>
      <label for="name">이름을 기재해주세요.</label>
      <br>
      <input type="text" name="name" id="name">
      

      <hr>
      <label for="region">지역을 입력해주세요.</label>
      <br>
      <select name="region" id="region">
        <option value="">선택</option>
        <option value="gm">구미</option>
        <option value="se">서울</option>
        <option value="bu">부산</option>
        <option value="de">대전</option>
        <option value="gw">광주</option>
      </select>
      

      <hr>
      <p>오늘의 체온을 선택해주세요.</p>

      <label for="rad1">37.5 미만</label>
      <input type="radio" name="rad" id="rad1">
      <br>
      <label for="rad2">37.5 이상</label>
      <input type="radio" name="rad" id="rad2">

      <hr>
      <input type="submit" value="제출">
     
    </section>

    <footer>
      <p>Goole 설문지를 통해 비밀번호를 제출하지 마시오</p>
    </footer>
  </form>
```


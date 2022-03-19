## 프론트 엔드 요약 정리

​       

### HTML

1. HTML 의 시작

   ```html
   <!DOCTYPE html>
   ```

2. HTML의 특수문자 `&`

| 특수문자 | 내용            |
| -------- | --------------- |
| `&nbsp;` | 공백            |
| `&lt;`   | Less than(<)    |
| `&gt;`   | Greater than(<) |
| `&amp;`  | &, Ampersand    |
| `&quot;` | "               |
| `&copy;` | &copy;          |
| `&reg;`  | &reg;           |

3. 포맷팅 요소

```html
<pre> 공백 줄바꿈 등 입력된 그대로 화면에 표시
<code> 컴퓨터 소스 코드
</code>
</pre>
```

4. 테이블

```html
<table>
<thead> <tbody> <tfoot>
<tr>
<th> <td>
속성: colspan="2" rowspan = "2"
  주의점: 1. span을 쓰고난 행 이후 그 자리에 데이터를 비워야한다.
  			2. tr, th 같은 최하위 요소에 사용한다
```

```html
<table>
  <tr>
    <th colspan="3">1</th>
    <!--뒤에 2개를 쓰지 않는다-->
  </tr>
  <tr>
    <th rowspan="2">1</th>
    <th>1</th>
    <th>1</th>
  </tr>
  <tr>
    <th>1</th>
    <th>1</th>
  </tr>
</table>
```

5. Anchor 태그
   * href 사용
   * target 속성: `_self`, `_blank`, `_paent`, `_top`
6. **경로 정리**

| 태그   | 경로 속성   |
| ------ | ----------- |
| img    | src         |
| link   | href (+rel) |
| a      | href        |
| iframe | Src         |
|        |             |
|        |             |

7. **form 태그**

| 속성          | 설명                                                         |
| ------------- | ------------------------------------------------------------ |
| method        | 사용자가 입력한 내용을 서버 쪽 프로그램으로 어떻게 넘겨줄지 지정 |
| method="get"  | 주소 표시줄에 사용자가 입력한 내용 표시. 256~2048bytes의 데이터만 전송 |
| method="post" | HTTP 메세지의 Body에 담아서 전송하기 때문에 전송 내용 길이 제한X<br />사용자가 입력한 내용이 표시X |
| name          | form의 이름 지정                                             |
| action        | `<form>` 태그 안 내용을 처리해줄 서버상 프로그램 지정(URL)   |
| target        | `<action>` 태그에서 지정한 스크립트 파일을 현재 창이 아닌 다른 위치에 열도록 지정 |
| autocomplete  | 자동완성 기능, 기본값 on                                     |

7. input 태그 속성들

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

| 속성                     | 설명                                                         |
| ------------------------ | ------------------------------------------------------------ |
| autofocus                | 페이지 로딩 후 마우스 커서 표시                              |
| placeholder=""           | 텍스트 입력시 적당한 힌트 표시                               |
| readonly                 | =true, 등으로 지정                                           |
| **required**             | submit 하기 전에 필수적으로 입력해야 하는 부분 체크          |
| min,max,step             |                                                              |
| size,minlength,maxlength |                                                              |
| Height,width             |                                                              |
| list                     | `<datalist>` 에 미리 정의해 놓은 옵션 값을`<input>` 안에 나열해 보여줌 |
| multiple                 | type이 `email`이나 `file` 등 두 개 이상일 때 두 개 이상 값을 입력 |

​    

## CSS

